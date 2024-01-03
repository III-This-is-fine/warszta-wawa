import 'package:flutter/material.dart';

var types = (List<(IconData, String)> categories) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 10),
    height: 100,
    child: ListView(
        scrollDirection: Axis.horizontal,
        children: categories.map((e) {
          return Container(
            width: 90,
            // color: Colors.red,
            child: Column(
              children: [
                Icon(e.$1, size: 72),
                Text(e.$2),
              ],
            ),
          );
        }).toList()),
  );
};
