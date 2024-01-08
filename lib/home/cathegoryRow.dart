import 'package:flutter/material.dart';

import '../main.dart';

Widget types(List<(IconData, String)> categories, MyHomePageState homePageState) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 100,
    child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((e) {
          return GestureDetector(
            onTap: () {
              homePageState.setState(() {
                homePageState.cleanSelections();
                homePageState.setCategory(e.$2, true);
                homePageState.selectedDestination = 1;
              });
            },
            child: Container(
              width: 90,
              // color: Colors.red,
              child: Column(
                children: [
                  Icon(e.$1, size: 72),
                  Text(e.$2),
                ],
              ),
            ),
          );
        }).toList()),
  );
}
