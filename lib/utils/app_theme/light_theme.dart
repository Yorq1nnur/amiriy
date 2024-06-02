import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_utils/my_utils.dart';

class LightTheme {
  static final ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: Colors.blue,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
      selectedIconTheme: IconThemeData(
        size: 20.w,
        color: Colors.black,
      ),
      unselectedIconTheme: IconThemeData(
        size: 20.w,
        color: Colors.black54,
      ),
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    shadowColor: Colors.black,
    cardColor: Colors.grey,
    dividerColor: Colors.black,
    textTheme: const TextTheme(
      displayLarge: TextStyle(
        fontSize: 57.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      displayMedium: TextStyle(
        fontSize: 45.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      displaySmall: TextStyle(
        fontSize: 36.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      headlineLarge: TextStyle(
        fontSize: 32.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      headlineMedium: TextStyle(
        fontSize: 28.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      headlineSmall: TextStyle(
        fontSize: 24.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      titleLarge: TextStyle(
        fontSize: 22.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      labelSmall: TextStyle(
        fontSize: 11.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        color: Colors.black,
        fontFamily: "DM sans",
        fontWeight: FontWeight.w500,
      ),
    ),
    iconTheme: const IconThemeData(color: Colors.black, size: 24.0),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Colors.white,
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
      brightness: Brightness.light,
      primary: Colors.blue,
      onPrimary: Colors.white,
      primaryContainer: Color(0xFFDAE2FF),
      onPrimaryContainer: Color(0xFF001848),
      secondary: Color(0xFF7C5800),
      onSecondary: Color(0xFFFFFFFF),
      secondaryContainer: Color(0xFFFFDEA8),
      onSecondaryContainer: Color(0xFF271900),
      tertiary: Color(0xFF5342E2),
      onTertiary: Color(0xFFFFFFFF),
      tertiaryContainer: Color(0xFFE3DFFF),
      onTertiaryContainer: Color(0xFF130067),
      error: Color(0xFFBA1A1A),
      errorContainer: Color(0xFFFFDAD6),
      onError: Color(0xFFFFFFFF),
      onErrorContainer: Color(0xFF410002),
      surface: Color(0xFFFDFBFF),
      onSurface: Color(0xFF001B3D),
      surfaceContainerHighest: Color(0xFFE1E2EC),
      onSurfaceVariant: Color(0xFF45464F),
      outline: Color(0xFF757780),
      onInverseSurface: Color(0xFFECF0FF),
      inverseSurface: Color(0xFF003062),
      inversePrimary: Color(0xFFB2C5FF),
      shadow: Color(0xFF000000),
      surfaceTint: Color(0xFF0056D2),
      outlineVariant: Color(0xFFC5C6D0),
      scrim: Color(0xFF000000),
    ),
    useMaterial3: true,
  );
}
