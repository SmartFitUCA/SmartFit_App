import 'dart:convert';
import 'dart:io';

import 'package:smartfit_app_mobile/Modele/Api/i_data_strategy.dart';
import 'package:http/http.dart' as http;

class RequestApi extends IDataStrategy {
  // Faire attention au URL
  String urlApi =
      "https://codefirst.iut.uca.fr/containers/SmartFit-smartfit_api";

  @override
  Future<String> getFile(String token, String idFile) async {
    final response = await http.get(Uri.parse('$urlApi/$token/files/$idFile'));
    if (response.statusCode == 200) {
      /*return Classe.fromJson(jsonDecode(response.body) as Map<String, dynamic>);*/
      throw UnimplementedError();
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> deleteFile(String token, String idFile) async {
    final response = await http.delete(Uri.parse('$urlApi/$token/files'));
    if (response.statusCode == 200) {
      /*return Classe.fromJson(jsonDecode(response.body) as Map<String, dynamic>);*/
      throw UnimplementedError();
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> deleteUser(String token) async {
    final response = await http.delete(Uri.parse('$urlApi/user'),
        headers: <String, String>{'Authorization': token});
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<String> getFiles(String token) async {
    final response = await http.get(Uri.parse('$urlApi/$token/files'));
    if (response.statusCode == 200) {
      /*return Classe.fromJson(jsonDecode(response.body) as Map<String, dynamic>);*/
      throw UnimplementedError();
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<String> getToken(String uuid, String passwordHash) async {
    final response =
        await http.get(Uri.parse('$urlApi/$uuid/$passwordHash/token'));
    if (response.statusCode == 200) {
      /*return Classe.fromJson(jsonDecode(response.body) as Map<String, dynamic>);*/
      throw UnimplementedError();
    } else {
      throw UnimplementedError();
    }
  }

  @override
  Future<bool> postUser(String email, String hash, String username) async {
    final response =
        await http.post(Uri.parse('$urlApi/user'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: {
      "email": "'$email'",
      "hash": "'$hash'",
      "username": "'$username'"
    });
    if (response.statusCode == 200) {
      return true;
    }
    if (response.statusCode == 400) {
      print("Json mal formaté");
    }
    // Erreur possible 409 (Déja un compte avec cet email)
    return false;
  }

  @override
  Future<bool> updateEmail(String token, String email) async {
    final response = await http.put(Uri.parse('$urlApi/$token/email'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'email': email}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> updateUsername(String token, String username) async {
    final response = await http.put(Uri.parse('$urlApi/$token/username'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{'username': username}));

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> uploadFile(String token, File file) async {
    final response = await http.post(Uri.parse('$urlApi/$token/UploadFile'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, File>{'file': file}));
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
