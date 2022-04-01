import 'package:flutter/material.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/model/restaurants.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';
import 'package:flutter/cupertino.dart';
import 'package:restaurant_app/ui/search_page.dart';

class RestaurantListPage extends StatelessWidget {
  const RestaurantListPage({Key? key}) : super(key: key);

  Widget _buildList(BuildContext context) {
    return FutureBuilder<String>(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/local_restaurant.json'),
      builder: (context, snapshot) {
        final List<Restaurant> restaurants = parseRestaurants(snapshot.data);
        return ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return _buildRestaurantItem(context, restaurants[index]);
          },
        );
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
        color: primaryColorBasil,
        child: Card(
          elevation: 5.0,
          margin: EdgeInsets.all(8.0),
          shape: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.white)),
          child: ListTile(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            leading: Hero(
              tag: restaurant.id,
              child: Image.network(
                restaurant.pictureId,
                width: 100,
              ),
            ),
            title: Text(
              'Restaurant ${restaurant.name}',
            ),
            subtitle: Text(
                'Rating ${restaurant.rating} | Location: ${restaurant.city}'),
            onTap: () {
              Navigator.pushNamed(context, RestaurantDetailPage.routeName,
                  arguments: restaurant);
            },
          ),
        ));
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants App'),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => const SearchPage())),
              icon: const Icon(Icons.search))
        ],
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurants App'),
        trailing: Icon(CupertinoIcons.search),
        transitionBetweenRoutes: false,
      ),
      child: _buildList(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
  }
}
