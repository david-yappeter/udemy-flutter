import 'package:flutter/material.dart';

import 'package:meals_app/pages/categories.dart';
import 'package:meals_app/pages/favourite.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/widgets/drawer.dart';

class TabsScreen extends StatefulWidget {
  static const routeName = "/";

  final List<Meal> favouriteMeals;

  const TabsScreen({
    Key? key,
    required this.favouriteMeals,
  }) : super(key: key);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late List<Map<String, dynamic>> _pages;

  int _selectedPageIndex = 0;

  void selectPage(int idx) {
    setState(() {
      _selectedPageIndex = idx;
    });
  }

  @override
  void initState() {
    _pages = [
      {'page': const CategoriesPage(), 'title': 'Categories'},
      {
        'page': FavouritesPage(favouriteMeals: widget.favouriteMeals),
        'title': 'Favourites'
      },
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context).primaryColor,
            icon: const Icon(Icons.star),
            label: 'Favourites',
          ),
        ],
      ),
      drawer: const MainDrawer(),
    );
  }
}
