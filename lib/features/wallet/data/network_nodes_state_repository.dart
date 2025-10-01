import 'package:sallet/shared/storage/persistent_state.dart';
import 'package:sallet/features/wallet/domain/network_nodes_state.dart';
import 'package:sallet/features/logger/logger.dart';
import 'package:sallet/shared/resources/app_resources.dart';
import 'package:sallet/shared/storage/shared_preferences/sallet_shared_preferences.dart';

class NetworkNodesStateRepository extends PersistentState<NetworkNodesState> {
  NetworkNodesStateRepository(this.salletSharedPreferences);

  SalletSharedPreferences salletSharedPreferences;
  static const storageKey = 'network_nodes';

  @override
  NetworkNodesState fromStorage() {
    try {
      final value = salletSharedPreferences.get(key: storageKey);
      if (value == null) {
        return NetworkNodesState(
          mainnetAddress: AppResources.mainnetNodes.first,
          mainnetNodes: AppResources.mainnetNodes,
          testnetAddress: AppResources.testnetNodes.first,
          testnetNodes: AppResources.testnetNodes,
          devAddress: AppResources.devNodes.first,
          devNodes: AppResources.devNodes,
        );
      }
      return NetworkNodesState.fromJson(value as Map<String, dynamic>);
    } catch (e) {
      talker.critical('NetworkNodesStateRepository: $e');
      rethrow;
    }
  }

  @override
  Future<void> localDelete() async {
    await salletSharedPreferences.delete(key: storageKey);
  }

  @override
  Future<void> localSave(NetworkNodesState state) async {
    final value = state.toJson();
    await salletSharedPreferences.save(key: storageKey, value: value);
  }
}
