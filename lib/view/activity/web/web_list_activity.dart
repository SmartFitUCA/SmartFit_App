import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
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

  //late File x = File(file.path);
  List<String> parseFile(Uint8List bytes) {
    String csvString =
        utf8.decode(bytes); // Convertit les bytes en chaîne UTF-8
    List<String> lines =
        LineSplitter.split(csvString).toList(); // Sépare les lignes

    for (String line in lines) {
      print(line); // Affiche chaque ligne du fichier
    }

    return lines; // Ou retournez les lignes du fichier
  }

  void readFile(html.File file) async {
    ManagerFile x = ManagerFile();
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);
    reader.onLoadEnd.listen((event) {
      if (reader.readyState == html.FileReader.DONE) {
        Uint8List bytes = reader.result as Uint8List;
        List<dynamic> result = x.readFitFileWeb(bytes);
        Provider.of<User>(context, listen: false)
            .addActivity(ActivityOfUser(file.name, result));
      }
    });
  }

  List lastWorkoutArr = [];

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
                      onPressed: () async {
                        html.FileUploadInputElement uploadInput =
                            html.FileUploadInputElement();
                        uploadInput.click();

                        uploadInput.onChange.listen((e) {
                          final files = uploadInput.files;
                          if (files != null && files.isNotEmpty) {
                            readFile(
                                files[0]); // Lecture du fichier sélectionné
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
                    : ListView.builder(
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
                          return InkWell(
                              onTap: () {
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
                              ));
                        }),
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
