import 'package:flutter/material.dart';

import 'package:meals_app/models/meal.dart';
import 'package:meals_app/resources/dummy_data.dart';

class MealDetail extends StatelessWidget {
  static const routeName = '/meal-detail';

  final Function toggleFavourite;
  final Function isFavourite;

  const MealDetail({
    Key? key,
    required this.toggleFavourite,
    required this.isFavourite,
  }) : super(key: key);

  Widget buildSectionTitle(BuildContext ctx, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(text, style: Theme.of(ctx).textTheme.headline6),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      height: 200,
      width: 300,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final routeArgs =
        ModalRoute.of(context)!.settings.arguments as Map<String, Object>;
    final String id = routeArgs['id'] as String;
    final String title = routeArgs['title'] as String;
    // final String imageUrl = routeArgs['imageUrl'] as String;
    // final int duration = routeArgs['duration'] as int;
    // final Complexity complexity = routeArgs['complexity'] as Complexity;
    // final Affordability affordability =
    //     routeArgs['affordability'] as Affordability;
    final selectedMeal = dummyMeals.firstWhere((Meal meal) => meal.id == id);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle(context, 'Ingredients'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.ingredients.length,
                itemBuilder: (BuildContext ctx, int idx) => Card(
                  color: Theme.of(context).colorScheme.secondary,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    child: Text(selectedMeal.ingredients[idx]),
                  ),
                ),
              ),
            ),
            buildSectionTitle(context, 'Steps'),
            buildContainer(
              ListView.builder(
                itemCount: selectedMeal.steps.length,
                itemBuilder: (BuildContext ctx, int idx) => Column(
                  children: [
                    ListTile(
                      leading: CircleAvatar(
                        child: Text(
                          "# ${idx + 1}",
                        ),
                      ),
                      title: Text(selectedMeal.steps[idx]),
                    ),
                    const Divider(thickness: 2.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          isFavourite(selectedMeal.id) ? Icons.star : Icons.star_border,
        ),
        onPressed: () {
          toggleFavourite(selectedMeal.id);
        },
        // onPressed: () {
        //   Navigator.of(context).pop(id);
        // },
      ),
    );
  }
}
