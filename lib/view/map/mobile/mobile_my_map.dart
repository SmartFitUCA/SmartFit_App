import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/utile/maps/maps_utile.dart';

class MobileMyMaps extends StatefulWidget {
  const MobileMyMaps({super.key});

  @override
  State<MobileMyMaps> createState() => _MobileMyMaps();
}

class _MobileMyMaps extends State<MobileMyMaps> {
  final Completer<GoogleMapController> _googleMapController = Completer();
  CameraPosition? _cameraPosition;
  Set<Polyline> _polylines = {};

  @override
  Widget build(BuildContext context) {
    _polylines = MapUtil().initPolines(context, 10, TColor.primaryColor1);
    _cameraPosition =
        CameraPosition(target: _polylines.first.points.first, zoom: 15);

    return Scaffold(
        appBar: AppBar(
          title: const Text("Carte Google Map "),
          backgroundColor: TColor.primaryColor1,
        ),
        body: _getMap());
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
        )
      ],
    );
  }
}
