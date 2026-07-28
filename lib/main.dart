import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';

/// Bootstrap di Notalino (SRD §4). Tutto lo stato passa da [ProviderScope];
/// il DB Drift viene aperto pigramente al primo accesso.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const ProviderScope(child: NotalinoApp()));
}
