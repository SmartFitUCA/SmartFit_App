import 'dart:convert';
import 'package:smartfit_app_mobile/modele/activity.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/activity_saver.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:tuple/tuple.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:smartfit_app_mobile/main.dart';

class RequestLocal implements IDataStrategy {
  @override
  Future<Tuple2> getInfoUser(String token) async {
    final User user = localDB.getUser();
    Map<String, String> json = {"email": user.email, "username": user.username};
    return Tuple2(true, jsonEncode(json));
  }

  // need to save file on request_api.upload() beforehand.
  @override
  Future<Tuple2> getFile(String token, String fileUuid) async {
    ActivitySaver actSaver = await ActivitySaver.create();
    Uint8List fileBytes = actSaver.getActivity(fileUuid);

    return Tuple2(true, fileBytes);
  }

  @override
  Future<Tuple2> getFiles(String token) async {
    final List<ActivityOfUser> activities = localDB.getAllActivities();
    List<Map<String, dynamic>> jsonList = List.empty(growable: true);

    for (ActivityOfUser act in activities) {
      Map<String, dynamic> json = {
        "uuid": act.fileUuid,
        "filename": act.nameFile,
        "category": act.category,
        "info": act.activityInfo
      };
      jsonList.add(json);
    }

    return Tuple2(true, jsonList);
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

  @override
  Future<Tuple2> getModeleAI(String token, String category) async {
    return const Tuple2(false, "Not implemented");
  }
}
