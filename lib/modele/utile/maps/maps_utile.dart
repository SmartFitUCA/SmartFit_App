import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/user.dart';

class MapUtil {
  Set<Polyline> initPolines(BuildContext context, int largueur, Color couleur) {
    Set<Polyline> polylines = {};
    polylines.add(Polyline(
        polylineId: const PolylineId("Polyline"),
        color: couleur,
        points: context.watch<User>().managerSelectedActivity.getPosition(),
        width: largueur));
    return polylines;
  }
}
