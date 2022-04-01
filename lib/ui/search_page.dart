import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Color.fromARGB(255, 240, 240, 240),
            borderRadius: BorderRadius.circular(18.0)),
        child: Center(
          child: TextField(
            decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.black,
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.clear),
                  onPressed: () {},
                ),
                hintText: 'Search Restaurant...',
                border: InputBorder.none),
          ),
        ),
      )),
    );
  }
}
