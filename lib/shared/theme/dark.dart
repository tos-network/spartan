import 'package:flutter/material.dart';
import 'package:spartan/shared/theme/constants.dart';
import 'package:spartan/shared/theme/more_colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData darkTheme() {
  const textColor = Colors.white;
  var lineHeight = 1.2;
  // Bitfinex-inspired color scheme
  const primaryColor = Color(0xFF03ca9b); // Teal green
  const secondaryColor = Color(0xFF82baf6); // Light blue
  const errorColor = Color(0xFFe44b44); // Red accent
  const backgroundColor = Color(
    0xFF0d1d29,
  ); // Deep blue-black (rgb(13, 29, 41))
  const surfaceColor = Color(0xFF172d3e); // Darker surface (rgb(23, 45, 62))
  final borderRadius = BorderRadius.circular(8.0);

  WidgetStateProperty<Color> switchStateProperty =
      WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return primaryColor;
        }
        return textColor.withValues(alpha: 0.6);
      });

  WidgetStateBorderSide chipBorderStateProperty =
      WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BorderSide(color: primaryColor, width: 2);
        }
        return BorderSide(color: textColor.withValues(alpha: 0.6), width: 2);
      });

  final baseTheme = ThemeData(
    useMaterial3: true,
    splashFactory: NoSplash.splashFactory,
    hoverColor: Colors.transparent,
    highlightColor: Colors.transparent,
    scaffoldBackgroundColor: Colors.transparent,
    dividerColor: Colors.transparent,
    focusColor: Colors.transparent,

    // COLORS
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: primaryColor,
      onPrimary: backgroundColor,
      secondary: secondaryColor,
      onSecondary: backgroundColor,
      error: errorColor,
      onError: Colors.white,
      surface: surfaceColor,
      onSurface: textColor,
      surfaceContainerHighest: backgroundColor,
    ),

    // EXTENSIONS
    extensions: <ThemeExtension<dynamic>>[
      MoreColors(
        bgRadialColor1: backgroundColor,
        bgRadialColor2: surfaceColor,
        bgRadialColor3: backgroundColor,
        bgRadialEndColor: backgroundColor,
        mutedColor: textColor.withValues(alpha: 0.5),
      ),
    ],

    // TEXT
    textTheme: TextTheme(
      bodyLarge: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      bodySmall: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      displayLarge: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      displayMedium: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      titleSmall: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      labelLarge: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      labelMedium: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      labelSmall: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      headlineLarge: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      headlineMedium: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
      headlineSmall: TextStyle(
        color: textColor,
        height: lineHeight,
        fontWeight: FontWeight.w600,
      ),
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: textColor,
      selectionColor: textColor.withValues(alpha: 0.1),
    ),

    // CARD
    cardTheme: CardThemeData(
      color: Colors.white.withValues(alpha: 0.1),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.4), width: 1),
      ),
    ),

    // BUTTON
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        backgroundColor: surfaceColor,
        foregroundColor: primaryColor,
        side: const BorderSide(color: primaryColor, width: 1.5),
        padding: const EdgeInsets.symmetric(
          vertical: Spaces.medium,
          horizontal: Spaces.medium,
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: const EdgeInsets.symmetric(
          vertical: Spaces.medium,
          horizontal: Spaces.medium,
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle: GoogleFonts.jura(fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: primaryColor,
        foregroundColor: backgroundColor,
        disabledBackgroundColor: surfaceColor,
        iconColor: backgroundColor,
        disabledIconColor: Colors.white24,
        padding: const EdgeInsets.symmetric(
          vertical: Spaces.medium,
          horizontal: Spaces.medium,
        ),
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        textStyle: GoogleFonts.inter(fontWeight: FontWeight.w600, fontSize: 15),
      ),
    ),

    // APP BAR
    appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent),

    // NAVIGATION BAR
    navigationBarTheme: NavigationBarThemeData(
      indicatorShape: CircleBorder(side: BorderSide.none),
      surfaceTintColor: Colors.transparent,
      backgroundColor: surfaceColor,
      indicatorColor: primaryColor.withValues(alpha: 0.2),
      labelTextStyle: WidgetStatePropertyAll(
        GoogleFonts.inter(color: textColor, fontWeight: FontWeight.w500),
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      elevation: 0,
      backgroundColor: surfaceColor,
      selectedItemColor: primaryColor,
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: textColor.withValues(alpha: 0.6),
      selectedLabelStyle: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
      ),
      selectedIconTheme: IconThemeData(size: 36, color: primaryColor),
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: surfaceColor,
      indicatorColor: Colors.transparent,
      selectedLabelTextStyle: GoogleFonts.inter(
        color: primaryColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelTextStyle: GoogleFonts.inter(
        color: textColor.withValues(alpha: 0.6),
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
      selectedIconTheme: IconThemeData(size: 36, color: primaryColor),
      unselectedIconTheme: IconThemeData(
        size: 30,
        color: textColor.withValues(alpha: 0.6),
      ),
    ),

    // INPUT
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(color: textColor.withValues(alpha: 0.7)),
      errorStyle: TextStyle(
        color: errorColor,
        fontSize: 14,
        fontWeight: FontWeight.w600,
      ),
      contentPadding: const EdgeInsets.all(15),
      filled: true,
      fillColor: backgroundColor.withValues(alpha: 0.7),
      iconColor: textColor,
      suffixIconColor: textColor,
      prefixIconColor: textColor,
      floatingLabelBehavior: FloatingLabelBehavior.never,
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: surfaceColor, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: primaryColor, width: 1.5),
      ),
      errorMaxLines: 2,
      errorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: errorColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(color: errorColor, width: 2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: surfaceColor.withValues(alpha: 0.5),
          width: 1,
        ),
      ),
    ),

    // SNACKBAR
    snackBarTheme: SnackBarThemeData(
      backgroundColor: surfaceColor,
      contentTextStyle: TextStyle(color: textColor),
      actionTextColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
    ),

    // DIALOG
    dialogTheme: DialogThemeData(
      backgroundColor: backgroundColor.withValues(alpha: 0.95),
      surfaceTintColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.15), width: 1),
      ),
      actionsPadding: const EdgeInsets.all(Spaces.medium),
    ),

    // SWITCH
    switchTheme: SwitchThemeData(
      thumbColor: switchStateProperty,
      trackColor: WidgetStatePropertyAll(primaryColor.withValues(alpha: 0.2)),
      trackOutlineColor: switchStateProperty,
    ),

    // TAB BAR
    tabBarTheme: TabBarThemeData(
      dividerColor: surfaceColor,
      indicatorColor: primaryColor,
      labelColor: primaryColor,
      unselectedLabelColor: textColor.withValues(alpha: 0.6),
      overlayColor: WidgetStatePropertyAll(Colors.transparent),
    ),

    // MODAL BOTTOM SHEET
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: backgroundColor.withValues(alpha: 0.95),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        side: BorderSide(color: Colors.white.withValues(alpha: 0.15), width: 1),
      ),
    ),

    // MISC
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: 0.95),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      textStyle: const TextStyle(color: textColor),
    ),

    dividerTheme: DividerThemeData(
      thickness: 1,
      color: surfaceColor,
      space: 20,
    ),

    listTileTheme: ListTileThemeData(
      contentPadding: EdgeInsets.all(10),
      dense: true,
      tileColor: Colors.transparent,
      selectedTileColor: primaryColor.withValues(alpha: 0.1),
      selectedColor: primaryColor,
    ),

    sliderTheme: SliderThemeData(
      activeTrackColor: primaryColor,
      inactiveTrackColor: surfaceColor,
      thumbColor: primaryColor,
      trackHeight: 2,
    ),

    chipTheme: ChipThemeData(
      color: WidgetStatePropertyAll(Colors.white.withValues(alpha: 0.05)),
      elevation: 0,
      padding: const EdgeInsets.all(Spaces.small),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      brightness: Brightness.dark,
      side: WidgetStateBorderSide.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return BorderSide(color: primaryColor, width: 1.5);
        }
        return BorderSide(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        );
      }),
    ),

    checkboxTheme: CheckboxThemeData(
      overlayColor: WidgetStateProperty.all(Colors.transparent),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
  );

  return baseTheme.copyWith(
    textTheme: GoogleFonts.interTextTheme(baseTheme.textTheme),
  );
}
