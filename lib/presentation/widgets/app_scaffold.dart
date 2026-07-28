import 'package:flutter/material.dart';

import '../../app/theme/app_tokens.dart';

/// Scaffold di base con sfondo ambientale: la palette chiara con blob d'accento
/// sfocati dà profondità e fa risaltare le superfici vetro (SRD §10).
class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  @override
  Widget build(BuildContext context) {
    final AppTokens t = context.tokens;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: appBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      body: Stack(
        children: [
          // Sfondo ambientale decorativo.
          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(color: t.colors.background),
            ),
          ),
          Positioned(
            top: -80,
            right: -60,
            child: _Blob(color: t.colors.accentPrimary.withValues(alpha: 0.20)),
          ),
          Positioned(
            bottom: -100,
            left: -80,
            child:
                _Blob(color: t.colors.accentSecondary.withValues(alpha: 0.16)),
          ),
          Positioned.fill(child: SafeArea(bottom: false, child: body)),
        ],
      ),
    );
  }
}

class _Blob extends StatelessWidget {
  const _Blob({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: 280,
        height: 280,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
        ),
      ),
    );
  }
}
