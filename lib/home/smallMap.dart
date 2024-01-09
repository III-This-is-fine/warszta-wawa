import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:flutter_map_cancellable_tile_provider/flutter_map_cancellable_tile_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:warszta_wawa/data/Constants.dart';
import 'package:warszta_wawa/data/Workshops.dart';
import 'package:warszta_wawa/main.dart';

Widget makeMapWidget(
  BuildContext context,
  List<Workshops> _markers,
  double height,
  MyHomePageState state,
) {
  var markers = _markers.map((e) {
    return Marker(
      width: 100.0,
      height: 100.0,
      point: e.coordinates,
      child: MetaData(
        metaData: e,
        child: Container(
          child: Icon(
            Icons.location_on,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
      ),
    );
  }).toList();

  return Padding(
    padding: const EdgeInsets.all(15.0),
    child: SizedBox(
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: FlutterMap(
          options: const MapOptions(
            initialCenter: LatLng(52.2117577, 20.9823755),
            initialZoom: 16,
          ),
          children: [
            TileLayer(
              urlTemplate: mapURL,
              userAgentPackageName: 'com.tif.warsztawawa',
              tileProvider: CancellableNetworkTileProvider(),
            ),
            MarkerClusterLayerWidget(
              options: MarkerClusterLayerOptions(
                maxClusterRadius: 45,
                size: const Size(40, 40),
                markers: markers,
                onMarkerTap: (marker) {
                  var workshop =
                      (marker.child as MetaData).metaData as Workshops;
                  state.setState(() {
                    state.setSelectedWorkshop(workshop);
                  });
                },
                builder: (context, markers) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        width: 3,
                        color: Theme.of(context).colorScheme.tertiary,
                      ),
                      color: Colors.white,
                    ),
                    child: Center(
                      child: Text(
                        markers.length.toString(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.tertiary,
                          fontSize: 20,
                        ),
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
}
