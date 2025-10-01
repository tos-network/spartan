import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallet/features/settings/application/app_localizations_provider.dart';
import 'package:sallet/features/wallet/application/wallet_provider.dart';
import 'package:sallet/features/wallet/presentation/xswd/components/transaction_builder_mixin.dart';
import 'package:sallet/shared/theme/extensions.dart';
import 'package:sallet/shared/utils/utils.dart';
import 'package:tos_dart_sdk/tos_dart_sdk.dart';

class BurnBuilderWidget extends ConsumerWidget with TransactionBuilderMixin {
  final BurnBuilder burnBuilder;

  const BurnBuilderWidget({super.key, required this.burnBuilder});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(appLocalizationsProvider);
    final knownAssets = ref.watch(
      walletStateProvider.select((state) => state.knownAssets),
    );

    String asset;
    String amount;
    if (knownAssets.containsKey(burnBuilder.asset)) {
      asset = knownAssets[burnBuilder.asset]!.name;
      amount = formatCoin(
        burnBuilder.amount,
        knownAssets[burnBuilder.asset]!.decimals,
        knownAssets[burnBuilder.asset]!.ticker,
      );
    } else {
      asset = burnBuilder.asset;
      amount = burnBuilder.amount.toString();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              loc.burn,
              style: context.bodyLarge!.copyWith(
                color: context.moreColors.mutedColor,
              ),
            ),
          ],
        ),
        buildLabeledText(context, loc.asset, asset),
        buildLabeledText(context, loc.amount.capitalize(), amount),
      ],
    );
  }
}
