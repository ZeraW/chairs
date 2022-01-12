import 'package:flutter/material.dart';
import 'package:chairs/utils/colors.dart';

ThemeData appTheme() {
  return ThemeData(
    primaryColor: xColors.mainColor,
    accentColor: xColors.accentColor,
    hintColor: Colors.white,
    dividerColor: Colors.grey,
    buttonColor: xColors.btnColor,
    scaffoldBackgroundColor: Colors.white,
    canvasColor: xColors.mainColor,
    cardColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(backgroundColor: xColors.mainColor,),
    textTheme: TextTheme(
      button: TextStyle(
        fontWeight: FontWeight.w400,
        color: Colors.white,
      ),
      subtitle1: TextStyle(
          fontSize: 20, fontWeight: FontWeight.bold),



    ),
    appBarTheme: _appBarTheme(),
  );
}

AppBarTheme _appBarTheme() {
  return AppBarTheme(
    elevation: 0.0,
    textTheme: TextTheme(
        headline6: TextStyle(
            color: xColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20)),
    color: xColors.mainColor,
    iconTheme: IconThemeData(
      color: xColors.white,
    ),
    centerTitle: true,
  );
}
