import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/colo_extension.dart';

class NoActivityView extends StatefulWidget {
  const NoActivityView(this.msg, {super.key});
  final String msg;

  @override
  State<NoActivityView> createState() => _NoActivityViewState();
}

class _NoActivityViewState extends State<NoActivityView> {
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
                Text(
                  widget.msg,
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "Veuillez sélectionner une activité en cliquant sur la loupe ci-dessous",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: TColor.gray, fontSize: 12),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
