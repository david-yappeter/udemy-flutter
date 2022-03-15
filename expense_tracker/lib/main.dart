import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import 'package:expense_tracker/pages/home.dart';
import 'package:expense_tracker/theme/theme.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //   [DeviceOrientation.portraitUp],
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: custTheme(),
      home: HomePage(),
    );
  }
}
