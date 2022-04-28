import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_favorite_database_provider.dart';
import 'package:restaurant_app/utils/restaurant_result_state.dart';
import 'package:restaurant_app/widgets/restaurant_error.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class RestaurantFavoritePage extends StatelessWidget {
  static const routeName = 'favorite_page';

  const RestaurantFavoritePage({Key? key}) : super(key: key);

  Widget _buildList() {
    return Scaffold(
      body: Consumer<FavoriteDatabaseProvider>(
          builder: (context, provider, child) {
        if (provider.state == ResultState.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (provider.state == ResultState.hasData) {
          return ListView.builder(
              shrinkWrap: true,
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                var restaurant = provider.favorites[index];
                return CardRestaurant(restaurant: restaurant);
              });
        } else if (provider.state == ResultState.noData) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const RestaurantError(),
                const SizedBox(height: 8),
                Text(provider.message),
                const SizedBox(height: 8),
              ],
            ),
          );
        } else if (provider.state == ResultState.noConnection) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const RestaurantError(),
                const SizedBox(height: 8),
                Text(provider.message),
                const SizedBox(height: 8),
              ],
            ),
          );
        } else if (provider.state == ResultState.error) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                const RestaurantError(),
                const SizedBox(height: 8),
                Text(provider.message),
                const SizedBox(height: 8),
              ],
            ),
          );
        } else {
          return const Center(child: Text(''));
        }
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildList();
  }
}
