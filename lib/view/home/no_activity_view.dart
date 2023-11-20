import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../common/colo_extension.dart';
import '../../common_widget/button/round_button.dart';
import '../main_tab/main_tab_view.dart';


class NoActivityView extends StatefulWidget {
  const NoActivityView({super.key});

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
        child: Container(
          width: media.width,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
            SizedBox(
                height: media.width * 0.05,
              ),
               SvgPicture.asset(
                "assets/img/group.svg",
                width: media.width * 0.75,
                height:  media.height * 0.4,
                fit: BoxFit.fitWidth,
              ),
              SizedBox(
                height: media.width * 0.05  ,
              ),
              Text(
                "Pas d'activité selectionnée",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                "Veuillez selectionner une activité en cliquant sur la loupe ci-dessous",
                textAlign: TextAlign.center,
                style: TextStyle(color: TColor.gray, fontSize: 12),
              ),
             const Spacer(),

               
            ],
          ),
        ),

      ),
    );
  }
}