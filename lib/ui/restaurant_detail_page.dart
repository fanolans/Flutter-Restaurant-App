import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/list_restaurants.dart';

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Hero(
                    tag: restaurant.id,
                    child: Image.network(restaurant.pictureId)),
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
                      /*Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.food_bank,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          Text('Foods Menu',
                              style: Theme.of(context).textTheme.subtitle2),
                          const SizedBox(
                            height: 150,
                          ),
                          ListView(
                            scrollDirection: Axis.horizontal,
                            children: restaurant.menus.foods.map((food) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 56.0, horizontal: 4.0),
                                  child: Text(food.name),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                      const Divider(color: Colors.grey),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.local_drink,
                            color: Colors.black,
                            size: 36.0,
                          ),
                          Text('Drinks Menu',
                              style: Theme.of(context).textTheme.subtitle2),
                          const SizedBox(
                            height: 150,
                          ),
                          ListView(
                            scrollDirection: Axis.horizontal,
                            children: restaurant.menus.drinks.map((drink) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Card(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 56.0, horizontal: 4.0),
                                  child: Text(drink.name),
                                ),
                              );
                            }).toList(),
                          ),
                        ],
                      ),*/
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
