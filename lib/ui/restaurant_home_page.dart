import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_list_provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/ui/restaurant_favorite_page.dart';
import 'package:restaurant_app/ui/restaurant_list_page.dart';
import 'package:restaurant_app/ui/restaurant_search_page.dart';
import 'package:restaurant_app/ui/restaurant_settings_page.dart';
import 'package:restaurant_app/widgets/platform_widgets.dart';

class RestaurantHomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const RestaurantHomePage({Key? key}) : super(key: key);

  @override
  State<RestaurantHomePage> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<RestaurantHomePage> {
  int _bottomNavIndex = 0;
  static const String _listText = 'Home';
  static const String _seacrhText = 'Search';
  static const String _favorite = 'Favorite';

  final List<Widget> _listWidget = [
    ChangeNotifierProvider<RestaurantListProvider>(
      create: (_) => RestaurantListProvider(apiService: ApiService()),
      child: const RestaurantListPage(),
    ),
    ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ApiService()),
      child: const RestaurantSearchPage(),
    ),
    const RestaurantFavoritePage(),
    const RestaurantSettingsPage(),
  ];

  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.home : Icons.home,
      ),
      label: _listText,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.search : Icons.search,
      ),
      label: _seacrhText,
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Platform.isIOS ? CupertinoIcons.square_favorites : Icons.favorite,
      ),
      label: _favorite,
    ),
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Restaurants App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, RestaurantSettingsPage.routeName);
            },
          ),
        ],
      ),
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
      ),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        return _listWidget[index];
      },
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
