import 'dart:html';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/utile/list_activity.dart/list_activity_utile.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_html/html.dart' as html;

import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/common_widget/container/workout_row.dart';

class WebListActivity extends StatefulWidget {
  const WebListActivity({super.key});

  @override
  State<WebListActivity> createState() => _WebListActivityState();
}

class _WebListActivityState extends State<WebListActivity> {
  FilePickerResult? result;
  IDataStrategy strategy = RequestApi();
  final ListActivityUtile _utile = ListActivityUtile();
  int firstActivityIndex = 0;
  /*
  void readFile(html.File file) async {
    ManagerFile x = ManagerFile();
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((event) {
      if (reader.readyState == html.FileReader.DONE) {
        Uint8List bytes = reader.result as Uint8List;
        List<dynamic> result = x.readFitFileWeb(bytes);
        Provider.of<User>(context, listen: false).addActivity(
            ActivityOfUser("Date random", "${file.name} Categorie", "", ""));
        Provider.of<User>(context, listen: false)
            .listActivity
            .last
            .contentActivity = result;
      }
    });
  }*/

  void addFile(html.File file) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((event) async {
      if (reader.readyState == html.FileReader.DONE) {
        Uint8List bytes = reader.result as Uint8List;

        String filename = file.name;
        String categoryActivity = filename.split("_").first.toLowerCase();
        String dateActivity = filename.split("_")[1].split("T").first;

        Tuple2<bool, String> result = await strategy.uploadFileByte(
            Provider.of<User>(context, listen: false).token,
            bytes,
            filename,
            categoryActivity,
            dateActivity);

        if (result.item1 == false) {
          // Afficher msg d'erreur
          print("Upload - ${result.item2}");
          return;
        }
        getFiles();
      }
    });
  }

  // -- On doit garder cet fonction dans la page pour pouvoir afficher les msg -- //
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
    await _utile.getContentOnTheFirstFileWeb(context);
    return;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    print("tttt");
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
                        html.FileUploadInputElement uploadInput =
                            html.FileUploadInputElement();
                        uploadInput.click();

                        uploadInput.onChange.listen((e) {
                          final files = uploadInput.files;
                          if (files != null && files.isNotEmpty) {
                            addFile(files[0]); // Lecture du fichier sélectionné
                          }
                        });
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
                                      .insertActivityTopWeb(
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
