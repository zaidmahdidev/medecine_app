import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTheme {
  static const primaryColor = Color(0xff28a899);
  static const secondryColor = Color(0xFFffffff);

  static const textStyle10 = TextStyle(
    fontSize: 10,
  );

  static const textStyle12 = TextStyle(
    fontSize: 12,
  );

  static const textStyle14 = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.bold,
  );

  static const textStyle15 = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.bold,
  );

  static const textStyle20 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
  static const textStyle22 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
  );

  static const textStyle24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w900,
  );

  static const textStyle36 = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.bold,
  );
}




ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.grey,
  // canvasColor: Colors.white12,  // هذا فيه حاجات
  secondaryHeaderColor: Colors.white10,




  appBarTheme: const AppBarTheme(
    // backgroundColor: MyTheme.primaryColor,
    titleTextStyle: MyTheme.textStyle15,
    iconTheme: IconThemeData(color: Colors.white),
  ),

  // fontFamily: 'Jannah'
  // fontFamily: GoogleFonts.notoKufiArabic().fontFamily
  fontFamily: GoogleFonts.tajawal().fontFamily,

);

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: Colors.white,
  secondaryHeaderColor: MyTheme.primaryColor,
  primarySwatch: primary,

  appBarTheme: const AppBarTheme(
    backgroundColor: MyTheme.primaryColor,
    titleTextStyle: MyTheme.textStyle20,
    iconTheme: IconThemeData(color: Colors.white),
  ),

  // fontFamily: 'Jannah'
  // fontFamily: GoogleFonts.notoKufiArabic().fontFamily
  fontFamily: GoogleFonts.tajawal().fontFamily,

);




const MaterialColor primary = MaterialColor(_primaryPrimaryValue, <int, Color>{
  50: Color(0xFFE5F5F3),
  100: Color(0xFFBFE5E0),
  200: Color(0xFF94D4CC),
  300: Color(0xFF69C2B8),
  400: Color(0xFF48B5A8),
  500: Color(_primaryPrimaryValue),
  600: Color(0xFF24A091),
  700: Color(0xFF1E9786),
  800: Color(0xFF188D7C),
  900: Color(0xFF0F7D6B),
});
const int _primaryPrimaryValue = 0xFF28A899;

const MaterialColor primaryAccent =
    MaterialColor(_primaryAccentValue, <int, Color>{
  100: Color(0xFFAFFFF0),
  200: Color(_primaryAccentValue),
  400: Color(0xFF49FFDE),
  700: Color(0xFF30FFD9),
});
const int _primaryAccentValue = 0xFF7CFFE7;
//////////////

