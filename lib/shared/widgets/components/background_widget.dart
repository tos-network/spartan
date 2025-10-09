import 'package:flutter/material.dart';
import 'package:spartan/shared/resources/app_resources.dart';
import 'package:spartan/shared/theme/extensions.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
        color:
            theme.colorScheme.surfaceContainerHighest, // Base dark background
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.bottomRight,
            radius: 1.2,
            colors: [
              const Color(
                0xFFe44b44,
              ).withValues(alpha: 0.25), // Red glow, subtle
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.0),
            ],
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.centerLeft,
              radius: 1.4,
              colors: [
                const Color(0xFF03ca9b).withValues(
                  alpha: 0.18,
                ), // Teal-green glow, slightly stronger and wider
                theme.colorScheme.surfaceContainerHighest.withValues(
                  alpha: 0.0,
                ),
              ],
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
