import 'dart:convert';
import 'dart:io';

import 'package:smartfit_app_mobile/Modele/Api/i_data_strategy.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class RequestApi extends IDataStrategy {
  // Faire attention au URL
  String urlApi =
      "https://codefirst.iut.uca.fr/containers/SmartFit-smartfit_api";

  @override
  Future<Tuple2<bool, String>> getFile(String token, String fileUuid) async {
    final response = await http.get(Uri.parse('$urlApi/user/files/$fileUuid'),
        headers: <String, String>{'Authorization': token});

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
  Future<Tuple2> deleteUser(String token) async {
    final response = await http.delete(Uri.parse('$urlApi/user'),
        headers: <String, String>{'Authorization': token});
    if (response.statusCode == 200) {
      return const Tuple2<bool, String>(true, "Successful");
    } else if (response.statusCode == 401) {
      return const Tuple2<bool, String>(
          false, "401 UNAUTHORIZED - Mauvais ou pas de token");
    } else if (response.statusCode == 404) {
      return const Tuple2<bool, String>(
          false, "404 NOT FOUND - Pas de compte lié");
    }
    return const Tuple2<bool, String>(false, "Fail");
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
  Future<Tuple2> connexion(String email, String hash) async {
    final response =
        await http.get(Uri.parse('$urlApi/user/login/$email/$hash'));
    if (response.statusCode == 200) {
      Map<String, String> json =
          jsonDecode(response.body) as Map<String, String>;
      return Tuple2<bool, String>(true, json['token']!);
    } else if (response.statusCode == 401) {
      return const Tuple2<bool, String>(false, "UNAUTHORIZED");
    }
    return const Tuple2(false, "Fail");
  }

  /*
  @override
  Future<Tuple2> postUser(String email, String hash, String username) async {
    final response =
        await http.post(Uri.parse('$urlApi/user'), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    }, body: {
      "email": "'$email'",
      "hash": "'$hash'",
      "username": "'$username'"
    });
    if (response.statusCode == 200) {
      return const Tuple2(true, "Successful");
    }
    if (response.statusCode == 400) {
      return const Tuple2(false, "400 BAD REQUEST - Json mal formaté");
    }
    if (response.statusCode == 409) {
      return const Tuple2(
          false, "409 CONFLICT - Déja un compte avec cet email");
    }
    return const Tuple2(false, "Fail");
  }*/

  /*
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
  }*/

  @override
  Future<Tuple2> modifAttribut(
      String token, String nameAttribut, String newValue) async {
    final response = await http.put(Uri.parse('$urlApi/user/$nameAttribut'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': token
        },
        body: jsonEncode(<String, String>{nameAttribut: newValue}));

    if (response.statusCode == 200) {
      return const Tuple2(true, "Successful");
    }
    if (response.statusCode == 400) {
      return const Tuple2(false, "400 - BAD REQUEST");
    }
    if (response.statusCode == 401) {
      return const Tuple2(false, "400 - UNAUTHORIZED");
    } else {
      return const Tuple2(false, "Fail");
    }
  }

  @override
  Future<Tuple2<bool, String>> uploadFile(String token, File file) async {
    final uri = Uri.parse('$urlApi/user/files');
    Map<String, String> headers = {'Authorization': token};

    var request = http.MultipartRequest('POST', uri);
    final httpImage = http.MultipartFile.fromBytes(
        'file_FIT', await file.readAsBytes(),
        filename: file.path.split('/').last);
    request.files.add(httpImage);
    request.headers.addAll(headers);

    final response = await request.send();

    if (response.statusCode == 200) {
      return const Tuple2(true, "Successful");
    }
    if (response.statusCode == 400) {
      return const Tuple2(false, "400 - BAD REQUEST");
    }
    if (response.statusCode == 401) {
      return const Tuple2(false, "401 - UNAUTHORIZED");
    }
    if (response.statusCode == 409) {
      return const Tuple2(false, "409 - CONFLICT");
    }
    return const Tuple2(false, "Fail ");
  }

  @override
  Future<bool> postUser(String email, String hash, String username) {
    // TODO: implement postUser
    throw UnimplementedError();
  }
}
