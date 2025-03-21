import 'package:flutter/material.dart';
import 'package:yt_spotify_tutorial/core/theme/theme.dart';
import 'package:yt_spotify_tutorial/features/auth/view/pages/login_page.dart';
import 'package:yt_spotify_tutorial/features/auth/view/pages/signup_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.darkThemeMode,
      home: const LoginPage(),
    );
  }
}
