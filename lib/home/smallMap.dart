import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';

var makeMap = (BuildContext context, List<(double, double)> _markers) {
  var markers = _markers.map((e) {
    return Marker(
      width: 80.0,
      height: 80.0,
      point: LatLng(e.$1, e.$2),
      child: Container(
        child:
            Icon(Icons.circle, color: Theme.of(context).colorScheme.tertiary),
      ),
    );
  }).toList();

  return Padding(
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
                  'https://api.maptiler.com/maps/basic-v2/{z}/{x}/{y}.png?key=Udj6fSqM6nelUHq2HVmP',
              userAgentPackageName: 'com.tif.warsztawawa',
              tileProvider: CancellableNetworkTileProvider(),
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 45,
                size: const Size(40, 40),
                markers: markers,
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Theme.of(context).colorScheme.secondary),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    ),
  );
};
