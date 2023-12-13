import 'package:flutter/foundation.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/local_db/request_local.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tuple/tuple.dart';
import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:smartfit_app_mobile/main.dart';
import 'package:http/http.dart' as http;

class ApiWrapper {
  late IDataStrategy api;
  String noConnectionMessage =
      "It seems like you are lost far away in the universe, no connection found :)";

  // HELPERS
  // TODO: Change check online for flutterWeb
  Future<bool> isOnline() async {
    try {
      final http.Response res = await http
          .head(Uri.https("example.com"))
          .timeout(const Duration(seconds: 5));

      if (res.statusCode == 200) {
        return true;
      }
    } catch (_) {
      return false;
    }
    return true;
  }

  Future<void> init() async {
    // TODO: Fait à la pisse en despi (je voulais juste dormir)
    if (kIsWeb) {
      api = RequestApi();
      return;
    }

    if (await isOnline()) {
      api = RequestApi();
    } else if (!kIsWeb && localDB.getSaveLocally()) {
      api = RequestLocal();
    } else {
      api = RequestApi();
    }
  }

  bool handleOffline(InfoMessage infoManager) {
    if (api is RequestLocal) {
      infoManager.displayMessage(noConnectionMessage, true);
      return true;
    }
    return false;
  }

  // BOTH (ONLINE + OFFLINE)
  Future<Tuple2> getUserInfo(String token) async {
    await init();
    Tuple2 res = await api.getInfoUser(token);

    return res;
  }

  Future<Tuple2> getFile(
      String token, String fileUuid, InfoMessage infoManager) async {
    await init();
    Tuple2 res = await api.getFile(token, fileUuid);

    if (!res.item1) {
      infoManager.displayMessage(noConnectionMessage, true);
    }

    return res;
  }

  Future<Tuple2> getFiles(String token, InfoMessage infoManager) async {
    await init();
    Tuple2 res = await api.getFiles(token);

    if (!res.item1) {
      infoManager.displayMessage(noConnectionMessage, true);
    }

    return res;
  }

  // ONLINE
  Future<bool> updateUserInfo(String infoToModify, String value, String token,
      InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return false;

    if (infoToModify == 'email' && EmailValidator.validate(value) ||
        infoToModify == 'password' ||
        infoToModify == 'username') {
      Tuple2<bool, String> res =
          await api.modifAttribut(token, infoToModify, value);

      if (res.item1) {
        infoManager.displayMessage(
            "${infoToModify.capitalize()} modified succesfully !", false);
        return true;
      } else {
        infoManager.displayMessage(
            "An error occured :/ Please try again.", true);
        return false;
      }
    } else {
      infoManager.displayMessage(
          "This is not a valid $infoToModify :/ Please try again.", true);
      return false;
    }
  }

  Future<Tuple2<bool, String>> login(
      String password, String email, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return const Tuple2(false, "offline");

    String hash = sha256.convert(utf8.encode(password)).toString();
    Tuple2<bool, String> res = await api.connexion(email, hash);

    if (res.item1) {
      return Tuple2(true, res.item2);
    } else {
      infoManager.displayMessage(
          "Authentification failed! Enter your actual password carefully.",
          true);
      return const Tuple2(false, "An error occured during connexion!");
    }
  }

  Future<Tuple2<bool, String>> deleteUser(
      String token, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return const Tuple2(false, "offline");

    Tuple2<bool, String> res = await api.deleteUser(token);

    return res;
  }

  Future<Tuple2<bool, String>> createUser(String email, String hash,
      String username, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return const Tuple2(false, "offline");

    Tuple2<bool, String> res = await api.postUser(email, hash, username);

    return res;
  }

  Future<Tuple2<bool, String>> uploadFile(
      String token, File file, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return const Tuple2(false, "offline");

    Tuple2<bool, String> res = await api.uploadFile(token, file);
    return res;
  }

  Future<Tuple2<bool, String>> uploadFileByte(
      String token,
      Uint8List contentFile,
      String filename,
      String category,
      DateTime date,
      ActivityInfo activityInfo,
      InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return const Tuple2(false, "offline");

    Tuple2<bool, String> res = await api.uploadFileByte(
        token, contentFile, filename, category, date, activityInfo);
    if (!res.item1) infoManager.displayMessage(noConnectionMessage, true);

    //stdout.write("uploadFileByte: ${res.item1}\n");
    return res;
  }

  Future<bool> deleteFile(
      String token, String fileUuid, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return false;

    bool res = await api.deleteFile(token, fileUuid);
    if (!res) infoManager.displayMessage(noConnectionMessage, true);

    return res;
  }

  Future<Tuple2> getModeleAI(
      String token, String category, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return const Tuple2(false, "offline");

    Tuple2 res = await api.getModeleAI(token, category);
    if (!res.item1) infoManager.displayMessage(noConnectionMessage, true);
    return res;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
