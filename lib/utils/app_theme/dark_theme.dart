import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_utils/my_utils.dart';

class DarkTheme {
  static final ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.transparent,
      ),
    ),
    shadowColor: Colors.white,
    // cardColor: const Color(0xFF1E1E1E),
    cardColor: Colors.amber,
    dividerColor: Colors.white,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        fontSize: 45.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontSize: 36.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontSize: 32.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 22.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 11.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: Colors.white,
        fontFamily: "Inter",
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.blue, size: 24.0),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.black,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(
        size: 20.w,
        color: Colors.white,
      ),
      unselectedIconTheme: IconThemeData(
        size: 20.w,
        color: Colors.white60,
      ),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    iconButtonTheme: IconButtonThemeData(
      style: IconButton.styleFrom(
        backgroundColor: Colors.transparent,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.blue),
      trackColor: WidgetStateProperty.all(Colors.grey),
    ),
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Colors.blue,
      onPrimary: Colors.black,
      primaryContainer: Color(0xFF001848),
      onPrimaryContainer: Color(0xFFDAE2FF),
      secondary: Color(0xFF7C5800),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFF271900),
      onSecondaryContainer: Color(0xFFFFDEA8),
      tertiary: Color(0xFF5342E2),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFF130067),
      onTertiaryContainer: Color(0xFFE3DFFF),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFF410002),
      onError: Colors.red,
      onErrorContainer: Color(0xFFFFDAD6),
      surface: Color(0xFF1E1E1E),
      onSurface: Color(0xFFE1E2EC),
      surfaceContainerHighest: Color(0xFF003062),
      onSurfaceVariant: Color(0xFFC5C6D0),
      outline: Color(0xFF757780),
      onInverseSurface: Color(0xFF001B3D),
      inverseSurface: Color(0xFFECF0FF),
      inversePrimary: Color(0xFF0056D2),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFFB2C5FF),
      outlineVariant: Color(0xFF45464F),
      scrim: Color(0xFF000000),
    ),
    useMaterial3: true,
  );
}
