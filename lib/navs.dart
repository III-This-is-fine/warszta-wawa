import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/CommonData.dart';

import 'home/homeNav.dart';
import 'map/mapMav.dart';
import 'search/searchNav.dart';

Widget makeNav(
    BuildContext context, CommonData? _commonData, int _selectedDestination) {
  switch (_selectedDestination) {
    case 0:
      return makeHome(context, _commonData);
    case 1:
      return makeSearch(context, _commonData);
    case 2:
      return makeMap(context, _commonData);
  }
  return Center(child: Text('Nothing to see here...'));
}
