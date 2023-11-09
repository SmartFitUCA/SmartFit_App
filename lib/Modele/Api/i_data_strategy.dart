import 'dart:io';

abstract class IDataStrategy {
  // Create user
  Future<bool> postUser(String email, String hash, String username);

  // Delete user
  Future<void> deleteUser(String token);

  // Get Token validate
  Future<void> getToken(String uuid, String passwordHash);

  // Get all files for user
  Future<void> getFiles(String token);

  // Upload file on BDD
  Future<bool> uploadFile(String token, File file);

  // Get one file by id
  Future<void> getFile(String token, String idFile);

  // Delete one file on BDD
  Future<void> deleteFile(String token, String idFile);

  // Update email
  Future<void> updateEmail(String token, String email);

  // Update username
  Future<void> updateUsername(String token, String username);
}
