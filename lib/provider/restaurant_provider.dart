import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/list_restaurants.dart';
import 'package:restaurant_app/data/api/api_service.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantListProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantListProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  late ListRestaurant _listRestaurant;
  late ResultState _state;
  String _message = '';

  String get message => _message;

  ListRestaurant get result => _listRestaurant;

  ResultState get state => _state;

  Future<dynamic> _fetchAllRestaurants() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final restaurant = await apiService.getListRestaurant();
      if (restaurant.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _listRestaurant = restaurant;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
