import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurants.dart';
import 'package:restaurant_app/ui/restaurant_detail_page.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/common/styles.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Restaurants App',
      theme: ThemeData(
        primaryColor: primaryColorBasil,
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: myTextTheme,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 2,
          toolbarTextStyle:
              myTextTheme.apply(bodyColor: Colors.black).bodyText2,
          titleTextStyle: myTextTheme.apply(bodyColor: Colors.black).headline6,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
        ),
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: secondaryColorBasil),
      ),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
