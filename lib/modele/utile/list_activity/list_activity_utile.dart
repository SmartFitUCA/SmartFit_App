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

    Provider.of<User>(context, listen: false)
        .managerSelectedActivity
        .addSelectedActivity(activityOfUser);
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
      Provider.of<User>(context, listen: false).addActivity(ActivityOfUser(
          element["creation_date"].toString(),
          element["category"].toString(),
          element["uuid"].toString(),
          element["filename"].toString()));

      // Save to local db
      localDB.addActivity(db.Activity(
          0,
          element["uuid"],
          element["filename"],
          element["category"],
          DateTime.parse(element["creation_date"]),
          element["info"]
              .toString())); // Do not remove toString(), it do not work w/o it, idk why
    }
    /*
    if (notZero) {
      await getContentActivity(context);
    }*/
    return const Tuple2(true, "Yeah");
  }

  Future<Tuple2<bool, String>> addFile(Uint8List bytes, String filename,
      String token, InfoMessage infoManager) async {
    // -- Transormer le fit en CSV
    List<List<String>> csv = _managerFile.convertBytesFitFileIntoCSVList(bytes);
    String csvString = const ListToCsvConverter().convert(csv);
    Uint8List byteCSV = Uint8List.fromList(utf8.encode(csvString));

    // Save on local storage if plateform not browser
    if (!Helper.isPlatformWeb()) {
      ActivitySaver actSaver = await ActivitySaver.create();
      actSaver.saveActivity(byteCSV, filename);
    }

    String categoryActivity = filename.split("_").first.toLowerCase();
    String dateActivity = filename.split("_")[1].split("T").first;

    Tuple2<bool, String> result = await api.uploadFileByte(
        token, byteCSV, filename, categoryActivity, dateActivity, infoManager);
    if (result.item1 == false) {
      return Tuple2(false, result.item2);
    }
    return const Tuple2(true, "Yeah");
  }

  void addFileMobile(String path, String token, String filename,
      BuildContext context, InfoMessage infoManager) async {
    Tuple2<bool, String> resultAdd = await addFile(
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
