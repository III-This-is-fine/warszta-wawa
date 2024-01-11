import 'dart:math';

import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/CommonData.dart';
import 'package:warszta_wawa/main.dart';

import '../data/Workshops.dart';
import '../workshowList.dart';

Widget makeFilteredList(
  BuildContext context,
  CommonData? commonData,
  MyHomePageState state,
  bool offset,
) {
  var workshopsToShow = commonData!.markers.where((x) => testWorkshop(x, state)).toList();

  return SingleChildScrollView(
    child: makeWorkshopList(
      context,
      workshopsToShow,
      commonData,
      state,
      offset,
      330
    ),
  );
}

bool testWorkshop(Workshops workshop, MyHomePageState state) {
  return ((!state.anyCategorySelected() ||
      state.categoriesSelected[workshop.type] == true) &&
      (state.district.isEmpty || state.district == workshop.district) &&
      (doRangesIntersect(state.currentAgeRange, workshop.age)) &&
      (!state.anyPriceSelected() ||
          state.priceSelected[workshop.price] == true) &&
      (!state.anyPeriodSelected() ||
          state.periodSelected[workshop.period] == true) &&
      (!state.anyDaySelected() || state.daySelected[workshop.day] == true) &&
      (state.keywords.isEmpty || isRelevant(workshop, state.keywords)));
}

bool doRangesIntersect(RangeValues currentAge, (int, int) age) {
  double l = max(currentAge.start, age.$1 as double);
  double r = min(currentAge.end, age.$2 as double);

  return l <= r;
}

bool isRelevant(Workshops workshops, String keywordWithSpaces) {
  var keywords = keywordWithSpaces.split(' ');
  for (var keyword in keywords) {
    if (!keyword.isEmpty) {
      if (!(workshops.title.toLowerCase().contains(keyword.toLowerCase()) ||
          workshops.description.toLowerCase().contains(keyword.toLowerCase()) ||
          workshops.place.toLowerCase().contains(keyword.toLowerCase()) ||
          workshops.district.toLowerCase().contains(keyword.toLowerCase()) ||
          workshops.type.toLowerCase().contains(keyword.toLowerCase()) ||
          workshops.price.toLowerCase().contains(keyword.toLowerCase()) ||
          workshops.period.toLowerCase().contains(keyword.toLowerCase()) ||
          workshops.day.toLowerCase().contains(keyword.toLowerCase()))) {
        return false;
      }
    }
  }
  return true;
}
