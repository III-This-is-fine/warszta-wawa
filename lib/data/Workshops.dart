import 'package:latlong2/latlong.dart';

class Workshops {
  String title;
  String type;
  String place;
  LatLng coordinates;
  String district;
  String period;
  String day;
  (int, int) age;
  String description;
  String price;

  Workshops(
    this.title,
    this.type,
    this.place,
    this.coordinates,
    this.district,
    this.period,
    this.day,
    this.age,
    this.description,
    this.price,
  );
}
