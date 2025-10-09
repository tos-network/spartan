import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spartan/shared/theme/extensions.dart';
import 'package:spartan/features/settings/application/app_localizations_provider.dart';
import 'package:spartan/shared/theme/constants.dart';
import 'package:spartan/shared/utils/utils.dart';
import 'package:spartan/shared/widgets/components/generic_dialog.dart';

class SeedContentDialog extends ConsumerStatefulWidget {
  const SeedContentDialog(this.seed, {super.key});

  final List<String> seed;

  @override
  ConsumerState<SeedContentDialog> createState() => _SeedContentDialogState();
}

class _SeedContentDialogState extends ConsumerState<SeedContentDialog> {
  @override
  Widget build(BuildContext context) {
    final loc = ref.watch(appLocalizationsProvider);
    return GenericDialog(
      scrollable: false,
      content: SizedBox(
        width: 800,
        height: 400,
        child: ClipRect(
          child: Scrollbar(
            thumbVisibility: true,
            child: SingleChildScrollView(
              padding: const EdgeInsets.only(right: 12, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Flexible(
                          child: Text(
                            '${loc.recovery_phrase.toLowerCase().capitalize()}:',
                            style: context.titleLarge,
                          ),
                        ),
                        IconButton.outlined(
                          onPressed: () => copyToClipboard(
                            widget.seed.join(" "),
                            ref,
                            loc.copied,
                          ),
                          icon: Icon(Icons.copy, size: 18),
                          tooltip: loc.copy_recovery_phrase,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: Spaces.small),
                  GridView.count(
                    crossAxisCount: context.isHandset ? 2 : 3,
                    semanticChildCount: widget.seed.length,
                    childAspectRatio: 8,
                    mainAxisSpacing: Spaces.extraSmall,
                    crossAxisSpacing: Spaces.small,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: widget.seed.indexed
                        .map<Widget>(
                          ((int index, String word) tuple) => Container(
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.4),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: Spaces.small,
                                vertical: Spaces.extraSmall,
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        '${tuple.$1 + 1}',
                                        style: context.bodyLarge?.copyWith(
                                          color: context.colors.primary,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        tuple.$2,
                                        style: context.titleMedium,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: Spaces.large),
                ],
              ),
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(loc.continue_button),
        ),
      ],
    );
  }
}
