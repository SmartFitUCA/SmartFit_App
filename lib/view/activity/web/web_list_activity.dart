import 'package:flutter/material.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:smartfit_app_mobile/modele/utile/list_activity/list_activity_utile.dart';
import 'package:smartfit_app_mobile/common_widget/container/list/list_activity_widget.dart';
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
              crossAxisAlignment: CrossAxisAlignment.center,
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
                          await _utile.getFiles(
                              Provider.of<User>(context, listen: false).token,
                              context,
                              infoManager);
                          setState(() {});
                        },
                        child: Text("Get activity",
                            style: TextStyle(
                                color: TColor.gray,
                                fontSize: 14,
                                fontWeight: FontWeight.w700))),
                    TextButton(
                      onPressed: () async {
                        FilePickerResult? result =
                            await FilePicker.platform.pickFiles();
                        if (result != null && result.files.isNotEmpty) {
                          await _utile.addFileWeb(
                              result.files.first.bytes,
                              Provider.of<User>(context, listen: false).token,
                              result.files.first.name,
                              context,
                              infoManager);
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
                Visibility(
                    visible: infoManager.isVisible,
                    child: Text(infoManager.message,
                        style: TextStyle(color: infoManager.messageColor))),
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
                    : const ListActivityWidget(),
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
