import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/view/map/mobile/mobile_my_map.dart';
import 'package:smartfit_app_mobile/view/map/my_map_osm.dart';

class ChoseMap extends StatefulWidget {
  const ChoseMap({Key? key}) : super(key: key);

  @override
  State<ChoseMap> createState() => _ChoseMap();
}

class _ChoseMap extends State<ChoseMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MobileMyMaps()));
              },
              child: const Text("Use map with google map")),
          TextButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const MyMapOSM()));
              },
              child: const Text("Use map with Open Street Map")),
          const Text(
              "Mettre une image la en mode une personne avec des jumelles")
        ],
      )),
    );
  }
}
