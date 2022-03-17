import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/meal_item.dart';

class CategoryMealPage extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  const CategoryMealPage({
    Key? key,
    required this.availableMeals,
  }) : super(key: key);

  @override
  State<CategoryMealPage> createState() => _CategoryMealPageState();
}

class _CategoryMealPageState extends State<CategoryMealPage> {
  late String categoryTitle;
  late List<Meal> displayedMeal;
  bool _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      final String categoryId = routeArgs['id'] as String;
      categoryTitle = routeArgs['title'] as String;
      displayedMeal = widget.availableMeals
          .where((Meal meal) => meal.categories.contains(categoryId))
          .toList();
      _loadedInitData = true;
    }
    super.didChangeDependencies();
  }

  // void removeMeal(String mealId) {
  //   setState(() {
  //     displayedMeal.removeWhere((Meal meal) => meal.id == mealId);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext ctx, int index) {
          return Card(
            child: MealItem(
              id: displayedMeal[index].id,
              title: displayedMeal[index].title,
              affordability: displayedMeal[index].affordability,
              complexity: displayedMeal[index].complexity,
              duration: displayedMeal[index].duration,
              imageUrl: displayedMeal[index].imageUrl,
              // removeItem: removeMeal,
            ),
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
