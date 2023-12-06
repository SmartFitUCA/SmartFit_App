import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart' as osm;
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/user.dart';

class MyMapOSM extends StatefulWidget {
  const MyMapOSM({Key? key}) : super(key: key);

  @override
  State<MyMapOSM> createState() => _MyMapOSM();
}

class _MyMapOSM extends State<MyMapOSM> {
  final controller = MapController();

  @override
  Widget build(BuildContext context) {
    List<osm.LatLng> listPolynines =
        context.watch<User>().managerSelectedActivity.getPositionOSM();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Carte Open Street Map "),
        backgroundColor: TColor.primaryColor1,
      ),
      body: FlutterMap(
        options: MapOptions(center: listPolynines.first),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          PolylineLayer(
            polylines: [
              Polyline(
                points: listPolynines,
                color: TColor.primaryColor1,
                strokeWidth: 5.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
