import 'package:flutter/material.dart';
import 'package:spartan/features/wallet/presentation/wallet_navigation_bar/components/logo.dart';
import 'package:spartan/shared/resources/app_resources.dart';
import 'package:spartan/shared/theme/constants.dart';
import 'package:spartan/shared/utils/utils.dart';
import 'package:tos_dart_sdk/tos_dart_sdk.dart';

class AssetDropdownMenuItem {
  static DropdownMenuItem<String> fromMapEntry(
    MapEntry<String, String> balanceEntry,
    AssetData assetData, {
    bool showBalance = true,
  }) {
    final isTosAsset = balanceEntry.key == AppResources.tosHash;
    final tosImagePath = AppResources.greenBackgroundBlackIconPath;

    final assetName = assetData.name;
    final assetTicker = assetData.ticker;

    return DropdownMenuItem<String>(
      value: balanceEntry.key,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          isTosAsset
              ? Row(
                  children: [
                    Logo(imagePath: tosImagePath),
                    const SizedBox(width: Spaces.small),
                    Text(assetName),
                  ],
                )
              : Text(truncateText(assetName)),
          if (showBalance) Text('${balanceEntry.value} $assetTicker'),
        ],
      ),
    );
  }
}
