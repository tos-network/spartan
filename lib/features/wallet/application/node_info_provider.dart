import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spartan/shared/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spartan/features/wallet/application/wallet_provider.dart';
import 'package:spartan/features/wallet/domain/daemon_info_snapshot.dart';

part 'node_info_provider.g.dart';

@riverpod
Future<DaemonInfoSnapshot?> nodeInfo(Ref ref) async {
  final walletState = ref.watch(walletStateProvider);
  final walletRepository = walletState.nativeWalletRepository;
  if (walletRepository != null) {
    var info = await walletRepository.getDaemonInfo();

    // keep the state of a successful (only) request
    ref.keepAlive();

    return DaemonInfoSnapshot(
      topoHeight: NumberFormat().format(info.topoHeight),
      pruned: info.prunedTopoHeight != null ? true : false,
      circulatingSupply: formatTos(
        info.circulatingSupply ?? 0,
        walletState.network,
      ),
      burnSupply: formatTos(info.burnedSupply ?? 0, walletState.network),
      averageBlockTime: Duration(milliseconds: info.averageBlockTime ?? 0),
      mempoolSize: info.mempoolSize,
      blockReward: formatTos(info.blockReward ?? 0, walletState.network),
      version: info.version,
      network: info.network,
    );
  }
  return null;
}
