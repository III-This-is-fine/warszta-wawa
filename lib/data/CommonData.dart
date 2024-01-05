import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class CommonData {
  List<(double, double)> markers;
  List<(IconData, String)> categories;
  List<(String, LatLng)> districts;

  CommonData({
    required this.markers,
    required this.categories,
    required this.districts,
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

  const N = 10;
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

  var distincts = [
    ("Żoliborz", LatLng(0, 0)),
    ("Wola", LatLng(0, 0)),
    ("Włochy", LatLng(0, 0)),
    ("Wilanów", LatLng(0, 0)),
    ("Wesoła", LatLng(0, 0)),
    ("Wawer", LatLng(0, 0)),
    ("Ursynów", LatLng(0, 0)),
    ("Ursus", LatLng(0, 0)),
    ("Targówek", LatLng(0, 0)),
    ("Śródmieście", LatLng(0, 0)),
    ("Rembertów", LatLng(0, 0)),
    ("Praga-Północ", LatLng(0, 0)),
    ("Praga-Południe", LatLng(0, 0)),
    ("Ochota", LatLng(0, 0)),
    ("Mokotów", LatLng(0, 0)),
    ("Bielany", LatLng(0, 0)),
    ("Białołęka", LatLng(0, 0)),
    ("Bemowo", LatLng(0, 0)),
  ];

  distincts.sort((a, b) => a.$1.compareTo(b.$1));

  return CommonData(
    markers: markers,
    categories: categories,
    districts: distincts,
  );
}
