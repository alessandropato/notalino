import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../presentation/screens/home_screen.dart';
import '../presentation/screens/share_import_listener.dart';
import 'theme/app_theme.dart';

/// Root dell'app (SRD §1bis: nome "Notalino"). Tema light/dark dai token.
class NotalinoApp extends ConsumerWidget {
  const NotalinoApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Notalino',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      themeMode: ThemeMode.system,
      // Ascolta i file condivisi dalla share sheet e li instrada all'import.
      home: const ShareImportListener(child: HomeScreen()),
    );
  }
}
