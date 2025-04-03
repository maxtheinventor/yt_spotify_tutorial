import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt_spotify_tutorial/core/theme/theme.dart';
import 'package:yt_spotify_tutorial/features/auth/view/pages/signup_page.dart';
import 'package:yt_spotify_tutorial/features/auth/viewmodel/auth_viewmodel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //With this, we initialize the shared preferences before running the APP
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  final userModel =
      await container.read(authViewModelProvider.notifier).getData();
  print(userModel);
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Music App',
      theme: AppTheme.darkThemeMode,
      home: const SignupPage(),
    );
  }
}
