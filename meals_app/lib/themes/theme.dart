import 'package:flutter/material.dart';

ThemeData custTheme() {
  final ThemeData theme = ThemeData();

  return ThemeData(
    primarySwatch: Colors.blue,
    colorScheme: theme.colorScheme.copyWith(
      secondary: Colors.amber,
    ),
    canvasColor: const Color.fromRGBO(255, 254, 229, 1),
    fontFamily: 'Raleway',
    // appBarTheme: AppBarTheme(
    //   titleTextStyle: TextStyle(

    //   ),
    // ),
    textTheme: ThemeData.light().textTheme.copyWith(
        bodyText1: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        bodyText2: const TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
        caption: const TextStyle(
          fontSize: 26,
        ),
        headline6: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          fontFamily: 'RobotoCondensed',
        )),
  );
}
