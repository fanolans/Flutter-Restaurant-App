import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/list_restaurants.dart';
import 'package:restaurant_app/data/model/detail_restaurant.dart';
import 'package:restaurant_app/data/model/search_restaurant.dart';

class ApiService {
  static const String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<ListRestaurant> getListRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "/list"));
    if (response.statusCode == 200) {
      return ListRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list restaurants');
    }
  }

  Future<DetailRestaurant> getDetailRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "/detail/:id"));
    if (response.statusCode == 200) {
      return DetailRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load detail restaurant');
    }
  }

  Future<SearchRestaurant> getSearchRestaurant() async {
    final response = await http.get(Uri.parse(_baseUrl + "/search?q=query"));
    if (response.statusCode == 200) {
      return SearchRestaurant.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to search restaurant');
    }
  }
}
