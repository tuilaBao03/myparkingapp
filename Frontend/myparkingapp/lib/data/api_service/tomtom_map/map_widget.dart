// ignore_for_file: deprecated_member_use, avoid_print, library_private_types_in_public_api

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart'; // Đảm bảo bạn đang sử dụng latlong2 package
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:geolocator/geolocator.dart';

class MapWidget {
  final String apiKey = "9Gug0whGGq8v1H7AtidZcOGLbOV32mtm";
  final LatLng endPoint;

  MapWidget({required this.endPoint});
  /// Kiểm tra quyền truy cập vị trí
  Future<bool> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("⚠️ User denied location permission.");
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      print("❌ Location permission permanently denied.");
      return false;
    }
    return true;
  }

  /// Lấy vị trí hiện tại, chỉ khi đã có quyền
  Future<LatLng?> getCurrentLocation() async {
    bool hasPermission = await checkLocationPermission();
    if (!hasPermission) {
      return null;
    }

    try {
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      return LatLng(position.latitude, position.longitude);
    } catch (e) {
      print("❌ Error getting current location: $e");
      return null;
    }
  }

  Future<List<LatLng>> fetchRoute(LatLng startPoint) async {
    final url =
        "https://api.tomtom.com/routing/1/calculateRoute/${startPoint.latitude},${startPoint.longitude}:${endPoint.latitude},${endPoint.longitude}/json?key=$apiKey";

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final routes = data['routes'] as List;
      if (routes.isNotEmpty) {
        final points = routes[0]['legs'][0]['points'] as List;
        return points
            .map((point) => LatLng(point['latitude'], point['longitude']))
            .toList();
      }
    } else {
      print("Error fetching route: ${response.statusCode}");
    }
    return [];
  }

  Widget buildBasicMap(LatLng initialLocation) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: initialLocation,
        initialZoom: 17.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
              "https://api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=$apiKey",
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: initialLocation,
              child: Icon(
                Icons.my_location,
                color: Colors.green,
                size: 40,
              ),
            ),
            Marker(
              point: endPoint,
              child: Icon(
                Icons.flag,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildRouteMap(LatLng initialLocation, List<LatLng> routePoints) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: initialLocation,
        initialZoom: 17.0,
      ),
      children: [
        TileLayer(
          urlTemplate:
              "https://api.tomtom.com/map/1/tile/basic/main/{z}/{x}/{y}.png?key=$apiKey",
        ),
        if (routePoints.isNotEmpty)
          PolylineLayer(
            polylines: [
              Polyline(
                points: routePoints,
                color: Colors.blue,
                strokeWidth: 4.0,
              ),
            ],
          ),
        MarkerLayer(
          markers: [
            Marker(
              point: initialLocation,
              child: Icon(
                Icons.my_location,
                color: Colors.green,
                size: 40,
              ),
            ),
            Marker(
              point: endPoint,
              child: Icon(
                Icons.flag,
                color: Colors.red,
                size: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}

