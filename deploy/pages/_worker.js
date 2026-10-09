export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    if (!url.pathname.startsWith('/api/')) return env.ASSETS.fetch(request);
    const headers = new Headers({'Content-Type': 'application/json', 'Cache-Control': 'no-store'});
    if (url.hostname !== 'kkotdongnae.nemanic.dev' || !env.DJANGO_ORIGIN || !env.ORIGIN_PROXY_SECRET)
      return new Response(JSON.stringify({detail: '서비스 연결을 준비 중입니다.'}), {status: 503, headers});
    const origin = new URL(env.DJANGO_ORIGIN);
    if (origin.protocol !== 'https:' || origin.hostname !== 'kkotdongnae-origin.nemanic.dev' || origin.pathname !== '/')
      return new Response(JSON.stringify({detail: 'Service configuration unavailable'}), {status: 503, headers});
    const upstreamHeaders = new Headers();
    for (const name of ['authorization', 'content-type', 'accept']) {
      if (request.headers.has(name)) upstreamHeaders.set(name, request.headers.get(name));
    }
    upstreamHeaders.set('X-Origin-Secret', env.ORIGIN_PROXY_SECRET);
    upstreamHeaders.set('X-Forwarded-Proto', 'https');
    try {
      const upstream = await fetch(origin.origin + url.pathname + url.search, {
        method: request.method, headers: upstreamHeaders,
        body: ['GET', 'HEAD'].includes(request.method) ? undefined : request.body,
        redirect: 'manual', signal: AbortSignal.timeout(25000),
      });
      if (upstream.status >= 300 && upstream.status < 400)
        return new Response(JSON.stringify({detail: 'Unexpected upstream redirect'}), {status: 502, headers});
      headers.set('Content-Type', upstream.headers.get('Content-Type') || 'application/json');
      return new Response(upstream.body, {status: upstream.status, headers});
    } catch (_) {
      return new Response(JSON.stringify({detail: '서비스에 연결할 수 없습니다. 잠시 후 다시 시도해 주세요.'}), {status: 503, headers});
    }
  },
};
