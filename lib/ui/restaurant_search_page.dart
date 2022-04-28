import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/utils/restaurant_result_state.dart';
import 'package:restaurant_app/widgets/restaurant_error.dart';
import 'package:restaurant_app/widgets/restaurant_card.dart';

class RestaurantSearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<RestaurantSearchPage> {
  String queries = '';
  final TextEditingController _searchControl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(children: [
        _searchBar(),
        const SizedBox(height: 8),
        Expanded(
          child:
              Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state.state == ResultState.hasData) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.result!.restaurants.length,
                  itemBuilder: (context, index) {
                    var restaurant = state.result!.restaurants[index];
                    return CardRestaurant(restaurant: restaurant);
                  });
            } else if (state.state == ResultState.noData) {
              return Center(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: const [
                  Icon(Icons.search_off, color: Colors.grey, size: 64),
                  SizedBox(height: 24),
                  Text('Not found', style: TextStyle(color: Colors.grey))
                ],
              ));
            } else if (state.state == ResultState.noConnection) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const RestaurantError(),
                    const SizedBox(height: 8),
                    Text(state.message),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const RestaurantError(),
                    const SizedBox(height: 8),
                    Text(state.message),
                    const SizedBox(height: 8),
                  ],
                ),
              );
            } else {
              return const Center(child: Text(''));
            }
          }),
        )
      ]),
    ));
  }

  Widget _searchBar() {
    return Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 6.0,
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            child: TextField(
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(10.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.white,
                  ),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                hintText: "Search your restaurant...",
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                hintStyle: const TextStyle(
                  fontSize: 15.0,
                  color: Colors.black,
                ),
              ),
              maxLines: 1,
              controller: _searchControl,
              onChanged: (String query) {
                if (query.isNotEmpty) {
                  setState(() {
                    queries = query;
                  });
                  state.fetchQueryRestaurant(query);
                }
              },
            ),
          ),
        ),
      );
    });
  }
}
