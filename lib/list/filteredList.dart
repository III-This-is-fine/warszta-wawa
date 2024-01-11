import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/CommonData.dart';
import 'package:warszta_wawa/main.dart';

import '../data/Workshops.dart';
import '../workshowList.dart';

Widget makeFilteredList(
    BuildContext context, CommonData? commonData, MyHomePageState state, bool offset,) {
  bool testWorkshop(Workshops workshop) {
    return ((!state.anyCategorySelected() ||
            state.categoriesSelected[workshop.type] == true) &&
        (state.district.isEmpty || state.district == workshop.district) &&
        (doRangesIntersect(state.currentAgeRange, workshop.age)) &&
        (!state.anyPriceSelected() ||
            state.priceSelected[workshop.price] == true) &&
        (!state.anyPeriodSelected() ||
            state.periodSelected[workshop.period] == true) &&
        (!state.anyDaySelected() || state.daySelected[workshop.day] == true));
  }

  var workshopsToShow = commonData!.markers.where(testWorkshop).toList();

  return SingleChildScrollView(
      child: makeWorkshopList(context, workshopsToShow, commonData, state, offset));
}

bool doRangesIntersect(RangeValues currentAge, (int, int) age) {
  double l = max(currentAge.start, age.$1 as double);
  double r = min(currentAge.end, age.$2 as double);

  return l <= r;
}
