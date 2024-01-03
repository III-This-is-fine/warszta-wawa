
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

var makeMap = (BuildContext context, List<(double, double)> markers) => Padding(
  padding: const EdgeInsets.all(15.0),
  child: SizedBox(
    height: 200,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(20.0),
      child: FlutterMap(
        options: const MapOptions(
          initialCenter: LatLng(52.2117577, 20.9823755),
          initialZoom: 16,
        ),
        children: [
          TileLayer(
            urlTemplate:
            'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
            userAgentPackageName: 'com.example.app',
          ),
          MarkerLayer(
            markers: markers.map((e) {
              return Marker(
                width: 80.0,
                height: 80.0,
                point: LatLng(e.$1, e.$2),
                child: Container(
                  child: Icon(Icons.circle,
                      color: Theme.of(context).colorScheme.tertiary),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    ),
  ),
);