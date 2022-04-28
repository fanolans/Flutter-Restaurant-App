import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';
import 'package:restaurant_app/utils/restaurant_result_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantSearchProvider({required this.apiService}) {
    fetchQueryRestaurant(query);
  }

  RestaurantSearch? _restaurantList;
  ResultState? _state;
  String _message = '';
  String _query = '';

  String get message => _message;
  String get query => _query;
  RestaurantSearch? get result => _restaurantList;
  ResultState? get state => _state;

  Future<dynamic> fetchQueryRestaurant(String query) async {
    try {
      if (query.isNotEmpty) {
        _state = ResultState.loading;
        _query = query;
        notifyListeners();
        final restaurantList = await apiService.searchRestaurant(query);
        if (restaurantList.restaurants.isEmpty) {
          _state = ResultState.noData;
          notifyListeners();
          return _message = 'Empty Data';
        } else {
          _state = ResultState.hasData;
          notifyListeners();
          return _restaurantList = restaurantList;
        }
      }
    } on SocketException {
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = 'Please check your connection.';
    } catch (e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error --> $e';
    }
  }
}
