import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/CommonData.dart';

import 'data/Workshops.dart';
import 'home/homeNav.dart';
import 'main.dart';
import 'map/mapMav.dart';
import 'search/searchNav.dart';

Widget makeNav(
  MyHomePageState homePageState,
  BuildContext context,
  CommonData? _commonData,
  int _selectedDestination,
  List<Workshops> workshops,
) {
  switch (_selectedDestination) {
    case 0:
      return makeHome(context, _commonData);
    case 1:
      return makeSearch(homePageState, context, _commonData);
    case 2:
      return makeMap(context, workshops);
  }
  return Center(child: Text('Nothing to see here...'));
}
