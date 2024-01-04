
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:warszta_wawa/data/CommonData.dart';

import 'cathegoryRow.dart';
import 'smallMap.dart';

Widget makeHome(BuildContext context, CommonData? _commonData) {
  const categories = [
    (Icons.sports_volleyball_outlined, 'Sportowe'),
    (Icons.palette_outlined, 'Artystyczne'),
    (Icons.school_outlined, 'Naukowe'),
    (Icons.music_note_outlined, 'Muzyczne'),
    (Icons.chat_bubble_outline_outlined, 'Językowe'),
    (Icons.fitness_center_outlined, 'Fitness'),
    (Icons.accessibility_new_outlined, 'Taniec'),
    (Icons.local_library_outlined, 'Inne'),
  ];

  const N = 100;
  const latMin = 52.1348782;
  const latMax = 52.3219161;
  const lonMin = 20.8023824;
  const lonMax = 21.2087757;

  var rng = new Random();
  var markers = List.generate(
      N,
          (i) => (
      rng.nextDouble() * (latMax - latMin) + latMin,
      rng.nextDouble() * (lonMax - lonMin) + lonMin
      ));

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
        types(categories),
        subtitle('Mapa'),
        makeMap(context, markers),
        SizedBox(height: 100),
        // Tricky way to add padding to the bottom, so that the bottom navigation bar doesn't cover the content
      ],
    ),
  );
}
