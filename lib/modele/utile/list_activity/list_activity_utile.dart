import 'package:smartfit_app_mobile/main.dart';
import 'package:smartfit_app_mobile/modele/api/api_wrapper.dart';
import 'package:smartfit_app_mobile/modele/activity_saver.dart';
import 'package:smartfit_app_mobile/modele/helper.dart';
import 'package:smartfit_app_mobile/modele/local_db/model.dart' as db;
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:tuple/tuple.dart';

class ListActivityUtile {
  final ApiWrapper api = ApiWrapper();
  final ManagerFile _managerFile = ManagerFile();

  Future<Tuple2<bool, String>> getContentActivity(
      BuildContext context, ActivityOfUser activityOfUser) async {
    Tuple2 result = await api.getFile(
        Provider.of<User>(context, listen: false).token,
        activityOfUser.fileUuid);
    if (result.item1 == false) {
      return Tuple2(result.item1, result.item2);
    }

    activityOfUser.contentActivity =
        List.from(_managerFile.convertByteIntoCSV(result.item2));

    // TODO: Not sure this line as an utility
    // localDB.saveActivityFile(activityOfUser.contentActivity);

    if (!Provider.of<User>(context, listen: false)
        .managerSelectedActivity
        .addSelectedActivity(activityOfUser)) {
      return const Tuple2(false, "Pas de même categorie");
    }
    return const Tuple2(true, "Yeah");
  }

  Future<Tuple2<bool, String>> getFiles(
      String token, BuildContext context) async {
    bool notZero = false;
    Tuple2 result =
        await api.getFiles(Provider.of<User>(context, listen: false).token);
    if (result.item1 == false) {
      return Tuple2(result.item1, result.item2);
    }

    for (var element in result.item2) {
      if (!notZero) {
        Provider.of<User>(context, listen: false).listActivity.clear();
        notZero = true;
      }
      // -- connaitre le type de categorie pour changer le type d'info -- //

      Provider.of<User>(context, listen: false).addActivity(ActivityOfUser(
          ActivityInfo.fromJson(element["info"]),
          element["category"].toString(),
          element["uuid"].toString(),
          element["filename"].toString()));

      // Save to local db
      localDB.addActivity(db.Activity(
          0,
          element["uuid"],
          element["filename"],
          element["category"],
          element["info"]
              .toString())); // TODO: Do not remove toString(), it do not work w/o it, idk why
    }
    return const Tuple2(true, "Yeah");
  }

  Future<Tuple2<bool, String>> _addFile(Uint8List bytes, String filename,
      String token, InfoMessage infoManager) async {
    // -- Transormer le fit en CSV
    Tuple4<bool, List<List<String>>, ActivityInfo, String> resultData =
        _managerFile.convertBytesFitFileIntoCSVListAndGetInfo(bytes);

    String csvString = const ListToCsvConverter().convert(resultData.item2);
    Uint8List byteCSV = Uint8List.fromList(utf8.encode(csvString));

    // Save on local storage if plateform not browser
    if (!Helper.isPlatformWeb()) {
      ActivitySaver actSaver = await ActivitySaver.create();
      actSaver.saveActivity(byteCSV, filename);
    }

    Tuple2<bool, String> result = await api.uploadFileByte(
        token,
        byteCSV,
        filename,
        resultData.item4,
        resultData.item3.startTime,
        resultData.item3,
        infoManager);
    if (result.item1 == false) {
      return Tuple2(false, result.item2);
    }
    return const Tuple2(true, "Yeah");
  }

  // --- Ne marche pas sous window !! Jsp linux (mettre en format mobile) -- //
  void addFileWeb(Uint8List? bytes, String token, String filename,
      BuildContext context, InfoMessage infoManager) async {
    if (bytes == null) {
      return;
    }
    Tuple2<bool, String> resultAdd =
        await _addFile(bytes, filename, token, infoManager);
    if (!resultAdd.item1) {
      //print("Message error");
      return;
    }
    Tuple2<bool, String> resultGet = await getFiles(token, context);
    if (!resultGet.item1) {
      //print("Message error");
      return;
    }
  }

  void addFileMobile(String path, String token, String filename,
      BuildContext context, InfoMessage infoManager) async {
    Tuple2<bool, String> resultAdd = await _addFile(
        await File(path).readAsBytes(), filename, token, infoManager);
    if (!resultAdd.item1) {
      //print("Message error");
      return;
    }
    // TODO: What is that ?
    Tuple2<bool, String> resultGet = await getFiles(token, context);
    if (!resultGet.item1) {
      //print("Message error");
      return;
    }
  }
}
