import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/container/workout_row/workout_row.dart';

class Prediction extends StatefulWidget {
  const Prediction({Key? key}) : super(key: key);

  @override
  State<Prediction> createState() => _PredictionState();
}

class _PredictionState extends State<Prediction> {
  List<Map<String, dynamic>> lastWorkoutArr = [
    {
      "name": "Temps",
      "image": "assets/img/time-icon2.svg",
      "value": "200 s",
    },
    {
      "name": "Rythme cardiaque",
      "image": "assets/img/bpm2-icon.svg",
      "value": "120 BPM",
    },
    {
      "name": "Vitesse",
      "image": "assets/img/vitesse2-icon.svg",
      "value": "3 m/s",
    },
    {
      "name": "Distance",
      "image": "assets/img/distance2-icon.svg",
      "value": "300 m",
    }
  ];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text(
              "Prédiction",
              style: TextStyle(
                color: TColor.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [

              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: TColor.lightGray,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 234, 234, 234).withOpacity(0.9),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                children: [
                  Container(
                    alignment: Alignment.center,
                    width: 50,
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: SvgPicture.asset(
                      "assets/img/Profile_tab.svg",
                      width: 20,
                      height: 20,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Expanded(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        items: ["Walking", "Cycling"]
                            .map((name) => DropdownMenuItem(
                                  value: name,
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                      color: TColor.gray,
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {},
                        isExpanded: true,
                        hint: Text(
                          "Choisir type d'activité",
                          style: TextStyle(
                            color: TColor.gray,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Bouton "Valider" prenant 30% de la largeur du parent
                 
                ],
              ),
            ),
            SizedBox(height: 20),
             RoundButton(
                title: "Valider",
                onPressed: () async {
                  setState(() {});
                }),
            SizedBox(height: 20),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: lastWorkoutArr.length,
              itemBuilder: (context, index) {
                var wObj =
                    lastWorkoutArr[index] as Map<String, dynamic> ?? {};
                return InkWell(
                  child: WorkoutRow(wObj: wObj),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
