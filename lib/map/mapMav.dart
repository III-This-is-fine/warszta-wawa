import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:warszta_wawa/main.dart';

import '../data/Workshops.dart';
import '../home/smallMap.dart';

Widget makeMap(BuildContext context, List<Workshops> workshops, MyHomePageState state) {
  FlutterView view = WidgetsBinding.instance.platformDispatcher.views.first;

  Size size = view.physicalSize / view.devicePixelRatio;
  double height = size.height;

  return makeMapWidget(context, workshops, height - 250, state);
}
