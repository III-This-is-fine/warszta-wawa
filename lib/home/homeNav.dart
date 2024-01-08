

import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/CommonData.dart';

import '../main.dart';
import 'cathegoryRow.dart';
import 'smallMap.dart';

Widget makeHome(MyHomePageState homePageState, BuildContext context, CommonData? _commonData) {
  return SingleChildScrollView(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        subtitle('Typy zajęć'),
        types(_commonData!.categories, homePageState),
        subtitle('Mapa'),
        makeMapWidget(context, _commonData.markers, 200),
        SizedBox(height: 100),
        // Tricky way to add padding to the bottom, so that the bottom navigation bar doesn't cover the content
      ],
    ),
  );
}
