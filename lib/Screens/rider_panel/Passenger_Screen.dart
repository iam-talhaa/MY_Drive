import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mydrive/res/colors.dart';

class LiveLocationMap extends StatefulWidget {
  @override
  _LiveLocationMapState createState() => _LiveLocationMapState();
}

class _LiveLocationMapState extends State<LiveLocationMap> {
  LatLng? _currentPosition;
  LatLng? _origin;
  LatLng? _destination;
  double? _distanceInKm;
  final mapController = MapController();

  final Color primaryGreen = const Color(0xFF02C697);

  final Map<String, LatLng> places = {
    'Select Location': LatLng(0, 0),
    'University Town': LatLng(33.9986, 71.4966),
    'Hayatabad': LatLng(33.9806, 71.4511),
    'Gulbahar': LatLng(34.0115, 71.5603),
    'Saddar': LatLng(34.0050, 71.5370),
    'Qissa Khwani Bazaar': LatLng(34.0129, 71.5693),
    'Khyber Bazaar': LatLng(34.0122, 71.5541),
    'Tehkal': LatLng(34.0022, 71.5147),
    'Board Bazar': LatLng(33.9763, 71.5122),
    'Peshawar Cantt': LatLng(34.0074, 71.5249),
    'Ring Road': LatLng(33.9804, 71.5003),
  };

  List<Image> myimages = [
    Image.asset('assets/cab.png'),
    Image.asset('assets/motercycle2.png'),
    Image.asset('assets/delivery2.png'),
    Image.asset('assets/Bike.png'),
  ];

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
      _origin = _currentPosition;
    });
  }

  void _updateDistance() {
    if (_origin != null && _destination != null) {
      final Distance distance = Distance();
      setState(() {
        _distanceInKm = distance.as(
          LengthUnit.Kilometer,
          _origin!,
          _destination!,
        );
      });
    }
  }

  void _centerMapToBounds() {
    if (_origin == null || _destination == null) return;

    final latitudes = [_origin!.latitude, _destination!.latitude];
    final longitudes = [_origin!.longitude, _destination!.longitude];

    final southWest = LatLng(
      latitudes.reduce((a, b) => a < b ? a : b),
      longitudes.reduce((a, b) => a < b ? a : b),
    );

    final northEast = LatLng(
      latitudes.reduce((a, b) => a > b ? a : b),
      longitudes.reduce((a, b) => a > b ? a : b),
    );

    final bounds = LatLngBounds(southWest, northEast);

    final cameraFit = CameraFit.bounds(
      bounds: bounds,
      padding: const EdgeInsets.all(80),
      maxZoom: 16,
    );

    mapController.fitCamera(cameraFit);
  }

  void showRouteBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 110,
                margin: const EdgeInsets.symmetric(vertical: 12),
                padding: const EdgeInsets.only(left: 12),
                decoration: BoxDecoration(
                  color: const Color(
                    0xFFEAFBF2,
                  ), // light pastel green background
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: myimages.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(
                        right: 12,
                        top: 10,
                        bottom: 10,
                      ),
                      child: Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xFF1BAF6C),
                            width: 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.green.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child:
                              myimages[index], // e.g., Image.asset(...) or Icon(...)
                        ),
                      ),
                    );
                  },
                ),
              ),

              Text(
                "Where to go?",
                style: TextStyle(
                  // fontFamily: 'SeymourOne',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Origin
              DropdownButtonFormField<String>(
                value:
                    _origin != null
                        ? places.entries
                            .firstWhere(
                              (e) => e.value == _origin!,
                              orElse:
                                  () =>
                                      MapEntry('Select Location', LatLng(0, 0)),
                            )
                            .key
                        : 'Select Location',
                decoration: InputDecoration(
                  labelText: 'Origin',
                  prefixIcon: Icon(Icons.my_location, color: primaryGreen),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items:
                    places.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.key),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null && value != 'Select Location') {
                    setState(() {
                      _origin = places[value];
                      _updateDistance();
                      _centerMapToBounds();
                    });
                  }
                },
              ),

              const SizedBox(height: 12),

              // Destination
              DropdownButtonFormField<String>(
                value:
                    _destination != null
                        ? places.entries
                            .firstWhere(
                              (e) => e.value == _destination!,
                              orElse:
                                  () =>
                                      MapEntry('Select Location', LatLng(0, 0)),
                            )
                            .key
                        : 'Select Location',
                decoration: InputDecoration(
                  labelText: 'Destination',
                  prefixIcon: Icon(Icons.flag, color: Colors.red),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
                items:
                    places.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.key),
                      );
                    }).toList(),
                onChanged: (value) {
                  if (value != null && value != 'Select Location') {
                    setState(() {
                      _destination = places[value];
                      _updateDistance();
                      _centerMapToBounds();
                    });
                  }
                },
              ),

              const SizedBox(height: 20),

              if (_distanceInKm != null)
                Column(
                  children: [
                    Text(
                      "Distance: ${_distanceInKm!.toStringAsFixed(2)} km",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Estimated Fare: Rs. ${(100 + (_distanceInKm! * 25)).toInt()}",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: primaryGreen,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        title: Text(
          "MyDrive - Peshawar",
          style: TextStyle(fontFamily: 'SeymourOne-Regular'),
        ),
        backgroundColor: lightGreen,
        centerTitle: true,
        elevation: 1,
      ),
      body:
          _currentPosition == null
              ? Center(child: CircularProgressIndicator(color: primaryGreen))
              : FlutterMap(
                mapController: mapController,
                options: MapOptions(
                  initialCenter: _currentPosition!,
                  initialZoom: 13.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://api.maptiler.com/maps/streets/{z}/{x}/{y}.png?key=2KHq3M6I8owtjbj2V8Mr",
                    userAgentPackageName: 'com.example.mydrive',
                  ),
                  MarkerLayer(
                    markers: [
                      if (_origin != null)
                        Marker(
                          point: _origin!,
                          width: 40,
                          height: 40,
                          child: Icon(
                            Icons.location_on,
                            color: primaryGreen,
                            size: 32,
                          ),
                        ),
                      if (_destination != null)
                        Marker(
                          point: _destination!,
                          width: 40,
                          height: 40,
                          child: Image(
                            image: AssetImage('assets/pin.png'),
                            width: 40,
                            height: 40,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showRouteBottomSheet,
        backgroundColor: const Color(0xFF4CAF50), // Elegant emerald green
        foregroundColor: Colors.white,
        icon: const Icon(Icons.alt_route_rounded, size: 28),
        label: const Text(
          "Select Route @",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            fontSize: 16,
          ),
        ),
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: Colors.white, width: 1.5),
        ),
      ),
    );
  }
}
