import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class map extends StatelessWidget {
  const map({
    super.key,
    required MapController mapController,
    required LatLng? currentPosition,
  }) : _mapController = mapController,
       _currentPosition = currentPosition;

  final MapController _mapController;
  final LatLng? _currentPosition;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(initialCenter: _currentPosition!, initialZoom: 15),
      children: [
        TileLayer(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: _currentPosition!,
              width: 80,
              height: 80,
              child: Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.25),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.person_pin_circle,
                  color: Colors.redAccent,
                  size: 50,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
