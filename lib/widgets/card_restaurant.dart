import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/model/list_restaurants.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

class CardListRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardListRestaurant({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: primaryColorBasil,
      child: ListTile(
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Hero(
            tag: restaurant.pictureId,
            child: Image.network(
              'https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}',
              width: 100,
            )),
        title: Text(restaurant.name),
        subtitle: Text('${restaurant.city} | Rating ${restaurant.rating}'),
        onTap: () => Navigator.pushNamed(
            context, RestaurantDetailPage.routeName,
            arguments: restaurant.id),
      ),
    );
  }
}
