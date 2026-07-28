import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../app/theme/app_tokens.dart';

/// Logo di Notalino (SVG vettoriale). Mono-colore: ricolorabile via [color]
/// (default = accento del tema). Usato in home/caricamento e come icona chat.
class AppLogo extends StatelessWidget {
  const AppLogo({super.key, this.size = 28, this.color});

  final double size;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final Color c = color ?? context.tokens.colors.accentPrimary;
    return SvgPicture.asset(
      'assets/notalino_icon.svg',
      width: size,
      height: size,
      colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
    );
  }
}
