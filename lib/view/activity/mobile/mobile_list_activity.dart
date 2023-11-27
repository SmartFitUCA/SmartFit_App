import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:csv/csv.dart';
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
import 'package:smartfit_app_mobile/modele/utile/list_activity/list_activity_utile.dart';
import 'package:tuple/tuple.dart';

class MobileListActivity extends StatefulWidget {
  const MobileListActivity({Key? key}) : super(key: key);

  @override
  State<MobileListActivity> createState() => _MobileListActivity();
}

class _MobileListActivity extends State<MobileListActivity> {
  FilePickerResult? result;
  final IDataStrategy _strategy = RequestApi();
  final ListActivityUtile _utile = ListActivityUtile();
  final ManagerFile _managerFile = ManagerFile();
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

  Future<bool> deleteFileOnBDD(String token, String fileUuid) async {
    Tuple2<bool, String> result = await _strategy.deleteFile(token, fileUuid);
    if (!result.item1) {
      print(fileUuid);
      print("msg d'erreur");
      print(result.item2);
      return false;
    }
    return true;
  }

  void addFileMobile(String path, String token, String filename) async {
    Tuple2<bool, String> resultAdd =
        await _utile.addFile(await File(path).readAsBytes(), filename, token);
    if (!resultAdd.item1) {
      //print("Message error");
      return;
    }
    Tuple2<bool, String> resultGet = await _utile.getFiles(token, context);
    if (!resultGet.item1) {
      //print("Message error");
      return;
    }
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
                        onPressed: () => _utile.getFiles(
                            Provider.of<User>(context, listen: false).token,
                            context),
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
                          addFileMobile(
                              result.files.single.path!,
                              Provider.of<User>(context, listen: false).token,
                              result.files.single.name);
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
                                onDelete: () async {
                                  if (await deleteFileOnBDD(
                                      Provider.of<User>(context, listen: false)
                                          .token,
                                      activityObj.fileUuid)) {
                                    Provider.of<User>(context, listen: false)
                                        .removeActivity(activityObj);
                                  }
                                },
                                onClick: () {
                                  Provider.of<User>(context, listen: false)
                                      .removeActivity(activityObj);
                                  Provider.of<User>(context, listen: false)
                                      .insertActivity(0, activityObj);
                                  _utile.getContentActivity(context);
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
