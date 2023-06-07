import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:shop_app/shared/components/constants.dart';

ThemeData lightTheme = ThemeData(
  primaryColor: defaultColor,
  primaryColorLight: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    elevation: 0,
    titleTextStyle: TextStyle(
        color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Colors.deepOrange),
  textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600)),
  fontFamily: 'MyFont',
);

ThemeData darkTheme = ThemeData(
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: HexColor("#18191a"),
    systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: HexColor("#18191a"),
        systemNavigationBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.black),
  ),
  textTheme: const TextTheme(
      displayLarge: TextStyle(
          color: Colors.white, fontSize: 18, fontWeight: FontWeight.w600)),
  primarySwatch: Colors.deepOrange,
  scaffoldBackgroundColor: HexColor("#18191a"),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: Colors.grey, backgroundColor: HexColor("#3a3b3c")),
  fontFamily: 'MyFont',
);
