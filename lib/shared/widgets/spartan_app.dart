import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spartan/features/logger/logger.dart';
import 'package:spartan/src/generated/l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';
import 'package:spartan/features/authentication/application/authentication_service.dart';
import 'package:spartan/features/router/router.dart';
import 'package:spartan/features/settings/application/settings_state_provider.dart';
import 'package:spartan/features/settings/domain/settings_state.dart';
import 'package:spartan/shared/resources/app_resources.dart';
import 'package:spartan/shared/theme/dark.dart';
import 'package:spartan/shared/theme/light.dart';
import 'package:spartan/shared/theme/tos.dart';
import 'package:spartan/shared/widgets/app_initializer.dart';

class Spartan extends ConsumerStatefulWidget {
  const Spartan({super.key});

  @override
  ConsumerState<Spartan> createState() => _SpartanState();
}

class _SpartanState extends ConsumerState<Spartan> with WindowListener {
  final _lightTheme = lightTheme();
  final _darkTheme = darkTheme();
  final _tosTheme = tosTheme();

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final router = ref.watch(routerProvider);
    final appTheme = ref.watch(settingsProvider.select((state) => state.theme));

    // using kDebugMode and call func every render to hot reload the theme
    ThemeData themeData;
    switch (appTheme) {
      case AppTheme.tos:
        themeData = kDebugMode ? tosTheme() : _tosTheme;
      case AppTheme.dark:
        themeData = kDebugMode ? darkTheme() : _darkTheme;
      case AppTheme.light:
        themeData = kDebugMode ? lightTheme() : _lightTheme;
    }

    return MaterialApp.router(
      title: AppResources.tosWalletName,
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      theme: themeData,
      routerConfig: router,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      builder: (context, child) {
        return AppInitializer(child: child!);
      },
    );
  }

  @override
  Future<void> onWindowClose() async {
    await ref.read(authenticationProvider.notifier).logout();
    talker.disable();
  }
}
