import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigaion.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/provider/restaurant_favorite_database_provider.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';

import 'package:provider/provider.dart';

class CardRestaurant extends StatelessWidget {
  final Restaurant restaurant;
  const CardRestaurant({Key? key, required this.restaurant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<FavoriteDatabaseProvider>(
        builder: (context, provider, child) {
      return FutureBuilder<bool>(
          future: provider.isFavorited(restaurant.id),
          builder: (context, snapshot) {
            var isFavorited = snapshot.data ?? false;
            return Material(
                child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              leading: Hero(
                  tag: restaurant.pictureId,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.network(
                        "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                        width: 100,
                        height: 100,
                        fit: BoxFit.fill),
                  )),
              title: Text(restaurant.name),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                        size: 18.0,
                      ),
                      Text(restaurant.city),
                    ],
                  ),
                  const SizedBox(height: 2.0),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.orange,
                        size: 18.0,
                      ),
                      Text("${restaurant.rating}"),
                    ],
                  ),
                ],
              ),
              trailing: isFavorited
                  ? IconButton(
                      icon: const Icon(Icons.favorite),
                      color: Colors.red,
                      onPressed: () => provider.removeFavorite(restaurant.id),
                    )
                  : IconButton(
                      icon: const Icon(Icons.favorite_border),
                      color: Colors.red,
                      onPressed: () => provider.addFavorite(restaurant),
                    ),
              onTap: () => Navigation.intentWithData(
                  RestaurantDetailPage.routeName, restaurant.id),
            ));
          });
    });
  }
}
