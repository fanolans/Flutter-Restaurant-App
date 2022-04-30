import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_detail_provider.dart';
import 'package:restaurant_app/utils/restaurant_result_state.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';
import 'package:restaurant_app/widgets/restaurant_detail_card.dart';

class RestaurantDetailPage extends StatelessWidget {
  static const routeName = '/detail_page';
  final String id;

  const RestaurantDetailPage({Key? key, required this.id}) : super(key: key);

  Widget _buildDetail() {
    return ChangeNotifierProvider<RestaurantDetailProvider>(
      create: (_) => RestaurantDetailProvider(apiService: ApiService(), id: id),
      child: Consumer<RestaurantDetailProvider>(
        builder: (context, state, _) {
          if (state.state == ResultState.loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.state == ResultState.hasData) {
            final restaurants = state.result.restaurant;
            return RestaurantDetailCard(
              restaurant: restaurants,
            );
          } else if (state.state == ResultState.noData) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.noConnection) {
            return Center(child: Text(state.message));
          } else if (state.state == ResultState.error) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text(''));
          }
        },
      ),
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants App'),
      ),
      body: _buildDetail(),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        middle: Text('Restaurants App'),
        trailing: Icon(CupertinoIcons.search),
        transitionBetweenRoutes: false,
      ),
      child: _buildDetail(),
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
