import 'package:spartan/shared/storage/persistent_state.dart';
import 'package:spartan/features/wallet/domain/network_nodes_state.dart';
import 'package:spartan/features/logger/logger.dart';
import 'package:spartan/shared/resources/app_resources.dart';
import 'package:spartan/shared/storage/shared_preferences/spartan_shared_preferences.dart';

class NetworkNodesStateRepository extends PersistentState<NetworkNodesState> {
  NetworkNodesStateRepository(this.spartanSharedPreferences);

  SpartanSharedPreferences spartanSharedPreferences;
  static const storageKey = 'network_nodes';

  @override
  NetworkNodesState fromStorage() {
    try {
      final value = spartanSharedPreferences.get(key: storageKey);
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
    await spartanSharedPreferences.delete(key: storageKey);
  }

  @override
  Future<void> localSave(NetworkNodesState state) async {
    final value = state.toJson();
    await spartanSharedPreferences.save(key: storageKey, value: value);
  }
}
