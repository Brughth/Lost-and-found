import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'fade_through_transition.dart';
import 'fonts.dart';

IconThemeData customIconTheme(IconThemeData original) {
  return original.copyWith(color: kGrey900);
}

ThemeData buildLightTheme() {
  final base = ThemeData.light(useMaterial3: true).copyWith(
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        minimumSize: const Size(120, 40),
        padding: EdgeInsets.zero,
        textStyle: const TextStyle(
          fontWeight: FontWeight.w500,
        ),
        elevation: 1,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(40),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6),
        ),
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: FadeThroughPageTransitionsBuilder(),
        TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      },
    ),
  );

  return base.copyWith(
    brightness: Brightness.light,
    cardColor: Colors.white,
    buttonTheme: const ButtonThemeData(
      colorScheme: kColorScheme,
      textTheme: ButtonTextTheme.normal,
      buttonColor: kDarkBG,
    ),
    primaryColorLight: kLightBG,
    primaryIconTheme: customIconTheme(base.iconTheme),
    iconTheme: customIconTheme(base.iconTheme),
    textTheme: buildTextTheme(
      base.textTheme,
    ),
    primaryTextTheme: buildTextTheme(
      base.primaryTextTheme,
    ),
    hintColor: Colors.black26,
    primaryColor: kLightPrimary,
    scaffoldBackgroundColor: kLightBG,
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: kLightBG,
      titleTextStyle: const TextStyle(
        color: kDarkBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: const IconThemeData(
        color: kLightText,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(
        statusBarBrightness: Brightness.light,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: kLightBG,
        systemNavigationBarColor: kLightBG,
        systemNavigationBarDividerColor: kLightBG,
      ),
    ),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.black,
      unselectedLabelColor: Colors.black,
      labelPadding: EdgeInsets.zero,
      labelStyle: TextStyle(fontSize: 13),
      unselectedLabelStyle: TextStyle(fontSize: 13),
    ),
    dialogBackgroundColor: kLightBG,
    colorScheme: kColorScheme.copyWith(
      secondary: kLightAccent,
      error: kErrorRed,
    ),
  );
}
