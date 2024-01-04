

import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/CommonData.dart';

import 'cathegoryRow.dart';
import 'smallMap.dart';

Widget makeHome(BuildContext context, CommonData? _commonData) {
  var subtitle = (String text) => Padding(
    padding: EdgeInsets.only(left: 15, right: 15),
    //apply padding to all four sides
    child: Text(
      text,
      style: TextStyle(
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    ),
  );

  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        subtitle('Typy zajęć'),
        types(_commonData!.categories),
        subtitle('Mapa'),
        makeMapWidget(context, _commonData.markers, 200),
        SizedBox(height: 100),
        // Tricky way to add padding to the bottom, so that the bottom navigation bar doesn't cover the content
      ],
    ),
  );
}
