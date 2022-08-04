import 'package:flutter/material.dart';

class ProjectThemeData {
  static ThemeData getTheme({Color? importanceColor}) {
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFFF7F6F2),
      disabledColor: const Color(0x26000000),
      shadowColor: Colors.black.withOpacity(0.12),
      primaryColor: Colors.white,
      indicatorColor: Colors.black.withOpacity(0.06),
      hoverColor: (importanceColor ?? Color(0xFFFF3B30)).withOpacity(0.12),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            Color(0xFF007AFF).withOpacity(0.1),
          ),
        ),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: Color(0xFF007AFF),
        onPrimary: Colors.white,
        secondary: Color(0xFF34C759),
        onSecondary: (importanceColor ?? Color(0xFFFF3B30)).withOpacity(0.12),
        error: importanceColor ?? Color(0xFFFF3B30),
        onError: Colors.white,
        background: Colors.white,
        onBackground: Color(0x4D000000),
        surface: Color(0xFF007AFF),
        onSurface: Colors.black,
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF007AFF),
      ),
      primaryIconTheme: IconThemeData(
        color: Colors.black.withOpacity(0.3),
      ),
      textTheme: TextTheme(
        headline1: const TextStyle(
          fontSize: 32,
          height: 38 / 32,
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        headline2: const TextStyle(
          fontSize: 20,
          height: 32 / 20,
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        headline3: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: Colors.black.withOpacity(0.3),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        headline4: TextStyle(
          fontSize: 16,
          height: 20 / 16,
          color: importanceColor ?? Color(0xFFFF3B30),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
        headline5: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: importanceColor ?? Color(0xFFFF3B30),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        headline6: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: Color(0xFF007AFF),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        button: const TextStyle(
          fontSize: 14,
          height: 24 / 14,
          letterSpacing: 0.16,
          color: Color(0xFF007AFF),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        bodyText1: const TextStyle(
          fontSize: 16,
          height: 20 / 16,
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          height: 20 / 16,
          color: Colors.black.withOpacity(0.3),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.lineThrough,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle1: const TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: Colors.black,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        subtitle2: TextStyle(
          fontSize: 16,
          height: 20 / 16,
          color: Colors.black.withOpacity(0.3),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
