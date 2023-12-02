import 'searchpage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'list.dart';

class Search extends StatefulWidget {
  static SearchState of(BuildContext context) {
    return context.findAncestorStateOfType<SearchState>()!;
  }
  const Search({Key? key,required this.setupPageRoute}) : super(key: key);

  final String setupPageRoute;
  @override
  SearchState createState() => SearchState();
}

class SearchState extends State<Search> {
  final _navigatorKey = GlobalKey<NavigatorState>();
  bool _isTapped = false;
  final  _controller = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Navigator(
        key: _navigatorKey,
        initialRoute: widget.setupPageRoute,
        onGenerateRoute: _onGenerateRoute,
      ),
    );
  }
  Route _onGenerateRoute(RouteSettings settings) {
    late Widget page;
    if (settings.name == '/') {
      page = const Googlemap();
    }
    if (settings.name == '/list') {
      page = const ListRoute();

      return PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        settings: settings, // Pass the settings to the PageRouteBuilder
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(0.0, 1.0);
          const end = Offset(0.0,0.0);
          const curve = Curves.easeInOut;
          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(position: offsetAnimation, child: child);
        },
      );

    }

    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => page,
      settings: settings, // Pass the settings to the PageRouteBuilder
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(0.0, 0.0);
        const end = Offset.zero;
        const curve = Curves.easeInOut;
        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(position: offsetAnimation, child: child);
      },
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
                controller: _controller,
                decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Choose Location',
                  contentPadding: EdgeInsets.all(8.0),
                ),
                onTap: ()  async {
                  _controller.text = await Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return const SearchPage(); // Default to FirstRoute if the route is unknown.
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
              if(!_isTapped){
                setState(() {
                  _isTapped = !_isTapped;
                  _navigatorKey.currentState!.pushNamed('/list');
                });}
              else{
                setState(() {
                  _isTapped = !_isTapped;
                  _navigatorKey.currentState!.pop();
                });
              }

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

}


class Googlemap extends StatefulWidget {
  const Googlemap({Key? key}) : super(key: key);

  @override
  State<Googlemap> createState() => Googlemapstate();
}

class Googlemapstate extends State<Googlemap> {

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
      body:Center(
        child: Stack(
          children: <Widget>[
            _buildGoogleMap(),
            _buildLocationButton(),
          ],
        ),
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

  Widget _buildUpdatedGoogleMap() {
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
