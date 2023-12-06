import 'dart:convert';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/local_db/model.dart';
import 'package:tuple/tuple.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:smartfit_app_mobile/main.dart';

class RequestLocal implements IDataStrategy {
  @override
  Future<Tuple2> getInfoUser(String token) async {
    final User user = localDB.userBox.get(1);
    Map<String, String> json = {"email": user.email, "username": user.username};
    return Tuple2(true, jsonEncode(json));
  }

  // need to save file on request_api.upload() beforehand.
  @override
  Future<Tuple2> getFile(String token, String fileUuid) async {
    return const Tuple2(true, "to implement");
  }

  @override
  Future<Tuple2> getFiles(String token) async {
    final List<dynamic> activities = localDB.activityBox.getAll();
    List<Map<String, dynamic>> jsonList = List.empty(growable: true);

    for (Activity act in activities) {
      Map<String, dynamic> json = {
        "uuid": act.uuid,
        "filename": act.filename,
        "category": act.category,
        "info": act.info
      };
      jsonList.add(json);
    }

    return Tuple2(true, jsonEncode(activities));
  }

  @override
  Future<Tuple2<bool, String>> modifAttribut(
      String token, String nameAttribut, String newValue) async {
    return const Tuple2(false, "not implemented");
  }

  @override
  Future<Tuple2<bool, String>> postUser(
      String email, String hash, String username) async {
    return const Tuple2(false, "not implemented");
  }

  @override
  Future<Tuple2<bool, String>> deleteUser(String token) async {
    return const Tuple2(false, "not implemented");
  }

  @override
  Future<Tuple2<bool, String>> connexion(String email, String hash) async {
    return const Tuple2(false, "not implemented");
  }

  @override
  Future<Tuple2<bool, String>> uploadFile(String token, File file) async {
    return const Tuple2(false, "not implemented");
  }

  @override
  Future<Tuple2<bool, String>> uploadFileByte(
      String token,
      Uint8List contentFile,
      String nameFile,
      String category,
      DateTime date,
      ActivityInfo activityInfo) async {
    return const Tuple2(false, "not implemented");
  }

  @override
  Future<bool> deleteFile(String token, String fileUuid) async {
    throw Exception("Not Implemented");
  }
}
