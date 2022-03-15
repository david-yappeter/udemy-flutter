import 'package:flutter/material.dart';

ThemeData custTheme() {
  return ThemeData(
    primarySwatch: Colors.blue,
    fontFamily: 'Quicksand',
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        fontFamily: 'OpenSans',
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
      // textTheme: ThemeData.light().textTheme.copyWith(
      //     title: TextStyle(fontFamily: 'OpenSans', fontSize: 20)),
    ),
  );
}
