import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
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
    var media = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
        child: Center(
          // Utilisation du widget Center pour centrer verticalement
          child: Container(
            width: media.width,
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize
                  .min, // Utilisation de MainAxisSize.min pour que la colonne prenne la hauteur minimale nécessaire
              children: [
                SizedBox(
                  height: media.height * 0.1,
                ),
                SvgPicture.asset(
                  "assets/img/group.svg",
                  width: media.width * 0.75,
                  height: media.height * 0.4,
                  fit: BoxFit.fitWidth,
                ),
                SizedBox(
                  height: media.height * 0.1,
                ),
                RoundButton(
                    title: "Use map with google map",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MobileMyMaps()));
                    },
                    ),
                SizedBox(
                  height: media.height * 0.03,
                ),
                RoundButton(
                    title : "Use map with Open Street Map",
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const MyMapOSM()));
                    },
                   ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
    return Scaffold(
      backgroundColor: TColor.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          
          const Text(
              "Mettre une image la en mode une personne avec des jumelles")
        ],
      )),
    );
  }
}
