import 'package:flutter/material.dart';

import 'package:meals_app/pages/category_meal.dart';

class CategoryItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;

  const CategoryItem({
    Key? key,
    required this.id,
    required this.title,
    required this.color,
  }) : super(key: key);

  void selectCategory(BuildContext ctx) {
    Navigator.pushNamed(ctx, CategoryMealPage.routeName, arguments: {
      'id': id,
      'title': title,
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeContext = Theme.of(context);

    return InkWell(
      onTap: () {
        selectCategory(context);
      },
      splashColor: themeContext.primaryColor,
      borderRadius: BorderRadius.circular(15),
      child: Container(
          padding: const EdgeInsets.all(15),
          child: Text(title, style: themeContext.textTheme.headline6),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.7),
                color,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
          )),
    );
  }
}
