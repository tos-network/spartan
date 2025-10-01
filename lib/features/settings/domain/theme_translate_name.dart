import 'package:sallet/features/settings/domain/settings_state.dart';
import 'package:sallet/src/generated/l10n/app_localizations.dart';

String translateThemeName(AppLocalizations loc, AppTheme theme) {
  switch (theme) {
    case AppTheme.dark:
      return loc.dark;
    case AppTheme.light:
      return loc.light;
    case AppTheme.tos:
      return 'TOS';
  }
}
