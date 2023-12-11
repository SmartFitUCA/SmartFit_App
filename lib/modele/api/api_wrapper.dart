import 'dart:typed_data';

import 'package:flutter/foundation.dart';
import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/local_db/request_local.dart';
import 'package:smartfit_app_mobile/modele/utile/info_message.dart';
import 'package:email_validator/email_validator.dart';
import 'package:tuple/tuple.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:smartfit_app_mobile/main.dart';
import 'dart:io';

class ApiWrapper {
  late IDataStrategy api;
  String noConnectionMessage =
      "It seems like you are lost far away in the universe, no connection found :)";

  // HELPERS
  // TODO: Change check online for flutterWeb
  Future<bool> isOnline() async {
    try {
      final result = await InternetAddress.lookup('example.com')
          .timeout(const Duration(seconds: 2));
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    } on UnsupportedError catch (_) {
      return true;
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
      stdout.write("(API) ");
      api = RequestApi();
    } else if (!kIsWeb && localDB.getSaveLocally()) {
      stdout.write("(LOCAL) ");
      api = RequestLocal();
    } else {
      stdout.write("(API OFFLINE) ");
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

    stdout.write("getUserInfo: ${res.item1}\n");
    return res;
  }

  Future<Tuple2> getFile(
      String token, String fileUuid, InfoMessage infoManager) async {
    await init();
    Tuple2 res = await api.getFile(token, fileUuid);

    if (!res.item1) {
      infoManager.displayMessage(noConnectionMessage, true);
    }

    stdout.write("getFile: ${res.item1}\n");
    return res;
  }

  Future<Tuple2> getFiles(String token, InfoMessage infoManager) async {
    await init();
    Tuple2 res = await api.getFiles(token);

    if (!res.item1) {
      infoManager.displayMessage(noConnectionMessage, true);
    }

    stdout.write("getFiles: ${res.item1}\n");
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

      stdout.write("updateUserInfo: ${res.item1}\n");
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

    stdout.write("login: ${res.item1}\n");
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

    stdout.write("deleteUser: ${res.item1}\n");
    return res;
  }

  Future<Tuple2<bool, String>> createUser(String email, String hash,
      String username, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return const Tuple2(false, "offline");

    Tuple2<bool, String> res = await api.postUser(email, hash, username);

    stdout.write("createUser: ${res.item1}\n");
    return res;
  }

  Future<Tuple2<bool, String>> uploadFile(
      String token, File file, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return const Tuple2(false, "offline");

    Tuple2<bool, String> res = await api.uploadFile(token, file);
    stdout.write("uploadFile: ${res.item1}\n");
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

    stdout.write("uploadFileByte: ${res.item1}\n");
    return res;
  }

  Future<bool> deleteFile(
      String token, String fileUuid, InfoMessage infoManager) async {
    await init();
    if (handleOffline(infoManager)) return false;

    bool res = await api.deleteFile(token, fileUuid);
    if (!res) infoManager.displayMessage(noConnectionMessage, true);

    stdout.write("deleteFile: $res\n");
    return res;
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
