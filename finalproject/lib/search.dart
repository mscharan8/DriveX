import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'list.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool _isTapped = false;
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getLocation();
  }

  Future<void> getLocation() async {

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if(permission == LocationPermission.denied) {
        setState(() {
          _isLoading = false;
        });
        return;
      }
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    double lat = position.latitude;
    double long = position.longitude;
    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      _isLoading = false;
    });

    if (kDebugMode) {
      print("location codes: $_currentPosition");
    }
    setState(() {
      _isLoading = false;
    });
  }

  void setInitialLocation() {
    if (_currentPosition != null) {
      mapController.animateCamera(
        CameraUpdate.newLatLng(_currentPosition!),
      );
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Center(
        child: Stack(
          children: <Widget>[
            _buildGoogleMap(),
            _buildLocationButton(),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.blueGrey,
      title: Row(
        children: [
          SizedBox(
            width: 298,
            height: 32,
            child: TextField(
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Choose Location',
                  contentPadding: EdgeInsets.all(8.0),
                ),
                onTap: (){
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const ListRoute(); // Default to FirstRoute if the route is unknown.
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        const Offset begin = Offset(1.0, 0.0);
                        const Offset end = Offset(0.0,0.0);
                        // const Offset end = Offset(0.0,0.0);
                        const Curve curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);
                        return SlideTransition(
                          position: offsetAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                }
            ),
          ),
          GestureDetector(
            onTap: () {
              setState(() {
                _isTapped = !_isTapped;
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return const ListRoute(); // Default to FirstRoute if the route is unknown.
                    },
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      const Offset begin = Offset(0.0, 1.0);
                      const Offset end = Offset(0.0,0.0820);
                      // const Offset end = Offset(0.0,0.0);
                      const Curve curve = Curves.ease;
                      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                      var offsetAnimation = animation.drive(tween);
                      return SlideTransition(
                        position: offsetAnimation,
                        child: child,
                      );
                    },
                  ),
                );
              });
            },
            child: Padding(
              padding:  const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(_isTapped ? 'Map' : 'List',
                style:  const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildGoogleMap() {
    return _isLoading
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: _currentPosition!,
        zoom: 16.0,
      ),
      markers: {
        Marker(
          markerId: const MarkerId("1"),
          position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
        ),
      },
      zoomControlsEnabled: false,
    );
  }

  Widget _buildLocationButton() {
    if (!_isLoading) {
      return Align(
        alignment: Alignment.topRight,
        child: Container(
          height: 60,
          width: 60,
          padding: const EdgeInsets.all(10.0),
          child: FloatingActionButton(
            backgroundColor: Colors.white,
            heroTag: 'recenter',
            onPressed: setInitialLocation,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
              side: const BorderSide(color: Color(0xFFECEDF1)),
            ),
            child: const Icon(
              Icons.my_location,
              color: Colors.grey,
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }
}
