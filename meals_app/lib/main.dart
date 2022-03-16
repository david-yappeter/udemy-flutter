import 'package:flutter/material.dart';

import 'package:meals_app/pages/categories.dart';
import 'package:meals_app/pages/category_meal.dart';
import 'package:meals_app/themes/theme.dart';

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
      theme: custTheme(),
      home: const CategoriesPage(),
      routes: {
        CategoryMealPage.routeName: (BuildContext ctx) =>
            const CategoryMealPage(),
      },
    );
  }
}
