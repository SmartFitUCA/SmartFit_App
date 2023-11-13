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
  Future<Tuple2> getFile(String token, String fileUuid) async {
    final url = Uri.parse('$urlApi/user/files/$fileUuid');

    var request = http.Request('GET', url);
    request.headers.addAll(<String, String>{'Authorization': token});

    var streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);
    // !! Crée un fichier comme ca avec les bytes !!
    //File("//").writeAsBytes(response.bodyBytes);

    if (response.statusCode == 200) {
      return Tuple2(true, response.bodyBytes);
    }
    if ((response.statusCode == 401)) {
      return const Tuple2(false, "401 - UNAUTHORIZED");
    }
    if ((response.statusCode == 404)) {
      return const Tuple2(false, "404 - NOT FOUND");
    }
    return const Tuple2(false, "Fail");
  }

  @override
  Future<Tuple2<bool, String>> deleteFile(String token, String fileUuid) async {
    final response = await http.delete(Uri.parse('$urlApi/user/files'),
        headers: <String, String>{'Authorization': token});

    if (response.statusCode == 200) {
      return const Tuple2(true, "Successful");
    }
    if (response.statusCode == 401) {
      return const Tuple2(false, "401 - UNAUTHORIZED");
    }
    if (response.statusCode == 404) {
      return const Tuple2(false, "404 - NOT FOUND");
    }
    return const Tuple2(false, "Fail");
  }

  @override
  Future<Tuple2<bool, String>> deleteUser(String token) async {
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
  Future<Tuple2> getFiles(String token) async {
    final response = await http.get(Uri.parse('$urlApi/user/files'),
        headers: <String, String>{'Authorization': token});

    if (response.statusCode == 200) {
      return Tuple2(true, response.body);
    }
    if (response.statusCode == 401) {
      return const Tuple2(false, "401 - UNAUTHORIZED");
    }
    return const Tuple2(false, "Fail");
  }

  @override
  Future<Tuple2<bool, String>> connexion(String email, String hash) async {
    final response =
        await http.get(Uri.parse('$urlApi/user/login/$email/$hash'));
    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Tuple2<bool, String>(true, json['token'].toString());
    }
    if (response.statusCode == 401) {
      return const Tuple2<bool, String>(false, "UNAUTHORIZED");
    }
    if (response.statusCode == 404) {
      return const Tuple2<bool, String>(false, "Not found the email");
    }
    return const Tuple2(false, "Fail");
  }

  @override
  Future<Tuple2<bool, String>> postUser(
      String email, String hash, String username) async {
    final response = await http.post(Uri.parse('$urlApi/user'),
        body: <String, String>{
          "email": email,
          "hash": hash,
          "username": username
        });

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Tuple2(true, json['token'].toString());
    }
    if (response.statusCode == 400) {
      return const Tuple2(false, "400 BAD REQUEST - Json mal formaté");
    }
    if (response.statusCode == 409) {
      return const Tuple2(
          false, "409 CONFLICT - Déja un compte avec cet email");
    }
    return const Tuple2(false, "Fail");
  }

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
        headers: <String, String>{'Authorization': token},
        body: jsonEncode(<String, String>{nameAttribut: newValue}));

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Tuple2(true, json);
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
        'file', await file.readAsBytes(),
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
  Future<Tuple2> getInfoUser(String token) async {
    final response = await http.get(Uri.parse('$urlApi/user/info'),
        headers: <String, String>{'Authorization': token});

    if (response.statusCode == 200) {
      Map<String, dynamic> json = jsonDecode(response.body);
      return Tuple2(true, json);
    }
    if (response.statusCode == 400) {
      return const Tuple2(false, "400 - BAD REQUEST");
    }
    if (response.statusCode == 401) {
      return const Tuple2(false, "401 - UNAUTHORIZED");
    }
    return const Tuple2(false, "Fail ");
  }
}
