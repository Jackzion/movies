import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var roboto = GoogleFonts.roboto();
var largeTitle = roboto.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var heading1 = roboto.copyWith(
  fontSize: 20,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var heading2 = roboto.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w600,
  color: Colors.white,
);
var body1Regular = roboto.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body1Bold = roboto.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var body2Regular = roboto.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body2Bold = roboto.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var caption = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body3Regular = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);
var body3Bold = roboto.copyWith(
  fontSize: 12,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);
var verySmallText = roboto.copyWith(
  fontSize: 10,
  fontWeight: FontWeight.w400,
  color: Colors.white,
);

// Colors — 追番琥珀 (Amber Tracking)
const screenBackground = Color(0xFF0F172A); // page ink
const searchBarBackground = Color(0xFF192134); // surface / dialog / nav
const primaryButton = Color(0xFFF59E0B); // accent (CTA / selected)
const posterBorder = Color(0xFF94A3B8); // muted text / soft border
const buttonGrey = Color(0xFF243049); // secondary button / chip
const surfaceBar = Color(0xFF101A34); // top bar / drawer
const accentAmber = Color(0xFFF59E0B);
const accentAmberLight = Color(0xFFFBBF24);
const accentAmberDeep = Color(0xFFD97706);
const textMuted = Color(0xFF94A3B8);
const textSoft = Color(0xFFCBD5E1);
const dangerRed = Color(0xFFDC2626);
const successGreen = Color(0xFF22C55E);
const dividerLine = Color(0xFF243049);
const onAccent = Color(0xFF0F172A); // text/icon on amber
const iconPlaceholder = Color(0xFF64748B);

ThemeData createTheme() {
  return ThemeData(
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: accentAmber,
      onPrimary: onAccent,
      secondary: accentAmberLight,
      onSecondary: onAccent,
      surface: searchBarBackground,
      onSurface: Colors.white,
      error: dangerRed,
      onError: Colors.white,
      surfaceContainerHighest: surfaceBar,
      outline: dividerLine,
    ),
    textTheme: Typography.material2021().englishLike.copyWith(
      headlineLarge: heading1,
      headlineMedium: heading2,
      headlineSmall: body2Regular,
      titleLarge: largeTitle,
      titleMedium: heading2,
      titleSmall: body2Bold,
      bodyLarge: body1Regular,
      bodyMedium: body2Regular,
      bodySmall: body3Regular,
      labelLarge: body1Bold,
      labelMedium: body2Bold,
      labelSmall: caption,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: surfaceBar,
      foregroundColor: Colors.white,
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: searchBarBackground,
      selectedItemColor: accentAmber,
      unselectedLabelStyle: TextStyle(color: posterBorder),
      showUnselectedLabels: true,
      unselectedItemColor: posterBorder,
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: searchBarBackground,
      labelTextStyle: WidgetStateTextStyle.resolveWith((
        Set<WidgetState> states,
      ) {
        // 选中态用白色,未选中态用 posterBorder
        if (states.contains(WidgetState.selected)) {
          return TextStyle(color: Colors.white);
        }
        return TextStyle(color: posterBorder);
      }),
      iconTheme: WidgetStateProperty.all<IconThemeData>(
        IconThemeData(color: Colors.white),
      ),
      indicatorColor: accentAmber.withValues(alpha: 0.18),
    ),
  );
}
