import test from 'node:test';
import assert from 'node:assert/strict';
import {readFile} from 'node:fs/promises';
const source = await readFile(new URL('./_worker.js', import.meta.url), 'utf8');
const worker = (await import('data:text/javascript;base64,' + Buffer.from(source).toString('base64'))).default;
test('missing secret and preview domains cannot reach production', async () => {
  for (const host of ['kkotdongnae.nemanic.dev', 'preview.pages.dev']) {
    const response = await worker.fetch(new Request(`https://${host}/api/shops/`), {});
    assert.equal(response.status, 503);
    assert.equal(response.headers.get('cache-control'), 'no-store');
  }
});
test('assets pass through', async () => {
  const response = await worker.fetch(new Request('https://preview.pages.dev/'), {ASSETS: {fetch: () => new Response('asset')}});
  assert.equal(await response.text(), 'asset');
});
test('API preserves JWT, body, query and strips cookies; redirects blocked', async () => {
  const saved = globalThis.fetch;
  globalThis.fetch = async (url, options) => {
    assert.equal(url, 'https://kkotdongnae-origin.nemanic.dev/api/reviews/?x=1');
    assert.equal(options.headers.get('authorization'), 'Bearer fake-test-token');
    assert.equal(options.headers.get('cookie'), null);
    assert.equal(options.headers.get('x-origin-secret'), 'fake-private-test-secret');
    assert.equal(await new Response(options.body).text(), '{"rating":5}');
    return new Response(null, {status: 302});
  };
  try {
    const response = await worker.fetch(new Request('https://kkotdongnae.nemanic.dev/api/reviews/?x=1', {
      method: 'POST', body: '{"rating":5}', headers: {authorization: 'Bearer fake-test-token', cookie: 'private=value'},
    }), {DJANGO_ORIGIN: 'https://kkotdongnae-origin.nemanic.dev', ORIGIN_PROXY_SECRET: 'fake-private-test-secret'});
    assert.equal(response.status, 502);
  } finally { globalThis.fetch = saved; }
});
