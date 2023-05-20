import 'dart:math' show asin, atan2, cos, pi, sin, sqrt;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_map_polyline_new/google_map_polyline_new.dart';

class DistanceCalculator {
  static final GoogleMapPolyline _googleMapPolyline = GoogleMapPolyline(
    apiKey: "AIzaSyAuoP6TiDcR5PALm3f1J2-T9A0l7w93hHQ",
  );

  // Polyline patterns
  static final List<List<PatternItem>> patterns = <List<PatternItem>>[
    <PatternItem>[], //line
    <PatternItem>[PatternItem.dash(30.0), PatternItem.gap(20.0)], //dash
    <PatternItem>[PatternItem.dot, PatternItem.gap(10.0)], //dot
    <PatternItem>[
      //dash-dot
      PatternItem.dash(30.0),
      PatternItem.gap(20.0),
      PatternItem.dot,
      PatternItem.gap(20.0)
    ],
  ];

  static Future<Future<List<LatLng>?>> getCoordinatesWithLocation({
    required LatLng origin,
    required LatLng destination,
    required RouteMode mode,
  }) async {
    return _googleMapPolyline.getCoordinatesWithLocation(
      origin: origin,
      destination: destination,
      mode: mode,
    );
  }

  static double distanceBetween(LatLng from, LatLng to) {
    const int earthRadius = 6371000; // in meters

    double lat1 = from.latitude * (pi / 180.0);
    double lon1 = from.longitude * (pi / 180.0);
    double lat2 = to.latitude * (pi / 180.0);
    double lon2 = to.longitude * (pi / 180.0);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1) * cos(lat2) * sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    double distance = (earthRadius * c);

    return distance;
  }

  static double calculateDistance(List<LatLng>? coordinates) {
    double distance = 0.0;
    if (coordinates != null && coordinates.length > 1) {
      for (int i = 0; i < coordinates.length - 1; i++) {
        LatLng from = coordinates[i];
        LatLng to = coordinates[i + 1];
        distance += distanceBetween(from, to);
      }
    }
    return distance;
  }
}
