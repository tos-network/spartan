import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sallet/features/logger/logger.dart';
import 'package:sallet/src/generated/l10n/app_localizations.dart';
import 'package:window_manager/window_manager.dart';
import 'package:sallet/features/authentication/application/authentication_service.dart';
import 'package:sallet/features/router/router.dart';
import 'package:sallet/features/settings/application/settings_state_provider.dart';
import 'package:sallet/features/settings/domain/settings_state.dart';
import 'package:sallet/shared/resources/app_resources.dart';
import 'package:sallet/shared/theme/dark.dart';
import 'package:sallet/shared/theme/light.dart';
import 'package:sallet/shared/theme/tos.dart';
import 'package:sallet/shared/widgets/app_initializer.dart';

class Sallet extends ConsumerStatefulWidget {
  const Sallet({super.key});

  @override
  ConsumerState<Sallet> createState() => _SalletState();
}

class _SalletState extends ConsumerState<Sallet> with WindowListener {
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
