import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/provider/restaurant_search_provider.dart';
import 'package:restaurant_app/widgets/restaurant_search_card.dart';

class RestaurantSearchPage extends StatefulWidget {
  const RestaurantSearchPage({Key? key}) : super(key: key);

  @override
  State<RestaurantSearchPage> createState() => _RestaurantSearchPageState();
}

class _RestaurantSearchPageState extends State<RestaurantSearchPage> {
  final TextEditingController controller = TextEditingController();
  String output = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RestaurantSearchProvider>(
      create: (_) => RestaurantSearchProvider(apiService: ApiService()),
      child: Consumer<RestaurantSearchProvider>(builder: (context, state, _) {
        return SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(28.0),
                      color: const Color.fromARGB(255, 228, 228, 228),
                    ),
                    child: ListTile(
                      leading: const Icon(
                        Icons.search,
                        size: 28.0,
                      ),
                      title: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Search here...',
                            border: InputBorder.none,
                          ),
                          controller: controller,
                          onChanged: (String query) {
                            if (query.isNotEmpty) {
                              setState(() {
                                output = query;
                              });
                              state.fetchAllRestaurantSearch(output);
                            }
                          }),
                    ),
                  ),
                  (output.isEmpty)
                      ? const Center(
                          child: Text('looking for a restaurant..'),
                        )
                      : Consumer<RestaurantSearchProvider>(
                          builder: (context, state, _) {
                            if (state.state == ResultState.loading) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (state.state == ResultState.hasData) {
                              return ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: state.result!.restaurants.length,
                                  itemBuilder: (context, index) {
                                    var restaurant =
                                        state.result!.restaurants[index];
                                    return RestaurantSearchCard(
                                        restaurant: restaurant);
                                  });
                            } else if (state.state == ResultState.noData) {
                              return Center(child: Text(state.message));
                            } else if (state.state == ResultState.error) {
                              return Center(child: Text(state.message));
                            } else {
                              return const Center(child: Text(''));
                            }
                          },
                        ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
