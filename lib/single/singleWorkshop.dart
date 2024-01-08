import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/CommonData.dart';
import '../main.dart';

Widget makeSingleWorkshop(
    BuildContext context, CommonData? commonData, MyHomePageState state) {
  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeTitle(
            context,
            Text('xd'),
            Colors.white,
          ),
          SizedBox(height: 100),
        ],
      ),
    ),
  );
}

Widget makeTitle(BuildContext context, Widget inside, Color color) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black,
            blurRadius: 0.1,
            offset: Offset(0, 1), // Shadow position
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: inside,
      ),
    ),
  );
}
