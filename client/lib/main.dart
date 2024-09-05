import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/core/providers/current_user_notifier.dart';
import 'package:spotify/core/theme/theme.dart';
import 'package:spotify/features/auth/viewmodel/auth_viewmodel.dart';
import 'package:spotify/features/home/view/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPreferences();
  await container.read(authViewModelProvider.notifier).getData();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MainApp(),
    ),
  );
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserNotifierProvider);
    return MaterialApp(
      title: 'Spotify Clone',
      theme: AppTheme.darkThemeMode,
      // home: currentUser == null ? const SignupPage() : const UploadSongPage(),
      home: const HomePage(),
    );
  }
}
