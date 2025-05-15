import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng _currentPosition = LatLng(23.8103, 90.4125); // Default location

  @override
  void initState() {
    super.initState();
    listenToRealtimeLocation(); // Listen for live updates
  }

  void listenToRealtimeLocation() {
    final dbRef = FirebaseDatabase.instance.ref('soldier_location');

    dbRef.onValue.listen((event) {
      final data = event.snapshot.value;

      if (data is Map) {
        final lat = data['latitude'];
        final lng = data['longitude'];

        if (lat != null && lng != null) {
          setState(() {
            _currentPosition = LatLng(lat.toDouble(), lng.toDouble());
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Live Soldier Location")),
      body: FlutterMap(
        options: MapOptions(initialCenter: _currentPosition, initialZoom: 15),
        children: [
          TileLayer(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c'],
          ),
          MarkerLayer(
            markers: [
              Marker(
                point: _currentPosition,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.red,
                  size: 40,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
