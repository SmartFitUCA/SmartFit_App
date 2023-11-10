import 'dart:io';

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

  // Get one file by id
  Future<Tuple2> getFile(String token, String fileUuid);

  // Delete one file on BDD
  Future<Tuple2<bool, String>> deleteFile(String token, String fileUuid);

  /* -> Modification attribut 
  // Update email
  Future<void> updateEmail(String token, String email);

  // Update username
  Future<void> updateUsername(String token, String username);
  */

  Future<Tuple2> modifAttribut(
      String token, String nameAttribut, String newValue);
}
