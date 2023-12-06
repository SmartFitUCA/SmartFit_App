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

  // Get all files for user
  Future<Tuple2> getFiles(String token);

  // Upload file on BDD
  Future<Tuple2<bool, String>> uploadFile(String token, File file);
  Future<Tuple2<bool, String>> uploadFileByte(
      String token,
      Uint8List contentFile,
      String nameFile,
      String category,
      DateTime date,
      ActivityInfo activityInfo);

  // Get one file by id
  Future<Tuple2> getFile(String token, String fileUuid);

  // Delete one file on BDD
  Future<Tuple2<bool, String>> deleteFile(String token, String fileUuid);

  Future<Tuple2> getInfoUser(String token);
  /* -> Modification attribut 
  // Update email
  Future<void> updateEmail(String token, String email);

  // Update username
  Future<void> updateUsername(String token, String username);
  */

  Future<Tuple2<bool, String>> modifAttribut(
      String token, String nameAttribut, String newValue);
}
