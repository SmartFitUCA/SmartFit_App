import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/common_widget/button/round_button.dart';
import 'package:smartfit_app_mobile/common_widget/container/workout_row/workout_row.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/convertisseur.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:tuple/tuple.dart';

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
      "value": "..",
    },
    {
      "name": "Rythme cardiaque",
      "image": "assets/img/bpm2-icon.svg",
      "value": "..",
    },
    {
      "name": "Vitesse",
      "image": "assets/img/vitesse2-icon.svg",
      "value": "..",
    },
    {
      "name": "Distance",
      "image": "assets/img/distance2-icon.svg",
      "value": "..",
    }
  ];
  final ManagerFile _managerFile = ManagerFile();
  String selectedCategory = "Choisir type d'activité";

  @override
  Widget build(BuildContext context) {
    List<String> listCategory = [_managerFile.marche, _managerFile.velo];

    void prediction() async {
      InfoMessage tmp = InfoMessage();

      /*
      if (selectedCategory != _managerFile.marche ||
          selectedCategory != _managerFile.velo) return;*/

      Tuple2<bool, ActivityInfo> resultat =
          await Provider.of<User>(context, listen: false)
              .predictActivity(DateTime.now(), selectedCategory, tmp);
      if (!resultat.item1) return;
      setState(() {
        lastWorkoutArr[0]["value"] =
            resultat.item2.timeOfActivity.toStringAsFixed(2);
        lastWorkoutArr[1]["value"] = resultat.item2.bpmAvg.toStringAsFixed(2);
        lastWorkoutArr[2]["value"] =
            resultat.item2.vitesseAvg.toStringAsFixed(2);
        lastWorkoutArr[3]["value"] = resultat.item2.distance.toStringAsFixed(2);
      });
    }

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            Text(
              "Prédiction",
              style: TextStyle(
                color: TColor.black,
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 20),
            const Row(
              children: [],
            ),
            Container(
              decoration: BoxDecoration(
                color: TColor.lightGray,
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromARGB(255, 234, 234, 234)
                        .withOpacity(0.9),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 2),
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
                        items: listCategory
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
                        onChanged: (value) {
                          setState(() {
                            selectedCategory = value!;
                          });
                        },
                        isExpanded: true,
                        hint: Text(
                          selectedCategory,
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
            const SizedBox(height: 20),
            RoundButton(
                title: "Valider",
                onPressed: () async {
                  prediction();
                }),
            const SizedBox(height: 20),
            ListView.builder(
              padding: EdgeInsets.zero,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: lastWorkoutArr.length,
              itemBuilder: (context, index) {
                var wObj = lastWorkoutArr[index];
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
