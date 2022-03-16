import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/resources/dummy_data.dart';

class CategoryMealPage extends StatelessWidget {
  static const routeName = '/category-meals';

  const CategoryMealPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    final String categoryId = routeArgs['id'] as String;
    final String categoryTitle = routeArgs['title'] as String;
    final categoryMeals = dummyMeals.where((Meal meal) => meal.categories.contains(categoryId)).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return const Card(
            child: Text('Test'),
          );
        },
        itemCount: categoryMeals.length
        ,
      ),
    );
  }
}
