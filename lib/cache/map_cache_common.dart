import 'map_cache.dart'
    if (dart.library.io) 'map_cache_mobile.dart'
    if (dart.library.html) 'map_cache_web.dart';

var provider = tileProvider;
var initialize = initializeCache;
