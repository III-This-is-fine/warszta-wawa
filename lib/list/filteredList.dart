
import 'package:flutter/cupertino.dart';
import 'package:warszta_wawa/data/CommonData.dart';
import 'package:warszta_wawa/main.dart';

import '../workshowList.dart';

Widget makeFilteredList(BuildContext context, CommonData? commonData, MyHomePageState state) {
  return SingleChildScrollView(child: makeWorkshopList(context, commonData!.markers, commonData));
}
