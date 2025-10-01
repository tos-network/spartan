import 'dart:async';
import 'dart:collection';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:sallet/features/wallet/data/native_wallet_repository.dart';
import 'package:sallet/features/wallet/domain/multisig/multisig_state.dart';
import 'package:tos_dart_sdk/tos_dart_sdk.dart' as sdk;
import 'package:sallet/src/generated/rust_bridge/api/models/network.dart'
    as rust;

part 'wallet_snapshot.freezed.dart';

@freezed
abstract class WalletSnapshot with _$WalletSnapshot {
  factory WalletSnapshot({
    @Default(false) bool isOnline,
    @Default(0) int topoheight,
    @Default('') String tosBalance,
    required LinkedHashMap<String, String> trackedBalances,
    required LinkedHashMap<String, sdk.AssetData> knownAssets,
    @Default('') String address,
    @Default('') String name,
    @Default(MultisigState()) MultisigState multisigState,
    @Default(rust.Network.mainnet) rust.Network network,
    NativeWalletRepository? nativeWalletRepository,

    StreamSubscription<void>? streamSubscription,
  }) = _WalletSnapshot;
}
