import 'package:flutter/material.dart';

import 'package:expense_tracker/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
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
          )),
      home: HomePage(),
    );
  }
}
