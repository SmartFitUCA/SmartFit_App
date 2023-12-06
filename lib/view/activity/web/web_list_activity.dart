import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:smartfit_app_mobile/modele/utile/list_activity/list_activity_utile.dart';
import 'package:smartfit_app_mobile/view/activity/list_activity.dart';
import 'package:tuple/tuple.dart';
import 'package:universal_html/html.dart' as html;
import 'package:file_picker/file_picker.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/common/colo_extension.dart';
import 'package:smartfit_app_mobile/modele/user.dart';

class WebListActivity extends StatefulWidget {
  const WebListActivity({super.key});

  @override
  State<WebListActivity> createState() => _WebListActivityState();
}

class _WebListActivityState extends State<WebListActivity> {
  FilePickerResult? result;
  final ListActivityUtile _utile = ListActivityUtile();
  final InfoMessage infoManager = InfoMessage();

  void addFileWeb(html.File file, String token) async {
    final reader = html.FileReader();
    reader.readAsArrayBuffer(file);

    reader.onLoadEnd.listen((event) async {
      if (reader.readyState == html.FileReader.DONE) {
        Uint8List bytes = reader.result as Uint8List;
        Tuple2<bool, String> resultAdd =
            await _utile.addFile(bytes, file.name, token, infoManager);
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
                    : const ListActivity(),
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
