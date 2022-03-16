import 'package:flutter/material.dart';

import 'package:meals_app/resources/dummy_data.dart';
import 'package:meals_app/widgets/category_item.dart';

class CategoriesPage extends StatelessWidget {
  static const routeName = "/";

  const CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DeliMeal"),
      ),
      body: GridView(
        padding: const EdgeInsets.all(20),
        children: dummyCategories
            .map(
              (categoryData) => CategoryItem(
                id: categoryData.id,
                title: categoryData.title,
                color: categoryData.color,
              ),
            )
            .toList(),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
      ),
    );
  }
}
