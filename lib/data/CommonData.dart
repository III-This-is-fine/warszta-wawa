import 'dart:math';

import 'package:flutter/material.dart';

class CommonData {
  List<(double, double)> markers;
  List<(IconData, String)> categories;

  CommonData({
    required this.markers,
    required this.categories,
  });
}

CommonData mockData() {
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

  return CommonData(
    markers: markers,
    categories: categories,
  );
}
