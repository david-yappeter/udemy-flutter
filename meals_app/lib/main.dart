import 'package:flutter/material.dart';

import 'package:meals_app/pages/category_meal.dart';
import 'package:meals_app/pages/filters.dart';
import 'package:meals_app/pages/meal_detail.dart';
import 'package:meals_app/pages/tabs.dart';
import 'package:meals_app/resources/dummy_data.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/themes/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };
  List<Meal> get _availableMeals {
    if ((!(_filters['gluten'] as bool) &&
        !(_filters['lactose'] as bool) &&
        !(_filters['vegan'] as bool) &&
        !(_filters['vegetarian'] as bool))) {
      return dummyMeals;
    }

    return dummyMeals
        .where((Meal meal) =>
            (((_filters['gluten'] as bool) && !meal.isGlutenFree) ||
                ((_filters['lactose'] as bool) && !meal.isLactoseFree) ||
                ((_filters['vegan'] as bool) && !meal.isVegan) ||
                ((_filters['vegetarian'] as bool) && !meal.isVegetarian)))
        .toList();
  }

  List<Meal> favouriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;
    });
  }

  void toggleFavourite(String mealId) {
    final existingIndex =
        favouriteMeals.indexWhere((Meal meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        favouriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        favouriteMeals
            .add(dummyMeals.firstWhere((Meal meal) => meal.id == mealId));
      });
    }
  }

  bool isMealFavourite(String id) =>
      favouriteMeals.any((Meal meal) => meal.id == id);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: custTheme(),
      home: TabsScreen(favouriteMeals: favouriteMeals),
      // home: const CategoriesPage(),
      routes: {
        CategoryMealPage.routeName: (BuildContext ctx) =>
            CategoryMealPage(availableMeals: _availableMeals),
        MealDetail.routeName: (BuildContext ctx) => MealDetail(
              toggleFavourite: toggleFavourite,
              isFavourite: isMealFavourite,
            ),
        FilterPage.routeName: (BuildContext ctx) =>
            FilterPage(filters: _filters, saveFilters: _setFilters),
      },
      // onGenerateRoute: (RouteSettings settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(builder: (BuildContext ctx) => const CategoriesPage());
      // },
      // onUnknownRoute: (RouteSettings settings) {
      //   print(settings.arguments);
      //   return MaterialPageRoute(
      //       builder: (BuildContext ctx) => const CategoriesPage());
      // },
    );
  }
}
