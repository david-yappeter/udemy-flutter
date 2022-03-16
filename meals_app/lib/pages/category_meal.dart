import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/resources/dummy_data.dart';
import 'package:meals_app/widgets/meal_item.dart';

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
    final categoryMeals = dummyMeals
        .where((Meal meal) => meal.categories.contains(categoryId))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return Card(
            child: MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              affordability: categoryMeals[index].affordability,
              complexity: categoryMeals[index].complexity,
              duration: categoryMeals[index].duration,
              imageUrl: categoryMeals[index].imageUrl,
            ),
          );
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
