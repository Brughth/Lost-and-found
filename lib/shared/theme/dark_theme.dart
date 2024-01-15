import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app_colors.dart';
import 'fonts.dart';

ThemeData buildDarkTheme() {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    snackBarTheme: SnackBarThemeData(
      backgroundColor: Colors.black,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
    canvasColor: kDarkBG,
    cardTheme: base.cardTheme.copyWith(
      color: kDarkBgLight,
    ),
    brightness: Brightness.dark,
    primaryColor: kDarkBgLight,
    primaryColorLight: kDarkBgLight,
    scaffoldBackgroundColor: kDarkBG,
    textTheme: buildTextTheme(
      base.textTheme,
    ).apply(
      displayColor: kLightText,
      bodyColor: kLightText,
    ),
    primaryTextTheme: buildTextTheme(
      base.primaryTextTheme,
    ).apply(
      displayColor: kLightBG,
      bodyColor: kLightBG,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: kDarkBG,
      titleTextStyle: const TextStyle(
        color: kLightBG,
        fontSize: 18.0,
        fontWeight: FontWeight.w800,
      ),
      iconTheme: const IconThemeData(
        color: kDarkAccent,
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light.copyWith(
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarDividerColor: kDarkBG,
        statusBarColor: kDarkBG,
        systemNavigationBarColor: kDarkBG,
      ),
    ),
    buttonTheme: ButtonThemeData(
        colorScheme: kColorScheme.copyWith(onPrimary: kLightBG)),
    pageTransitionsTheme: const PageTransitionsTheme(builders: {
      TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder(),
      TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
    }),
    tabBarTheme: const TabBarTheme(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white,
      labelPadding: EdgeInsets.zero,
      labelStyle: TextStyle(fontSize: 13),
      unselectedLabelStyle: TextStyle(fontSize: 13),
    ),
    dialogBackgroundColor: kDarkBG,
    colorScheme: kDarkColorScheme.copyWith(
      secondary: kDarkAccent,
      background: kDarkBG,
    ),
  );
}
