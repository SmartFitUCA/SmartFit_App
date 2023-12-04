import 'dart:convert';
import 'dart:typed_data';
import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:tuple/tuple.dart';

class ListActivityUtile {
  final IDataStrategy _strategy = RequestApi();
  final ManagerFile _managerFile = ManagerFile();

  Future<Tuple2<bool, String>> getContentActivity(
      BuildContext context, ActivityOfUser activityOfUser) async {
    Tuple2 result = await _strategy.getFile(
        Provider.of<User>(context, listen: false).token,
        activityOfUser.fileUuid);
    if (result.item1 == false) {
      return Tuple2(result.item1, result.item2);
    }

    activityOfUser.contentActivity =
        List.from(_managerFile.convertByteIntoCSV(result.item2));

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
    Tuple2 result = await _strategy
        .getFiles(Provider.of<User>(context, listen: false).token);
    if (result.item1 == false) {
      return Tuple2(result.item1, result.item2);
    }

    for (Map<String, dynamic> element in result.item2) {
      if (!notZero) {
        Provider.of<User>(context, listen: false).listActivity.clear();
        notZero = true;
      }
      Provider.of<User>(context, listen: false).addActivity(ActivityOfUser(
          element["creation_date"].toString(),
          element["category"].toString(),
          element["uuid"].toString(),
          element["filename"].toString()));
    }
    /*
    if (notZero) {
      await getContentActivity(context);
    }*/
    return const Tuple2(true, "Yeah");
  }

  Future<Tuple2<bool, String>> addFile(
      Uint8List bytes, String filename, String token) async {
    // -- Transormer le fit en CSV
    Tuple3<String, String, List<List<String>>> categorieStarttimeCsv =
        _managerFile.convertBytesFitFileIntoCSVList(bytes);

    String csvString =
        const ListToCsvConverter().convert(categorieStarttimeCsv.item3);
    Uint8List byteCSV = Uint8List.fromList(utf8.encode(csvString));
    // --- Save Local
    // --- Api

    Tuple2<bool, String> result = await _strategy.uploadFileByte(token, byteCSV,
        filename, categorieStarttimeCsv.item1, categorieStarttimeCsv.item2);
    if (result.item1 == false) {
      return Tuple2(false, result.item2);
    }
    return const Tuple2(true, "Yeah");
  }

  Future<bool> deleteFileOnBDD(String token, String fileUuid) async {
    Tuple2<bool, String> result = await _strategy.deleteFile(token, fileUuid);
    if (!result.item1) {
      return false;
    }
    return true;
  }

  void preAddFile(Uint8List? bytes, String token, String filename,
      BuildContext context) async {
    if (bytes == null) {
      return;
    }
    Tuple2<bool, String> resultAdd = await addFile(bytes, filename, token);
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
}
