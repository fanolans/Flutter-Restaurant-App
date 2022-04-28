import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_preferences_provider.dart';
import 'package:restaurant_app/provider/restaurant_scheduling_provider.dart';
import 'package:restaurant_app/widgets/restaurant_custom_dialog.dart';

class RestaurantSettingsPage extends StatelessWidget {
  static const routeName = '/settings_page';
  const RestaurantSettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(builder: (context, provider, child) {
      return ListView(children: [
        Material(
            child: ListTile(
                title: const Text('Notification'),
                subtitle: const Text('Enable or Disable'),
                trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                  return Switch.adaptive(
                      value: provider.isDailyRestaurantActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          RestaurantcustomDialog(context);
                        } else {
                          scheduled.scheduledRestaurant(value);
                          provider.enableDailyRecommendedRestaurant(value);
                        }
                      });
                }))),
        Material(
            child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                    value: false,
                    onChanged: (value) => RestaurantcustomDialog(context))))
      ]);
    });
  }
}
