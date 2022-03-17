import 'package:flutter/material.dart';

import 'package:meals_app/widgets/drawer.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class FavouritesPage extends StatelessWidget {
  final List<Meal> favouriteMeals;
  const FavouritesPage({
    Key? key,
    required this.favouriteMeals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      drawer: const MainDrawer(),
      body: favouriteMeals.isEmpty
          ? const Center(
              child: Text('You have no favourites yet - start adding some!'),
            )
          : ListView.builder(
              itemBuilder: (BuildContext ctx, int idx) {
                final currentMeal = favouriteMeals[idx];
                return MealItem(
                  id: currentMeal.id,
                  title: currentMeal.title,
                  imageUrl: currentMeal.imageUrl,
                  duration: currentMeal.duration,
                  complexity: currentMeal.complexity,
                  affordability: currentMeal.affordability,
                );
              },
              itemCount: favouriteMeals.length,
            ),
    );
  }
}
