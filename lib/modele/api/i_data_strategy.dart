import 'dart:io';
import 'dart:typed_data';

import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:tuple/tuple.dart';

abstract class IDataStrategy {
  // Create user
  Future<Tuple2<bool, String>> postUser(
      String email, String hash, String username);

  // Delete user
  Future<Tuple2<bool, String>> deleteUser(String token);

  // Get Token validate
  Future<Tuple2<bool, String>> connexion(String email, String hash);

  // Get all files for user (LOCAL OK)
  Future<Tuple2> getFiles(String token);

  // Upload file on BDD
  Future<Tuple2<bool, String>> uploadFile(String token, File file);

  // Upload file as bytes
  Future<Tuple2<bool, String>> uploadFileByte(
      String token,
      Uint8List contentFile,
      String nameFile,
      String category,
      DateTime date,
      ActivityInfo activityInfo);

  // Get one file by id (LOCAL OK)
  Future<Tuple2> getFile(String token, String fileUuid);

  // Delete one file on BDD
  Future<bool> deleteFile(String token, String fileUuid);

  // Get info on user (LOCAL OK)
  Future<Tuple2> getInfoUser(String token);

  // Update email, password, username
  Future<Tuple2<bool, String>> modifAttribut(
      String token, String nameAttribut, String newValue);

  //
  Future<Tuple2> getModeleAI(String token, String category);
}
