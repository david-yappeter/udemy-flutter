import 'package:flutter/material.dart';

import 'package:meals_app/pages/filters.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(
          {required String title,
          required IconData icon,
          VoidCallback? onTap}) =>
      ListTile(
        leading: Icon(
          icon,
          size: 26,
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          if (onTap != null) {
            onTap();
          }
        },
      );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 120,
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              alignment: Alignment.centerLeft,
              color: Theme.of(context).colorScheme.secondary,
              child: Text(
                'Cooking Up!',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 30,
                    color: Theme.of(context).primaryColor),
              ),
            ),
            const SizedBox(height: 20),
            buildListTile(
                icon: Icons.restaurant,
                title: 'Meals',
                onTap: () {
                  Navigator.of(context).pushReplacementNamed('/');
                }),
            buildListTile(
                icon: Icons.settings,
                title: 'Filters',
                onTap: () {
                  Navigator.of(context).pushNamed(FilterPage.routeName);
                }),
          ],
        ),
      ),
    );
  }
}
