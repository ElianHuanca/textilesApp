//import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const scaffoldBackgroundColor = Color(0xFFF8F7F7);
/* const colorSeed = Color(0xff424CB8);
final Random _random = Random();
final List<Color> _colors = [
  const Color(0xFF4276AD),
  const Color(0xFF9ACD32),
  const Color(0xFFCC3CCC),
  const Color(0xFF47B9B9),
  
];
final _color = _colors[_random.nextInt(_colors.length)]; */
//final _color = _colors[3];
 const Color _color = Color(0xFFE2725B);

class AppTheme {
  ThemeData getTheme() => ThemeData(

      ///* General
      useMaterial3: true,
      //colorSchemeSeed: colorSeed,
      primaryColor: _color,

      ///* Texts
      textTheme: TextTheme(
          titleLarge: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 40, fontWeight: FontWeight.bold),
          titleMedium: GoogleFonts.montserratAlternates()
              .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
          titleSmall:
              GoogleFonts.montserratAlternates().copyWith(fontSize: 20)),

      ///* Scaffold Background Color
      //scaffoldBackgroundColor: scaffoldBackgroundColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,

      ///* Buttons
      filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.resolveWith((states) => _color),
              textStyle: MaterialStatePropertyAll(
                  GoogleFonts.montserratAlternates()
                      .copyWith(fontWeight: FontWeight.w700)))),

      // BoxDecoration

      ///* AppBar
      appBarTheme: AppBarTheme(
        //color: scaffoldBackgroundColor,
        color: _color,
        titleTextStyle: GoogleFonts.montserratAlternates().copyWith(
            fontSize: 25, fontWeight: FontWeight.bold, color: Colors.black),
      ));
}
