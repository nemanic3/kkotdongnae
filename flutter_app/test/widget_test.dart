import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kkotdongnae/presentation/screens/auth/login_screen.dart';
import 'package:kkotdongnae/core/theme/app_theme.dart';

void main() {
  for (final size in [const Size(390, 844), const Size(1440, 900)]) {
    testWidgets('Login layout and validation at $size', (tester) async {
      tester.view.physicalSize = size;
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);
      await tester.pumpWidget(ProviderScope(child: MaterialApp(
        theme: AppTheme.lightTheme, home: const LoginScreen())));
      expect(find.text('꽃동네'), findsOneWidget);
      await tester.ensureVisible(find.widgetWithText(ElevatedButton, '로그인'));
      await tester.tap(find.widgetWithText(ElevatedButton, '로그인'));
      await tester.pump();
      expect(find.text('이메일을 입력해주세요'), findsOneWidget);
      expect(find.text('비밀번호를 입력해주세요'), findsOneWidget);
      expect(tester.takeException(), isNull);
    });
  }
}
