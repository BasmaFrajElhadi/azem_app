// mport 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:location/location.dart';
// import 'package:http/http.dart' as http;
//
// class MapScreen extends StatefulWidget {
//   @override
//   State<MapScreen> createState() => _MapState();
// }
//
// class _MapState extends State<MapScreen> {
//   final MapController mapController = MapController();
//   LocationData? currentLocation;
//   // destination
//   List<LatLng> routePoints = []; // Renamed to match PolylineLayer
//   List<Marker> markers = [];
//   final String orsApiKey = '5b3ce3597851110001cf6248c2069c1e54454374bd9d3f9e390d7e88';
//
//   @override
//   void initState() {  // Fixed typo here
//     super.initState();
//     _getCurrentLocation();
//   }
//
//
//   Future<void> _getCurrentLocation() async {
//     var location = Location();
//
//     bool serviceEnabled;
//     PermissionStatus permissionGranted;
//
//     // Check if location services are enabled
//     serviceEnabled = await location.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await location.requestService();
//       if (!serviceEnabled) {
//         // If service is not enabled, default to Misrata, Libya
//         _setDefaultLocation();
//         return;
//       }
//     }
//
//     // Check for location permissions
//     permissionGranted = await location.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await location.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         // If permission is not granted, default to Misrata, Libya
//         _setDefaultLocation();
//         return;
//       }
//     }
//
//     try {
//       // Use a timeout to get the location, default to Misrata if it takes too long
//       var userLocation = await location.getLocation().timeout(
//         Duration(seconds: 10),
//         onTimeout: () {
//           // Return a default LocationData for Misrata in case of a timeout
//           return LocationData.fromMap({
//             'latitude': 32.3754, // Misrata latitude
//             'longitude': 15.0925, // Misrata longitude
//           });
//         },
//       );
//
//       setState(() {
//         currentLocation = userLocation;
//         markers.add(
//           Marker(
//             width: 80.0,
//             height: 80.0,
//             point: LatLng(userLocation.latitude!, userLocation.longitude!),
//             child: const Icon(Icons.my_location, color: Colors.blue, size: 40.0),
//           ),
//         );
//       });
//     } on Exception {
//       // If there is any error, fall back to Misrata, Libya
//       _setDefaultLocation();
//     }
//
//     // Listen to location changes and update the location
//     location.onLocationChanged.listen((LocationData newLocation) {
//       setState(() {
//         currentLocation = newLocation;
//       });
//     });
//   }
//
// // Set default location to Misrata, Libya
//   void _setDefaultLocation() {
//     const misrataLocation = LatLng(32.3754, 15.0925); // Coordinates for Misrata, Libya
//     setState(() {
//       currentLocation = LocationData.fromMap({
//         'latitude': misrataLocation.latitude,
//         'longitude': misrataLocation.longitude,
//       });
//       markers.add(
//         Marker(
//           width: 80.0,
//           height: 80.0,
//           point: misrataLocation,
//           child: const Icon(Icons.my_location, color: Colors.blue, size: 40.0),
//         ),
//       );
//     });
//   }
//
//   Future<void> _getRoute(LatLng destination) async {
//     if (currentLocation == null) return;
//     final start = LatLng(currentLocation!.latitude!, currentLocation!.longitude!);
//     final response = await http.get(
//       Uri.parse(
//         'https://api.openrouteservice.org/v2/directions/driving-car?api_key=$orsApiKey&start=${start.longitude},${start.latitude}&end=${destination.longitude},${destination.latitude}',
//       ),
//     );
//
//     if (response.statusCode == 200) {
//       final data = json.decode(response.body);
//       final List<dynamic> coords =
//       data['features'][0]['geometry']['coordinates'];
//       setState(() {
//         routePoints = coords.map((coord) => LatLng(coord[1], coord[0])).toList();
//         markers.add(
//           Marker(
//             width: 80.0,
//             height: 80.0,
//             point: destination,
//             child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
//           ),
//         );
//       });
//     } else {
//       print("Failed to find route");
//     }
//   }
//
//   void _addDestinationMarker(LatLng point) {
//     setState(() {
//       markers.add(
//         Marker(
//           width: 80.0,
//           height: 80.0,
//           point: point,
//           child: const Icon(Icons.location_on, color: Colors.red, size: 40.0),
//         ),
//       );
//     });
//     _getRoute(point);
//   }
//
//   @override
//   @override
//   @override
//   Widget build(BuildContext context) {
//     return currentLocation == null
//         ? const Center(child: CircularProgressIndicator()) // Show loading indicator until location is fetched
//         : FlutterMap(
//       mapController: mapController,
//       options: MapOptions(
//         initialCenter: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
//         initialZoom: 15.0,
//         onTap: (tapPosition, point) => _addDestinationMarker(point),
//       ),
//       children: [
//         TileLayer(
//           urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
//           subdomains: const ['a', 'b', 'c'],
//         ),
//         MarkerLayer(markers: markers),
//         PolylineLayer(
//           polylines: [
//             Polyline(
//               points: routePoints,
//               strokeWidth: 4.0,
//               color: Colors.blue,
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//
//
// }
