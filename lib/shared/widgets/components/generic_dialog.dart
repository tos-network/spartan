import 'dart:ui';

import 'package:flutter/material.dart';

import 'package:sallet/shared/theme/constants.dart';

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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1,
          ),
        ),
        backgroundColor: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
                const Color(0xFFe44b44).withValues(alpha: 0.3), // Red glow bottom-left
                const Color(0xFF0d1d29), // Deep blue-black center
                const Color(0xFF03ca9b).withValues(alpha: 0.25), // Teal-green glow top-right
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: AlertDialog(
            backgroundColor: Colors.transparent,
            surfaceTintColor: Colors.transparent,
            scrollable: scrollable,
            titlePadding: const EdgeInsets.fromLTRB(
              Spaces.none,
              Spaces.none,
              Spaces.none,
              Spaces.small,
            ),
            contentPadding: const EdgeInsets.fromLTRB(
              Spaces.medium,
              Spaces.medium,
              Spaces.medium,
              Spaces.large,
            ),
            actionsPadding: const EdgeInsets.fromLTRB(
              Spaces.medium,
              Spaces.none,
              Spaces.medium,
              Spaces.medium,
            ),
            title: title,
            content: AnimatedSize(
              alignment: Alignment.topCenter,
              duration: const Duration(milliseconds: AppDurations.animFast),
              child: content,
            ),
            actions: actions,
          ),
        ),
      ),
    );
  }
}
