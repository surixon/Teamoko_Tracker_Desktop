// @dart=2.9
import 'package:desk/utils/commom_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Dark theme
ThemeData darkTheme() {
  return ThemeData(
    fontFamily: 'proxima',
    textTheme: GoogleFonts.ibmPlexSansTextTheme(ThemeData.dark().textTheme),
    brightness: Brightness.dark,
    primarySwatch: MaterialColor(0xFFf3396a, CommonColors.color),
    accentColor: MaterialColor(0xFFf3396a, CommonColors.color),
    cardColor: const Color(0xFF222222),
   unselectedWidgetColor:  MaterialColor(0xFFf3396a, CommonColors.color),
    scaffoldBackgroundColor: const Color(0xFF0E0E0E),
    cardTheme: const CardTheme(shape: RoundedRectangleBorder()),
    dialogTheme: DialogTheme(
      elevation: 10,
      shape: Border.all(color: Colors.white24),
      backgroundColor: Colors.grey,
    ),
  ).copyWith(
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

