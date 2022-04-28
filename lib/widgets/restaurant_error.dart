import 'package:flutter/material.dart';

class RestaurantError extends StatelessWidget {
  const RestaurantError({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Icon(Icons.error, color: Colors.blue, size: 76.0),
        SizedBox(height: 24),
        Text('Something went wrong, check again later.',
            style: TextStyle(color: Colors.grey))
      ],
    );
  }
}
