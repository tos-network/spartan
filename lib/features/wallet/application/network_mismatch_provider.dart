import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallet/features/settings/application/settings_state_provider.dart';
import 'package:sallet/features/wallet/application/node_info_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tos_dart_sdk/tos_dart_sdk.dart' as sdk;
import 'package:sallet/src/generated/rust_bridge/api/models/network.dart'
    as rust;

part 'network_mismatch_provider.g.dart';

@riverpod
bool networkMismatch(Ref ref) {
  final walletNetwork = ref.watch(
    settingsProvider.select((state) => state.network),
  );
  final nodeNetwork = ref.watch(
    nodeInfoProvider.select((state) => state.valueOrNull?.network),
  );

  bool mismatch = false;
  switch (nodeNetwork) {
    case sdk.Network.mainnet:
      if (walletNetwork != rust.Network.mainnet) {
        mismatch = true;
      }
    case sdk.Network.testnet:
      if (walletNetwork != rust.Network.testnet) {
        mismatch = true;
      }
    case sdk.Network.dev:
      if (walletNetwork != rust.Network.dev) {
        mismatch = true;
      }
    case null:
      mismatch = false;
  }

  return mismatch;
}
