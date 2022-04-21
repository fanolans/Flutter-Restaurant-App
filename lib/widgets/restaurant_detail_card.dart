import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';

class RestaurantDetailCard extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetailCard({Key? key, required this.restaurant})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            Hero(
              tag: restaurant.pictureId,
              child: Image.network(
                "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Restaurant: ${restaurant.name}',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 20,
                      ),
                      Text(
                        'Location: ${restaurant.city}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 20,
                      ),
                      Text(
                        'Rating: ${restaurant.rating}',
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ],
                  ),
                  const Divider(color: Colors.grey),
                  const SizedBox(height: 10),
                  Text(restaurant.description,
                      style: Theme.of(context).textTheme.bodyText2),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            const Text('Foods Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: restaurant.menus.foods
                        .map((food) => Text(food.name))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(
              color: Colors.grey,
            ),
            const SizedBox(height: 10),
            const Text('Drinks Menu',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: restaurant.menus.drinks
                        .map((drink) => Text(drink.name))
                        .toList(),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(color: Colors.grey),
            const SizedBox(height: 10),
            const Text('Review',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SingleChildScrollView(
              padding: const EdgeInsets.all(8),
              scrollDirection: Axis.horizontal,
              child: Column(
                children: [
                  Row(
                    children: restaurant.customerReviews
                        .map((review) => Column(
                              children: [
                                Row(
                                  children: [
                                    Text(review.name),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(review.review),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(review.date),
                                  ],
                                ),
                              ],
                            ))
                        .toList(),
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
