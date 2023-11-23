import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/common_widget/container/workout_row.dart';
import 'package:smartfit_app_mobile/modele/utile/list_activity.dart/list_activity_utile.dart';
import 'package:tuple/tuple.dart';

class MobileListActivity extends StatefulWidget {
  const MobileListActivity({Key? key}) : super(key: key);

  @override
  State<MobileListActivity> createState() => _MobileListActivity();
}

class _MobileListActivity extends State<MobileListActivity> {
  FilePickerResult? result;
  final IDataStrategy strategy = RequestApi();
  final ListActivityUtile _utile = ListActivityUtile();
  int firstActivityIndex = 0;

  /*
  Future<void> readFile(String nom) async {
    PlatformFile t = result!.files.single;
    String? y = t.path;
    if (t.path == null) {
      print("t");
    } else {
      List<dynamic> result = await _managerFile.readFitFile(y!);

      // Upload the file and Syncronise (getFiles())

      strategy.uploadFile(context.watch<User>().token, File(y));

      Provider.of<User>(context, listen: false)
          .addActivity(ActivityOfUser("Random date", "$nom categorie !"));
      Provider.of<User>(context, listen: false)
          .listActivity
          .last
          .contentActivity = result;
    }
  }*/

  void addFile(String path) async {
    // --- Save Local

    // --- BDD
    Tuple2<bool, String> result = await strategy.uploadFile(
        Provider.of<User>(context, listen: false).token, File(path));
    if (result.item1 == false) {
      // Afficher msg d'erreur
      print("Upload - ${result.item2}");
      return;
    }
    getFiles();
  }

  void getFiles() async {
    Tuple2 result = await strategy
        .getFiles(Provider.of<User>(context, listen: false).token);
    if (result.item1 == false) {
      print("GetFiles - ${result.item2}");
      // Afficher une message d'erreur
      return;
    }
    Provider.of<User>(context, listen: false).listActivity.clear();

    for (Map<String, dynamic> element in result.item2) {
      Provider.of<User>(context, listen: false).addActivity(ActivityOfUser(
          element["creation_date"].toString(),
          element["category"].toString(),
          element["uuid"].toString(),
          element["filename"].toString()));
    }
    await _utile.getContentOnTheFirstFileMobile(context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

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
                        onPressed: getFiles,
                        child: Text("Get activity",
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 14,
                                fontWeight: FontWeight.w700))),
                    TextButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null) {
                          addFile(result.files.single.path!);
                        } else {
                          print("Picker");
                          // msg d'erreur
                          // User canceled the picker
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
                            const SizedBox(height: 20),
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
                                    .listActivity[index];
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
                                      .insertActivityTopMobile(
                                          activityObj, context);
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
