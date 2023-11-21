import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/common_widget/container/workout_row.dart';

class MobileListActivity extends StatefulWidget {
  const MobileListActivity({Key? key}) : super(key: key);

  @override
  State<MobileListActivity> createState() => _MobileListActivity();
}

class _MobileListActivity extends State<MobileListActivity> {
  FilePickerResult? result;
  IDataStrategy strategy = RequestApi();

  Future<void> readFile(String nom) async {
    ManagerFile x = ManagerFile();
    PlatformFile t = result!.files.single;
    String? y = t.path;
    if (t.path == null) {
      print("t");
    } else {
      List<dynamic> result = await x.readFitFile(y!);
      print("test11");
      print(result);
      print("test22");
      print(ActivityOfUser(nom, result).getHeartRateWithTime());
      print("test33");
      Provider.of<User>(context, listen: false)
          .addActivity(ActivityOfUser(nom, result));
      //print(x.getDistanceWithTime(ActivityOfUser(result)));
      //print(x.getDistance(ActivityOfUser(result)));
      //print(x.getAltitudeWithTime(ActivityOfUser(result)));
      //print(x.getSpeedWithTime(ActivityOfUser(result)));
    }
  }

  List lastWorkoutArr = [];

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    int firstActivityIndex = 0;

    return Scaffold(
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "List Activités",
                      style: TextStyle(
                          color: TColor.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                      onPressed: () async {
                        result = await FilePicker.platform.pickFiles();
                        if (result == null) {
                          print("No file selected");
                        } else {
                          for (var element in result!.files) {
                            readFile(element.name);
                            print(element.name);
                          }
                        }
                      },
                      child: Text(
                        "Ajouter",
                        style: TextStyle(
                            color: TColor.gray,
                            fontSize: 14,
                            fontWeight: FontWeight.w700),
                      ),
                    )
                  ],
                ),
                Provider.of<User>(context, listen: true).listActivity.isEmpty
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                            SizedBox(height: 20),
                            Text(
                              "Vous n'avez pas d'activités pour le moment, veuillez en ajouter.",
                              style: TextStyle(
                                color: TColor.gray,
                                fontSize: 11,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          ])
                    : Material(
                        color: Colors.transparent,
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: Provider.of<User>(context, listen: true)
                              .listActivity
                              .length,
                          itemBuilder: (context, index) {
                            var activityObj =
                                Provider.of<User>(context, listen: true)
                                    .listActivity[index] as ActivityOfUser;
                            var activityMap = activityObj.toMap();

                            bool isFirstActivity = false;
                            if (index == firstActivityIndex) {
                              isFirstActivity = true;
                            }
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  firstActivityIndex = index;
                                });
                                Provider.of<User>(context, listen: false)
                                    .removeActivity(activityObj);
                                Provider.of<User>(context, listen: false)
                                    .insertActivity(0, activityObj);
                              },
                              child: WorkoutRow(
                                wObj: activityMap,
                                onDelete: () {
                                  Provider.of<User>(context, listen: false)
                                      .removeActivity(activityObj);
                                },
                                onClick: () {
                                  Provider.of<User>(context, listen: false)
                                      .removeActivity(activityObj);
                                  Provider.of<User>(context, listen: false)
                                      .insertActivity(0, activityObj);
                                },
                                isFirstActivity: isFirstActivity,
                              ),
                            );
                          },
                        ),
                      ),
                SizedBox(
                  height: media.width * 0.1,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
