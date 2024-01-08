import 'dart:math';

import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:warszta_wawa/data/Workshops.dart';
import 'package:warszta_wawa/data/WorkshopsData.dart';

class CommonData {
  List<Workshops> markers;
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

  var workshopsFiltered = workshops.toList();

  var today = DateTime.now();
  var rand = new Random(today.year + today.month + today.day);
  workshopsFiltered.shuffle(rand);
  var take = 100;

  return CommonData(
    markers: workshopsFiltered.sublist(0, take),
    categories: categories,
    districts: distincts,
  );
}
