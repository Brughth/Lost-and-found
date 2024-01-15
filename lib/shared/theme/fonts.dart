import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

String fontFamily = 'Barlow';
String fontHeader = 'Barlow Condensed';

TextTheme buildTextTheme(
  TextTheme base,
) {
  return base
      .copyWith(
        displayLarge: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.displayLarge!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ).copyWith(
          fontFamily: fontFamily,
        ),
        displayMedium: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.displayMedium!.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        displaySmall: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.displaySmall!.copyWith(fontWeight: FontWeight.w700),
        ),
        headlineMedium: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.headlineMedium!.copyWith(fontWeight: FontWeight.w700),
        ),
        headlineSmall: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.headlineSmall!.copyWith(fontWeight: FontWeight.w500),
        ),
        titleLarge: GoogleFonts.getFont(
          fontHeader,
          textStyle: base.titleLarge!.copyWith(
            fontWeight: FontWeight.normal,
          ),
        ),
        bodySmall: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.bodySmall!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
          ),
        ),
        titleMedium: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.titleMedium!.copyWith(),
        ),
        titleSmall: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.titleSmall!.copyWith(),
        ),
        bodyLarge: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.bodyLarge!.copyWith(),
        ),
        bodyMedium: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.bodyMedium!.copyWith(),
        ),
        labelLarge: GoogleFonts.getFont(
          fontFamily,
          textStyle: base.labelLarge!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 15.0,
          ),
        ),
      )
      .apply(
        displayColor: kGrey900,
        bodyColor: kGrey900,
      );
}
