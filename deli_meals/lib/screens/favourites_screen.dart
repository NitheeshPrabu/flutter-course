import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavouritesScreen extends StatelessWidget {
  final List<Meal> favouriteMeals;

  FavouritesScreen(this.favouriteMeals);

  @override
  Widget build(BuildContext context) {
    if (favouriteMeals.isEmpty) {
      return Center(
        child: Text('You have no favourites yet - start adding some!'),
      );
    }
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return MealItem(
          title: favouriteMeals[index].title,
          affordability: favouriteMeals[index].affordability,
          complexity: favouriteMeals[index].complexity,
          duration: favouriteMeals[index].duration,
          imageUrl: favouriteMeals[index].imageUrl,
          id: favouriteMeals[index].id,
        );
      },
      itemCount: favouriteMeals.length,
    );
  }
}
