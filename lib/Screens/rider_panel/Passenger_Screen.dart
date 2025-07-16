import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mydrive/res/colors.dart';
import 'package:mydrive/widgets/custom_Button.dart';

class LiveLocationMap extends StatefulWidget {
  @override
  _LiveLocationMapState createState() => _LiveLocationMapState();
}

class _LiveLocationMapState extends State<LiveLocationMap> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // ✅ Precache images here to avoid MediaQuery error
    precacheImage(const AssetImage('assets/cab.png'), context);
    precacheImage(const AssetImage('assets/motercycle2.png'), context);
    precacheImage(const AssetImage('assets/delivery2.png'), context);
    precacheImage(const AssetImage('assets/Bike.png'), context);
  }

  LatLng? _currentPosition;
  LatLng? _origin;
  LatLng? _destination;
  double? _distanceInKm;
  final mapController = MapController();

  final Color primaryGreen = const Color(0xFF02C697);

  final Map<String, LatLng> places = {
    'Select Location': LatLng(0, 0),

    // 📍 Central Peshawar
    'Peshawar City Center': LatLng(34.0080, 71.5785),
    'Saddar': LatLng(34.0050, 71.5370),
    'Peshawar Cantt': LatLng(34.0074, 71.5249),
    'Qissa Khwani Bazaar': LatLng(34.0129, 71.5693),
    'Khyber Bazaar': LatLng(34.0122, 71.5541),
    'Chowk Yadgar': LatLng(34.0060, 71.5700),

    // 🏫 Educational Areas
    'University Town': LatLng(33.9986, 71.4966),
    'Khyber Medical University': LatLng(33.9822, 71.4685),
    'Board Bazar': LatLng(33.9763, 71.5122),

    // 🏙️ Suburbs & Residential
    'Gulbahar': LatLng(34.0115, 71.5603),
    'Nishterabad': LatLng(34.0196, 71.5835),
    'Faqeerabad': LatLng(34.0175, 71.5800),
    'Tehkal': LatLng(34.0022, 71.5147),
    'Ring Road': LatLng(33.9804, 71.5003),
    'Danish Abad': LatLng(34.0000, 71.5500),
    'Badaber': LatLng(33.9500, 71.5000),

    // 🌿 Hayatabad General
    'Hayatabad': LatLng(33.9806, 71.4511),

    // 🌿 Hayatabad Phases
    'Hayatabad Phase 1': LatLng(33.9885, 71.4622),
    'Hayatabad Phase 2': LatLng(33.9908, 71.4571),
    'Hayatabad Phase 3': LatLng(33.9877, 71.4526),
    'Hayatabad Phase 4': LatLng(33.9850, 71.4482),
    'Hayatabad Phase 5': LatLng(33.9813, 71.4461),
    'Hayatabad Phase 6': LatLng(33.9777, 71.4432),
    'Hayatabad Phase 7': LatLng(33.9732, 71.4421),
    'Hayatabad Phase 8': LatLng(33.9690, 71.4427),

    // 🏥 Hayatabad Landmarks
    'Hayatabad Medical Complex': LatLng(33.9870, 71.4629),
    'Polo Ground Hayatabad': LatLng(33.9720, 71.4448),
    'Baba Wali Park': LatLng(33.9858, 71.4502),
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
              GestureDetector(
                child: Container(
                  height: 110,
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  padding: const EdgeInsets.only(left: 12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEAFBF2),
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
                      bool isSelected = false;
                      return Padding(
                        padding: const EdgeInsets.only(
                          right: 12,
                          top: 10,
                          bottom: 10,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              isSelected = !isSelected;
                              print(isSelected);
                            });
                          },
                          child: Container(
                            width: 90,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color:
                                    isSelected == true
                                        ? Colors.indigo
                                        : Color(0xFF1BAF6C),
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
                              child: myimages[index],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Text(
                "Where to go?",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 20),

              // Origin (Read-only)
              TextFormField(
                readOnly: true,
                initialValue: 'Current Location',
                decoration: InputDecoration(
                  labelText: 'Origin',
                  prefixIcon: Icon(
                    Icons.my_location_outlined,
                    color: primaryGreen,
                  ),
                  filled: true,
                  fillColor: Colors.grey.shade100,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // Destination Dropdown
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
                  prefixIcon: Image(
                    height: 15,
                    image: AssetImage('assets/pin.png'),
                  ),
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
                    Container(
                      height: 125,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: greenText, width: 1.0),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFC2FFD8), // Pastel Green
                            Color(0xFFB5FFFF), // Pastel Cyan
                            Color(0xFFEFFFFD), // Very Light Aqua],
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 14,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Distance: ${_distanceInKm!.toStringAsFixed(2)} km",
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            Text(
                              "Estimated Fare: Rs. ${(100 + (_distanceInKm! * 25)).toInt()}",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: darkGreen,
                              ),
                            ),

                            Custom_button(
                              name: "Ride",
                              B_color: darkGreen,
                              ontap: () {},
                              b_Width: 100.0,
                              b_height: 34.0,
                              textcolor: white,
                            ),
                            // Align(
                            //   alignment: Alignment.centerRight,
                            //   child: ElevatedButton(
                            //     onPressed: () {
                            //       // Your ride logic
                            //     },
                            //     style: ElevatedButton.styleFrom(
                            //       backgroundColor: lightGreen,
                            //       foregroundColor: Colors.white,
                            //       padding: const EdgeInsets.symmetric(
                            //         horizontal: 24,
                            //         vertical: 5,
                            //       ),
                            //       shape: RoundedRectangleBorder(
                            //         borderRadius: BorderRadius.circular(12),
                            //       ),
                            //       elevation: 2,
                            //     ),
                            //     child: const Text(
                            //       "Ride",
                            //       style: TextStyle(fontSize: 14),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
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
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child: ListView(
            // Important: Remove any padding from the ListView.
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.blue),
                child: Text('Drawer Header'),
              ),
              ListTile(
                title: const Text('Item 1'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
              ListTile(
                title: const Text('Item 2'),
                onTap: () {
                  // Update the state of the app.
                  // ...
                },
              ),
            ],
          ),
        ),
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: AppBar(
            leading: Builder(
              builder: (context) {
                return IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                );
              },
            ),
            title: Text(
              "My_Drive",
              style: const TextStyle(
                fontFamily: 'LuckiestGuy',
                // fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: 1,
                color: darkGreen,
              ),
            ),
            centerTitle: true,
            elevation: 6,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFC2FFD8), // Pastel Green
                    Color(0xFFB5FFFF), // Pastel Cyan
                    Color(0xFFEFFFFD), // Very Light Aqua],
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(20),
                ),
              ),
            ),
          ),
        ),

        body:
            _currentPosition == null
                ? Center(child: CircularProgressIndicator(color: primaryGreen))
                : FlutterMap(
                  mapController: mapController,
                  options: MapOptions(
                    initialCenter: _currentPosition!,
                    initialZoom: 13.0,
                    onLongPress: (tapPos, latlng) {
                      setState(() {
                        _destination = latlng;
                        _updateDistance();
                        _centerMapToBounds();
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
                            child: Image.asset(
                              'assets/pin.png',
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
          backgroundColor: const Color(0xFF4CAF50),
          foregroundColor: Colors.white,
          icon: const Icon(Icons.alt_route_rounded, size: 28),
          label: const Text(
            "Select Route ",
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
      ),
    );
  }
}
