import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

enum ResultState { loading, noData, hasData, error }

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    fetchAllRestaurantSearch(query);
  }

  late SearchRestaurant? _searchRestaurant;
  late ResultState? _state;

  String _message = '';
  String _query = '';

  String get message => _message;
  String get query => _query;

  SearchRestaurant? get result => _searchRestaurant;

  ResultState? get state => _state;

  Future<dynamic> fetchAllRestaurantSearch(String query) async {
    try {
      _state = ResultState.loading;
      _query = query;

      final restaurantSearch = await apiService.getSearchRestaurant(query);
      if (restaurantSearch.restaurants.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.hasData;

        notifyListeners();
        return _searchRestaurant = restaurantSearch;
      }
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Failed To Load Data, Please Check Your Connection';
    }
  }
}
