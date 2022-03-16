import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';
  const MealDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    // final String id = routeArgs['id'] as String;
    final String title = routeArgs['title'] as String;
    // final String imageUrl = routeArgs['imageUrl'] as String;
    // final int duration = routeArgs['duration'] as int;
    // final Complexity complexity = routeArgs['complexity'] as Complexity;
    // final Affordability affordability =
    routeArgs['affordability'] as Affordability;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.headline6,
        ),
      ),
      body: const Text('The Meal'),
    );
  }
}
