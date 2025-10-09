import 'package:country_flags/country_flags.dart';
import 'package:flutter/widgets.dart';
import 'package:spartan/features/wallet/domain/node_address.dart';
import 'package:spartan/src/generated/l10n/app_localizations.dart';
import 'package:tos_dart_sdk/tos_dart_sdk.dart' as sdk;
// import 'package:jovial_svg/jovial_svg.dart';

class AppResources {
  static const String tosWalletName = 'Spartan';

  static const String userWalletsFolderName = 'Spartan wallets';

  static const String zeroBalance = '0.00000000';

  static const String tosHash = sdk.tosAsset;

  static const String tosName = 'TOS';

  static const int tosDecimals = 8;

  static List<NodeAddress> mainnetNodes = [
    const NodeAddress(
      name: 'Seed Node US #1',
      url: 'us-node.tos.network', // SDK will add wss:// and /json_rpc
    ),
    const NodeAddress(name: 'Seed Node France #1', url: 'fr-node.tos.network'),
    const NodeAddress(name: 'Seed Node Germany #1', url: 'de-node.tos.network'),
    const NodeAddress(name: 'Seed Node Poland #1', url: 'pl-node.tos.network'),
    const NodeAddress(
      name: 'Seed Node Singapore #1',
      url: 'sg-node.tos.network',
    ),
    const NodeAddress(
      name: 'Seed Node United Kingdom #1',
      url: 'uk-node.tos.network',
    ),
    const NodeAddress(name: 'Seed Node Canada #1', url: 'ca-node.tos.network'),
  ];

  static List<NodeAddress> testnetNodes = [
    const NodeAddress(
      name: 'Official TOS Testnet',
      url:
          sdk.testnetNodeURL, // SDK will add wss:// and /json_rpc automatically
    ),
  ];

  static List<NodeAddress> devNodes = [
    const NodeAddress(
      name: 'Default Local Node',
      url: sdk.localhostAddress, // SDK will add ws:// and /json_rpc
    ),
    const NodeAddress(
      name: 'Android simulator localhost',
      url: '10.0.2.2:8080', // SDK will add ws:// and /json_rpc
    ),
  ];

  static String explorerMainnetUrl = 'https://explorer.tos.network/';
  static String explorerTestnetUrl = 'https://testnet-explorer.tos.network/';

  /*static String svgIconGreenTarget =
      'https://raw.githubusercontent.com/tos-project/tos-assets/master/icons/svg/transparent/green.svg';
  static String svgIconBlackTarget =
      'https://raw.githubusercontent.com/tos-project/tos-assets/master/icons/svg/transparent/black.svg';
  static String svgIconWhiteTarget =
      'https://raw.githubusercontent.com/tos-project/tos-assets/master/icons/svg/transparent/white.svg';

  static late ScalableImage svgIconGreen;
  static late ScalableImage svgIconWhite;
  static late ScalableImage svgIconBlack;

  static ScalableImageWidget svgIconGreenWidget = ScalableImageWidget(
    si: AppResources.svgIconGreen,
    scale: 0.06,
  );

  static ScalableImageWidget svgIconBlackWidget = ScalableImageWidget(
    si: AppResources.svgIconBlack,
    scale: 0.06,
  );

  static ScalableImageWidget svgIconWhiteWidget = ScalableImageWidget(
    si: AppResources.svgIconWhite,
    scale: 0.06,
  );*/

  // static String svgBannerGreenPath =
  //     'assets/banners/svg/transparent_background_green_logo.svg';
  // static String svgBannerBlackPath =
  //     'assets/banners/svg/transparent_background_black_logo.svg';
  // static String svgBannerWhitePath =
  //     'assets/banners/svg/transparent_background_white_logo.svg';
  static const String greenBackgroundBlackIconPath =
      'assets/icons/png/circle/green_background_black_logo.png';
  static const String bgDotsPath = 'assets/bg_dots.png';

  // static late ScalableImage svgBannerGreen;
  // static late ScalableImage svgBannerWhite;
  // static late ScalableImage svgBannerBlack;
  static late Image bgDots;

  // static ScalableImageWidget svgBannerGreenWidget = ScalableImageWidget(
  //   si: AppResources.svgBannerGreen,
  //   scale: 0.15,
  // );
  //
  // static ScalableImageWidget svgBannerBlackWidget = ScalableImageWidget(
  //   si: AppResources.svgBannerBlack,
  //   scale: 0.15,
  // );
  //
  // static ScalableImageWidget svgBannerWhiteWidget = ScalableImageWidget(
  //   si: AppResources.svgBannerWhite,
  //   scale: 0.15,
  // );

  static List<CountryFlag> countryFlags = List.generate(
    AppLocalizations.supportedLocales.length,
    (int index) {
      String languageCode =
          AppLocalizations.supportedLocales[index].languageCode;
      switch (languageCode) {
        case 'zh':
          return CountryFlag.fromCountryCode(
            'CN',
            height: 24,
            width: 30,
            shape: const RoundedRectangle(8),
          );
        case 'ru' || 'pt' || 'nl' || 'pl':
          return CountryFlag.fromCountryCode(
            languageCode,
            height: 24,
            width: 30,
            shape: const RoundedRectangle(8),
          );
        case 'ko':
          return CountryFlag.fromCountryCode(
            'KR',
            height: 24,
            width: 30,
            shape: const RoundedRectangle(8),
          );
        case 'ms':
          return CountryFlag.fromCountryCode(
            'MY',
            height: 24,
            width: 30,
            shape: const RoundedRectangle(8),
          );
        case 'uk':
          return CountryFlag.fromCountryCode(
            'UA',
            height: 24,
            width: 30,
            shape: const RoundedRectangle(8),
          );
        case 'ja':
          return CountryFlag.fromCountryCode(
            'JP',
            height: 24,
            width: 30,
            shape: const RoundedRectangle(8),
          );
        case 'ar':
          return CountryFlag.fromCountryCode(
            'SA',
            height: 24,
            width: 30,
            shape: const RoundedRectangle(8),
          );
        default:
          return CountryFlag.fromLanguageCode(
            AppLocalizations.supportedLocales[index].languageCode,
            height: 24,
            width: 30,
            shape: const RoundedRectangle(8),
          );
      }
    },
    growable: false,
  );
}
