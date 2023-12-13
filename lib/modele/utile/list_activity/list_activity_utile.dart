import 'package:flutter/foundation.dart';
import 'package:smartfit_app_mobile/main.dart';
import 'package:smartfit_app_mobile/modele/api/api_wrapper.dart';
import 'package:smartfit_app_mobile/modele/activity_saver.dart';
import 'package:smartfit_app_mobile/modele/helper.dart';
import 'dart:convert';
import 'dart:io';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:tuple/tuple.dart';

class ListActivityUtile {
  final ApiWrapper api = ApiWrapper();
  final ManagerFile _managerFile = ManagerFile();

  Future<Tuple2<bool, String>> getContentActivity(BuildContext context,
      ActivityOfUser activityOfUser, InfoMessage infoManager) async {
    Tuple2 result = await api.getFile(
        Provider.of<User>(context, listen: false).token,
        activityOfUser.fileUuid,
        infoManager);
    if (result.item1 == false) {
      return Tuple2(result.item1, result.item2);
    }

    activityOfUser.contentActivity =
        List.from(_managerFile.convertByteIntoCSV(result.item2));

    // TODO: Not sure this line as an utility
    // localDB.saveActivityFile(activityOfUser.contentActivity);

    // TODO: Check if file exists, right now it overwrites each time
    // TODO: Make ActivitySaver member of the class
    if (!Helper.isPlatformWeb() && localDB.getSaveLocally()) {
      ActivitySaver actSaver = await ActivitySaver.create();
      actSaver.saveActivity(result.item2,
          localDB.getActivityFilenameByUuid(activityOfUser.fileUuid));
    }

    if (!Provider.of<User>(context, listen: false)
        .managerSelectedActivity
        .addSelectedActivity(activityOfUser)) {
      return const Tuple2(false, "Pas de même categorie");
    }
    return const Tuple2(true, "Yeah");
  }

  Future<Tuple2<bool, String>> getFiles(
      String token, BuildContext context, InfoMessage infoManager) async {
    bool notZero = false;
    Tuple2 result = await api.getFiles(
        Provider.of<User>(context, listen: false).token, infoManager);
    if (result.item1 == false) {
      return Tuple2(result.item1, result.item2);
    }

    for (var element in result.item2) {
      if (!notZero) {
        Provider.of<User>(context, listen: false).listActivity.clear();
        notZero = true;
      }

      Provider.of<User>(context, listen: false).addActivity(ActivityOfUser(
          ActivityInfo.fromJson(element["info"]),
          element["category"].toString(),
          element["uuid"].toString(),
          element["filename"].toString()));

      // Save to local db
      if (!kIsWeb) {
        localDB.addActivity(element["uuid"], element["filename"],
            element["category"], jsonEncode(element["info"]));
      }
    }
    return const Tuple2(true, "Yeah");
  }

  Future<Tuple2<bool, String>> addFile(Uint8List bytes, String filename,
      String token, InfoMessage infoManager) async {
    // -- Transormer le fit en CSV
    Tuple4<bool, List<List<String>>, ActivityInfo, String> resultData =
        _managerFile.convertBytesFitFileIntoCSVListAndGetInfo(bytes);

    String csvString = const ListToCsvConverter().convert(resultData.item2);
    Uint8List byteCSV = Uint8List.fromList(utf8.encode(csvString));

    File x = await File("${await _managerFile.localPath}\\what")
        .writeAsString(csvString);

    Tuple2<bool, String> result = await api.uploadFileByte(
        token,
        byteCSV,
        filename,
        resultData.item4, // category
        resultData.item3.startTime, // activityInfo
        resultData.item3,
        infoManager);
    if (result.item1 == false) {
      return Tuple2(false, result.item2);
    }

    // Save on local storage if plateform not browser
    if (!Helper.isPlatformWeb() && localDB.getSaveLocally()) {
      ActivitySaver actSaver = await ActivitySaver.create();
      actSaver.saveActivity(byteCSV, filename);
    }

    return const Tuple2(true, "Yeah");
  }

  // --- Ne marche pas sous windows !! Jsp linux (mettre en format mobile) -- //
  Future<void> addFileWeb(Uint8List? bytes, String token, String filename,
      BuildContext context, InfoMessage infoManager) async {
    if (bytes == null) {
      return;
    }
    Tuple2<bool, String> resultAdd =
        await addFile(bytes, filename, token, infoManager);
    if (!resultAdd.item1) {
      //print("Message error");
      return;
    }
    Tuple2<bool, String> resultGet =
        await getFiles(token, context, infoManager);
    if (!resultGet.item1) {
      //print("Message error");
      return;
    }
  }

  Future<void> addFileMobile(String path, String token, String filename,
      BuildContext context, InfoMessage infoManager) async {
    Tuple2<bool, String> resultAdd = await addFile(
        await File(path).readAsBytes(), filename, token, infoManager);
    if (!resultAdd.item1) {
      //print("Message error");
      return;
    }
    // TODO: What is that ?
    Tuple2<bool, String> resultGet =
        await getFiles(token, context, infoManager);
    if (!resultGet.item1) {
      //print("Message error");
      return;
    }
  }
}
