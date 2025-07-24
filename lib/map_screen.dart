import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:soldier_tracker/map.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _currentPosition;
  late final MapController _mapController;
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _listenToRealtimeLocation();
  }

  void _listenToRealtimeLocation() {
    final dbRef = FirebaseDatabase.instanceFor(
      app: Firebase.app(),
      databaseURL:
          'https://test-soldier-tracker-default-rtdb.asia-southeast1.firebasedatabase.app/',
    ).ref('soldier_location');

    dbRef.onValue.listen((event) {
      final data = event.snapshot.value;
      if (data is Map &&
          data['latitude'] != null &&
          data['longitude'] != null) {
        _updatePosition(data['latitude'], data['longitude']);
      }
    });
  }

  Future<void> _refreshLocation() async {
    final snapshot =
        await FirebaseDatabase.instance.ref('soldier_location').get();

    final data = snapshot.value;
    if (data is Map && data['latitude'] != null && data['longitude'] != null) {
      _updatePosition(data['latitude'], data['longitude']);
    }
  }

  void _updatePosition(dynamic lat, dynamic lng) {
    if (!mounted) return;

    final newPosition = LatLng(lat.toDouble(), lng.toDouble());
    setState(() => _currentPosition = newPosition);

    // Only try to move the map if it's ready and mounted
    if (_isMapReady && mounted) {
      try {
        _mapController.move(newPosition, 15);
      } catch (e) {
        debugPrint('Error moving map: $e');
      }
    }
  }

  void _centerMap() {
    if (_currentPosition != null && _isMapReady && mounted) {
      try {
        _mapController.move(_currentPosition!, 15);
      } catch (e) {
        debugPrint('Error centering map: $e');
      }
    }
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      title: const Text("Soldier Live Tracker"),
      backgroundColor: Colors.indigo,
      elevation: 4,
      actions: [
        Tooltip(
          message: "Refresh Location",
          child: IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refreshLocation,
          ),
        ),
      ],
    );
  }

  Widget _buildCoordinateOverlay() {
    return Positioned(
      top: 20,
      left: 20,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.white.withOpacity(0.95),
              Colors.white.withOpacity(0.85),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Lat: ${_currentPosition!.latitude.toStringAsFixed(6)}\nLng: ${_currentPosition!.longitude.toStringAsFixed(6)}",
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                fontFamily: 'RobotoMono',
                color: Colors.indigo,
              ),
            ),
            GestureDetector(
              onTap: _centerMap,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.6),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(Icons.gps_fixed, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_currentPosition == null) {
      return Scaffold(
        appBar: _buildAppBar(),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: _buildAppBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: _centerMap,
        backgroundColor: Colors.indigo,
        tooltip: 'Center on Soldier',
        child: const Icon(Icons.gps_fixed, color: Colors.white),
      ),
      body: Stack(
        children: [
          map(
            mapController: _mapController, 
            currentPosition: _currentPosition,
            onMapReady: () {
              setState(() {
                _isMapReady = true;
              });
            },
          ),
          _buildCoordinateOverlay(),
        ],
      ),
    );
  }
}
