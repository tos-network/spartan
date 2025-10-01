import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallet/features/settings/application/app_localizations_provider.dart';
import 'package:sallet/features/settings/application/settings_state_provider.dart';
import 'package:sallet/features/wallet/application/wallet_provider.dart';
import 'package:sallet/features/wallet/presentation/address_book/address_widget.dart';
import 'package:sallet/features/wallet/presentation/wallet_navigation_bar/components/logo.dart';
import 'package:sallet/shared/resources/app_resources.dart';
import 'package:sallet/shared/theme/constants.dart';
import 'package:sallet/shared/theme/extensions.dart';
import 'package:sallet/shared/utils/utils.dart';
import 'package:tos_dart_sdk/tos_dart_sdk.dart';

class OutgoingEntryContent extends ConsumerWidget {
  const OutgoingEntryContent(this.outgoingEntry, {super.key});

  final OutgoingEntry outgoingEntry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = ref.watch(appLocalizationsProvider);
    final network = ref.watch(
      walletStateProvider.select((state) => state.network),
    );
    final knownAssets = ref.watch(
      walletStateProvider.select((state) => state.knownAssets),
    );
    final hideZeroTransfer = ref.watch(
      settingsProvider.select(
        (value) => value.historyFilterState.hideZeroTransfer,
      ),
    );
    final hideExtraData = ref.watch(
      settingsProvider.select(
        (value) => value.historyFilterState.hideExtraData,
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.fee,
          style: context.labelLarge?.copyWith(
            color: context.moreColors.mutedColor,
          ),
        ),
        const SizedBox(height: Spaces.extraSmall),
        SelectableText(
          formatTos(outgoingEntry.fee, network),
          style: context.bodyLarge,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: Spaces.medium),
            Text(
              loc.transfers,
              style: context.labelLarge?.copyWith(
                color: context.moreColors.mutedColor,
              ),
            ),
            const Divider(),
            Builder(
              builder: (BuildContext context) {
                var transfers = outgoingEntry.transfers;

                if (hideZeroTransfer) {
                  transfers = transfers
                      .skipWhile((value) {
                        return value.amount == 0;
                      })
                      .toList(growable: false);
                }

                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: transfers.length,
                  itemBuilder: (BuildContext context, int index) {
                    final transfer = transfers[index];
                    final isTos = transfer.asset == tosAsset;
                    final tosImagePath =
                        AppResources.greenBackgroundBlackIconPath;

                    String asset;
                    String amount;
                    if (knownAssets.containsKey(transfer.asset)) {
                      final assetData = knownAssets[transfer.asset]!;
                      asset = assetData.name;
                      amount =
                          '-${formatCoin(transfer.amount, assetData.decimals, assetData.ticker)}';
                    } else {
                      asset = truncateText(transfer.asset, maxLength: 20);
                      amount = '-${transfer.amount.toString()}';
                    }

                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(Spaces.medium),
                        child: Column(
                          children: [
                            AddressWidget(transfer.destination),
                            const Divider(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      loc.asset.toLowerCase(),
                                      style: context.labelLarge?.copyWith(
                                        color: context.moreColors.mutedColor,
                                      ),
                                    ),
                                    isTos
                                        ? Row(
                                            children: [
                                              Logo(imagePath: tosImagePath),
                                              const SizedBox(
                                                width: Spaces.small,
                                              ),
                                              Text(AppResources.tosName),
                                            ],
                                          )
                                        : SelectableText(asset),
                                  ],
                                ),
                                const SizedBox(width: Spaces.medium),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      loc.amount,
                                      style: context.labelLarge?.copyWith(
                                        color: context.moreColors.mutedColor,
                                      ),
                                    ),
                                    SelectableText(amount),
                                  ],
                                ),
                              ],
                            ),
                            if (!hideExtraData &&
                                transfer.extraData != null) ...[
                              const SizedBox(height: Spaces.medium),
                              Column(
                                children: [
                                  Text(
                                    loc.extra_data,
                                    style: context.labelMedium?.copyWith(
                                      color: context.moreColors.mutedColor,
                                    ),
                                  ),
                                  SelectableText(transfer.extraData.toString()),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
