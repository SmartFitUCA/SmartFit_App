import 'dart:io';

import 'package:tuple/tuple.dart';

abstract class IDataStrategy {
  // Create user
  Future<bool> postUser(String email, String hash, String username);

  // Delete user
  Future<void> deleteUser(String token);

  // Get Token validate
  Future<void> connexion(String email, String hash);

  // Get all files for user
  //Future<void> getFiles(String token);

  // Upload file on BDD
  Future<Tuple2<bool, String>> uploadFile(String token, File file);

  // Get one file by id
  Future<Tuple2<bool, String>> getFile(String token, String fileUuid);

  // Delete one file on BDD
  //Future<void> deleteFile(String token, String idFile);

  /* -> Modification attribut 
  // Update email
  Future<void> updateEmail(String token, String email);

  // Update username
  Future<void> updateUsername(String token, String username);
  */

  Future<Tuple2> modifAttribut(
      String token, String nameAttribut, String newValue);
}
