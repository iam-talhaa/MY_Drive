import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class LiveLocationMap extends StatefulWidget {
  @override
  _LiveLocationMapState createState() => _LiveLocationMapState();
}

class _LiveLocationMapState extends State<LiveLocationMap> {
  LatLng? _currentPosition;
  LatLng? _destination;
  double? _distanceInKm;
  final mapController = MapController();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.deniedForever) return;

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      _currentPosition = LatLng(position.latitude, position.longitude);
    });
  }

  void _updateDistance() {
    if (_currentPosition != null && _destination != null) {
      final Distance distance = Distance();
      _distanceInKm = distance.as(
        LengthUnit.Kilometer,
        _currentPosition!,
        _destination!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Live Location & Distance")),
      body:
          _currentPosition == null
              ? Center(child: CircularProgressIndicator())
              : FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: _currentPosition!,
                  initialZoom: 15.0,
                  onTap: (tapPosition, latlng) {
                    setState(() {
                      _destination = latlng;
                      _updateDistance();
                    });
                  },
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=2KHq3M6I8owtjbj2V8Mr",
                    userAgentPackageName: 'com.example.mydrive',
                  ),
                  MarkerLayer(
                    markers: [
                      // Current Location Marker
                      Marker(
                        point: _currentPosition!,
                        width: 50,
                        height: 50,
                        child: Icon(
                          Icons.my_location,
                          color: Colors.blue,
                          size: 40,
                        ),
                      ),
                      // Destination Marker (only if set)
                      if (_destination != null)
                        Marker(
                          point: _destination!,
                          width: 50,
                          height: 50,
                          child: Icon(Icons.flag, color: Colors.red, size: 40),
                        ),
                    ],
                  ),
                ],
              ),
      bottomNavigationBar:
          _distanceInKm != null
              ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  "Distance to Destination: ${_distanceInKm!.toStringAsFixed(2)} km",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
              : SizedBox(),
    );
  }
}
