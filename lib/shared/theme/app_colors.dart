import 'package:flutter/material.dart';

const kEmptyColor = 0x0D000000;

/// Color theme
const ColorScheme kColorScheme = ColorScheme(
  primary: kPrimary,
  secondary: kSecondary,
  surface: kSurfaceWhite,
  background: Colors.white,
  error: kErrorRed,
  onPrimary: kDarkBG,
  onSecondary: kGrey900,
  onSurface: kGrey900,
  onBackground: kGrey900,
  onError: kSurfaceWhite,
  brightness: Brightness.light,
);

const ColorScheme kDarkColorScheme = ColorScheme(
  primary: kPrimary,
  secondary: kSecondary,
  surface: kGrey900,
  background: Colors.black,
  error: kErrorRed,
  onPrimary: kLightBG,
  onSecondary: kGrey900,
  onSurface: kSurfaceWhite,
  onBackground: kSurfaceWhite,
  onError: kSurfaceWhite,
  brightness: Brightness.dark,
);

/// basic colors
const kSecondary = Color(0xFF64c66f);
const kPrimary = Color(0xFF1a8c28);
const kDarkSecondary = Color(0xff7cacf8);
const kYellow = Color(0xfff5820b);

const kTeal400 = Color(0xFF26A69A);
const kGrey900 = Color(0xFF263238);
const kGrey600 = Color(0xFF546E7A);
const kGrey200 = Color(0xFFEEEEEE);
const kGrey400 = Color(0xFF90a4ae);
const kErrorRed = Color(0xFFED1A34);
const kColorRed = Color(0xFFF3090B);
const kSurfaceWhite = Color(0xFFFFFBFA);
const kRedColorHeart = Color(0xFFf22742);

/// color for theme
const kLightPrimary = Color(0xfffcfcff);
const kLightAccent = Color(0xFF1E1E1E);
const kDarkAccent = Color(0xffd3e3fd);
const Color kBlack = Color(0xFF1E1E1E);

const kLightBG = Color(0xffF1F2F3); // 0xffd3e3fd
const kLightText = Color(0xffd3e3fd); //
const kDarkBG = Color(0xff0d2136);
const kDarkBgLight = Color(0xff0d2136);

// const kOrderStatusColor = {
//   'processing': '#2ecc71',
//   'refunded': '#e67e22',
//   'cancelled': '#e74c3c',
//   'completed': '#1abc9c',
//   'failed': '#e74c3c',
//   'pendding': '#f39c12',
//   'on-hold': '#2c3e50'
// };

const kColorRatingStar = Color(0xfff39c12);
