import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:yt_spotify_tutorial/core/providers/current_user_notifier.dart';
import 'package:yt_spotify_tutorial/core/theme/theme.dart';
import 'package:yt_spotify_tutorial/features/auth/view/pages/signup_page.dart';
import 'package:yt_spotify_tutorial/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:yt_spotify_tutorial/features/home/view/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //With this, we initialize the shared preferences before running the APP
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).getData();
  runApp(UncontrolledProviderScope(container: container, child: const MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      title: 'Music App',
      theme: AppTheme.darkThemeMode,
      home: currentUser == null ? const SignupPage() : const HomePage(),
    );
  }
}
