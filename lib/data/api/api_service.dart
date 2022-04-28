import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/common/api_url.dart';
import 'package:restaurant_app/data/model/restaurant_model.dart';

class ApiService {
  Future<RestaurantList> getRestaurants() async {
    final response = await http.get(Uri.parse(Constant.baseUrl + "list"));
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurants list');
    }
  }

  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    final response =
        await http.get(Uri.parse(Constant.baseUrl + "detail/" + id));
    if (response.statusCode == 200) {
      return RestaurantDetail.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load restaurant detail');
    }
  }

  Future<RestaurantSearch> searchRestaurant(String query) async {
    final response =
        await http.get(Uri.parse(Constant.baseUrl + "search?q=" + query));
    if (response.statusCode == 200) {
      return RestaurantSearch.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load search result');
    }
  }

  Future<RestaurantList> addReview(
      String id, String name, String review) async {
    final response = await http.post(
      Uri.parse(Constant.baseUrl + "review"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
          <String, String>{'id': id, 'name': name, 'review': review}),
    );
    if (response.statusCode == 200) {
      return RestaurantList.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to add review');
    }
  }
}
