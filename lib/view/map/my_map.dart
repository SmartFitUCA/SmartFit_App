import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';

class MyMap extends StatefulWidget {
  const MyMap({ Key? key }) : super(key: key);

  @override
  State<MyMap> createState() => _MyMapState();
}

class _MyMapState extends State<MyMap> {

  Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  Location? _location;
  LocationData? _currentLocation;
  List<LatLng> _polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {}; // Add a set to store markers

  @override
  void initState() {
    _init();
    super.initState();
  }

  _init() async {
    _location = Location();
    _cameraPosition = CameraPosition(
      target: LatLng(0, 0), // this is just the example lat and lng for initializing
      zoom: 20
    );
    _initLocation();
  }

  //function to listen when we move position
  _initLocation() {
    
    _location?.getLocation().then((location) {
      _currentLocation = location;
    });

    _location?.onLocationChanged.listen((newLocation) {
      setState(() {
        _currentLocation = newLocation;
        _polylineCoordinates.add(LatLng(
          _currentLocation?.latitude ?? 0,
          _currentLocation?.longitude ?? 0,
        ));
        _updatePolyline();

      });

      moveToPosition(LatLng(_currentLocation?.latitude ?? 0,
          _currentLocation?.longitude ?? 0));
    });
  }

  _updatePolyline() {
    setState(() {
      _polylines.clear();
      _polylines.add(Polyline(
        polylineId: PolylineId("polyline"),
        color: TColor.primaryColor1,
        points: _polylineCoordinates,
        width: 10,
      ));
    });
  }

  // Updated _updateMarker to use the custom marker
  _updateMarker(LatLng position) async {
  final markerId = MarkerId('marker');
  final marker = Marker(
    markerId: markerId,
    position: position
    );
  _markers.clear();
  _markers.add(marker);
}


  moveToPosition(LatLng latLng) async {
    GoogleMapController mapController = await _googleMapController.future;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: latLng,
          zoom: 15
        )
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return _getMap();
  }

  Widget _getMarker() {
    return Container(
      width: 25,
      height: 25,
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(100),
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0,3),
            spreadRadius: 4,
            blurRadius: 6
          )
        ]
      ),
      child:  ClipOval(child: Image.asset("assets/img/u1.png")),
    );
  }

  Widget _getMap() {
    return Stack(
      children: [
        GoogleMap(
          initialCameraPosition: _cameraPosition!,
          mapType: MapType.normal,
          onMapCreated: (GoogleMapController controller) {
            if (!_googleMapController.isCompleted) {
              _googleMapController.complete(controller);
            }
          },
          polylines: _polylines,
          markers: _markers,
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.center,
            child: _getMarker()
          )
        )
      ],
    );
  }
}