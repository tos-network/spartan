import 'package:flutter/material.dart';
import 'package:spartan/features/settings/domain/settings_state.dart';
import 'package:spartan/shared/storage/persistent_state.dart';
import 'package:spartan/features/logger/logger.dart';
import 'package:spartan/shared/storage/shared_preferences/spartan_shared_preferences.dart';
import 'package:spartan/src/generated/l10n/app_localizations.dart';

class SettingsStateRepository extends PersistentState<SettingsState> {
  SettingsStateRepository(this.spartanSharedPreferences);

  final SpartanSharedPreferences spartanSharedPreferences;
  static const storageKey = 'settings';

  @override
  SettingsState fromStorage() {
    try {
      final value =
          spartanSharedPreferences.get(key: storageKey)
              as Map<String, dynamic>?;
      if (value == null) {
        var locale = const Locale('en');

        // check user system language and apply if available
        final languageCode =
            WidgetsBinding.instance.platformDispatcher.locale.languageCode;
        if (AppLocalizations.supportedLocales.contains(Locale(languageCode))) {
          locale = Locale(languageCode);
        }

        return SettingsState(locale: locale);
      }

      return SettingsState.fromJson(value);
    } catch (e) {
      talker.critical('SettingsStateRepository: $e');
      rethrow;
    }
  }

  @override
  Future<void> localDelete() async {
    await spartanSharedPreferences.delete(key: storageKey);
  }

  @override
  Future<void> localSave(SettingsState state) async {
    final value = state.toJson();
    await spartanSharedPreferences.save(key: storageKey, value: value);
  }
}
