import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:latlong2/latlong.dart';
import 'package:warszta_wawa/data/Constants.dart';

Future<void> initializeCache() async {
  final region = CircleRegion(
    LatLng(52.2116999, 20.9824369),
    18,
  );

  final downloadable = region.toDownloadable(
    minZoom: 1,
    maxZoom: 18,
    options: TileLayer(
      urlTemplate: mapURL,
      userAgentPackageName: 'com.tif.warsztawawa.background',
    ),
  );

  await FlutterMapTileCaching.initialise();
  await FMTC.instance(mapStore).manage.createAsync();
  await FMTC.instance(mapStore).download.startForeground(region: downloadable);
}

TileProvider? tileProvider = FMTC.instance(mapStore).getTileProvider();
