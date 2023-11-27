import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/utile/list_activity/list_activity_utile.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_html/html.dart' as html;

import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
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
  final IDataStrategy _strategy = RequestApi();

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

  Future<bool> deleteFileOnBDD(String token, String fileUuid) async {
    Tuple2<bool, String> result = await _strategy.deleteFile(token, fileUuid);
    if (!result.item1) {
      //print(fileUuid);
      //print("msg d'erreur");
      //print(result.item2);
      return false;
    }
    return true;
  }

  void addFileWeb(html.File file, String token) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    reader.onLoadEnd.listen((event) async {
      if (reader.readyState == html.FileReader.DONE) {
        print("donne");
        Uint8List bytes = reader.result as Uint8List;
        Tuple2<bool, String> resultAdd =
            await _utile.addFile(bytes, file.name, token);
        if (!resultAdd.item1) {
          return;
        }
        Tuple2<bool, String> resultGet = await _utile.getFiles(token, context);
        if (!resultGet.item1) {
          //print("MessageError");
          return;
        }
      }
    });
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
                        html.FileUploadInputElement uploadInput =
                            html.FileUploadInputElement();
                        uploadInput.click();

                        uploadInput.onChange.listen((e) {
                          final files = uploadInput.files;
                          if (files != null && files.isNotEmpty) {
                            addFileWeb(
                                files[0],
                                Provider.of<User>(context, listen: false)
                                    .token); // Lecture du fichier sélectionné
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
