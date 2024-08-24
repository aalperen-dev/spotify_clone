import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/core/theme/theme.dart';
import 'package:spotify/features/auth/view/pages/login_page.dart';
import 'package:spotify/features/auth/view/pages/signup_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.darkThemeMode,
      home: const SignupPage(),
    );
  }
}
