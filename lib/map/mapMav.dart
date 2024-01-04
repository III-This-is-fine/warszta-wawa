import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';

import '../data/CommonData.dart';
import '../home/smallMap.dart';

Widget makeMap(BuildContext context, CommonData? _commonData) {
  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

  Size size = view.physicalSize / view.devicePixelRatio;
  double height = size.height;

  return makeMapWidget(context, _commonData!.markers, height - 250);
}
