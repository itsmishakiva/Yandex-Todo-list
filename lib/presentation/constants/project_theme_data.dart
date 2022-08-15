import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ProjectThemeData {
  static ThemeData getTheme({Color? importanceColor}) {
    if (SchedulerBinding.instance.window.platformBrightness ==
        Brightness.light) {
      return ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF7F6F2),
        disabledColor: const Color(0x26000000),
        shadowColor: Colors.black.withOpacity(0.12),
        primaryColorDark: Colors.black.withOpacity(0.06),
        primaryColor: Colors.white,
        indicatorColor: Colors.black.withOpacity(0.06),
        hoverColor:
            (importanceColor ?? const Color(0xFFFF3B30)).withOpacity(0.12),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
              const Color(0xFF007AFF).withOpacity(0.1),
            ),
          ),
        ),
        checkboxTheme: CheckboxThemeData(
          checkColor: MaterialStateProperty.all(Colors.white),
          side: BorderSide(
            color: Colors.black.withOpacity(0.2),
            width: 2,
          ),
        ),
        colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: const Color(0xFF007AFF),
          onPrimary: Colors.white,
          secondary: const Color(0xFF34C759),
          onSecondary:
              (importanceColor ?? const Color(0xFFFF3B30)).withOpacity(0.12),
          error: importanceColor ?? const Color(0xFFFF3B30),
          onError: Colors.white,
          background: Colors.white,
          onBackground: const Color(0x4D000000),
          surface: const Color(0xFF007AFF),
          onSurface: Colors.black.withOpacity(0.6),
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
            color: importanceColor ?? const Color(0xFFFF3B30),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            overflow: TextOverflow.ellipsis,
          ),
          headline5: TextStyle(
            fontSize: 14,
            height: 20 / 14,
            color: importanceColor ?? const Color(0xFFFF3B30),
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
          headline6: const TextStyle(
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
          caption: const TextStyle(
            fontSize: 12,
            height: 20 / 12,
            color: Colors.black,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
          ),
          overline: const TextStyle(
            fontSize: 34,
            height: 40 / 34,
            color: Colors.white,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w500,
          ),
        ),
      );
    }
    return ThemeData(
      scaffoldBackgroundColor: const Color(0xFF161618),
      disabledColor: const Color(0x26FFFFFF),
      shadowColor: Colors.black.withOpacity(0.12),
      primaryColorDark: Colors.black.withOpacity(0.06),
      primaryColor: const Color(0xFF252528),
      indicatorColor: Colors.black.withOpacity(0.06),
      hoverColor:
          (importanceColor ?? const Color(0xFFFF453A)).withOpacity(0.12),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          overlayColor: MaterialStateProperty.all(
            const Color(0xFF0A84FF).withOpacity(0.1),
          ),
        ),
      ),
      switchTheme: SwitchThemeData(
          thumbColor: MaterialStateProperty.resolveAs(
        MaterialStateProperty.all(
          const Color(0xFF3C3C3F),
        ),
        {
          MaterialState.selected,
        },
      )),
      checkboxTheme: CheckboxThemeData(
        checkColor: MaterialStateProperty.all(
          const Color(0xFF252528),
        ),
        side: BorderSide(
          color: Colors.white.withOpacity(0.2),
          width: 2,
        ),
      ),
      colorScheme: ColorScheme(
        brightness: Brightness.light,
        primary: const Color(0xFF0A84FF),
        onPrimary: Colors.white,
        secondary: const Color(0xFF32D74B),
        onSecondary:
            (importanceColor ?? const Color(0xFFFF453A)).withOpacity(0.12),
        error: importanceColor ?? const Color(0xFFFF453A),
        onError: Colors.white,
        background: const Color(0xFF252528),
        onBackground: Colors.white,
        surface: const Color(0xFF0A84FF),
        onSurface: Colors.white.withOpacity(0.6),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xFF0A84FF),
      ),
      primaryIconTheme: IconThemeData(
        color: Colors.white.withOpacity(0.3),
      ),
      textTheme: TextTheme(
        headline1: const TextStyle(
          fontSize: 32,
          height: 38 / 32,
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        headline2: const TextStyle(
          fontSize: 20,
          height: 32 / 20,
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        headline3: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: Colors.white.withOpacity(0.3),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        headline4: TextStyle(
          fontSize: 16,
          height: 20 / 16,
          color: importanceColor ?? const Color(0xFFFF453A),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
        headline5: TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: importanceColor ?? const Color(0xFFFF453A),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        headline6: const TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: Color(0xFF0A84FF),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        button: const TextStyle(
          fontSize: 14,
          height: 24 / 14,
          letterSpacing: 0.16,
          color: Color(0xFF0A84FF),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
        bodyText1: const TextStyle(
          fontSize: 16,
          height: 20 / 16,
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
        bodyText2: TextStyle(
          fontSize: 16,
          height: 20 / 16,
          color: Colors.white.withOpacity(0.3),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          decoration: TextDecoration.lineThrough,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle1: const TextStyle(
          fontSize: 14,
          height: 20 / 14,
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        subtitle2: const TextStyle(
          fontSize: 16,
          height: 20 / 16,
          color: Color(0x4dffffff),
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
          overflow: TextOverflow.ellipsis,
        ),
        caption: const TextStyle(
          fontSize: 12,
          height: 20 / 12,
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w400,
        ),
        overline: const TextStyle(
          fontSize: 34,
          height: 40 / 34,
          color: Colors.white,
          fontFamily: 'Roboto',
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
