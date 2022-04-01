import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurants.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailPage({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.id, child: Image.network(restaurant.pictureId)),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restaurant: ${restaurant.name}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Location: ${restaurant.city}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Rating: ${restaurant.rating}',
                    style: Theme.of(context).textTheme.subtitle2,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  Text(
                    'Description: ${restaurant.description}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                  const SizedBox(height: 10),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(
                    'Foods: ${restaurant.menus.foods.map((e) => e.name)}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Drinks: ${restaurant.menus.drinks.map((e) => e.name)}',
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
