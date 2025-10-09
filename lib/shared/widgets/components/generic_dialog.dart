import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:spartan/shared/theme/constants.dart';

class GenericDialog extends StatelessWidget {
  const GenericDialog({
    super.key,
    this.scrollable = true,
    this.title,
    this.content,
    this.actions,
  });

  final bool scrollable;
  final Widget? title;
  final Widget? content;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: const EdgeInsets.symmetric(horizontal: 40, vertical: 80),
        child: IntrinsicHeight(
          child: IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(minWidth: 280),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color(
                      0xFFe44b44,
                    ).withValues(alpha: 0.3), // Red glow bottom-left
                    const Color(0xFF0d1d29), // Deep blue-black center
                    const Color(
                      0xFF03ca9b,
                    ).withValues(alpha: 0.25), // Teal-green glow top-right
                  ],
                  stops: const [0.0, 0.5, 1.0],
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (title != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Spaces.none,
                        Spaces.small,
                        Spaces.none,
                        Spaces.small,
                      ),
                      child: title!,
                    ),
                  if (content != null)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        Spaces.medium,
                        Spaces.none,
                        Spaces.medium,
                        Spaces.medium,
                      ),
                      child: ClipRect(child: content!),
                    ),
                  if (actions != null)
                    Container(
                      decoration: BoxDecoration(color: const Color(0xFF0d1d29)),
                      padding: const EdgeInsets.fromLTRB(
                        Spaces.medium,
                        Spaces.medium,
                        Spaces.medium,
                        Spaces.medium,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: actions!,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
