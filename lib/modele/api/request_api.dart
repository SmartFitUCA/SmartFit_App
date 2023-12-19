import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:smartfit_app_mobile/modele/activity_info/activity_info.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';

class RequestApi implements IDataStrategy {
  // Faire attention au URL
  String urlApi =
      "https://codefirst.iut.uca.fr/containers/SmartFit-smartfit_api";

  @override
  Future<Tuple2> getFile(String token, String fileUuid) async {
    final url = Uri.parse('$urlApi/user/files/$fileUuid');

    var request = http.Request('GET', url);
    request.headers.addAll(<String, String>{'Authorization': token});

    try {
      var streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        return Tuple2(true, response.bodyBytes);
      }
      if ((response.statusCode == 401)) {
        return const Tuple2(false, "401 - UNAUTHORIZED");
      }
      if ((response.statusCode == 404)) {
        return const Tuple2(false, "404 - NOT FOUND");
      }
      // When Network Off
    } on SocketException {
      return const Tuple2(false, "No connection");
    }

    return const Tuple2(false, "Fail");
  }

  @override
  Future<bool> deleteFile(String token, String fileUuid) async {
    try {
      final response = await http.delete(
          Uri.parse('$urlApi/user/files/$fileUuid'),
          headers: <String, String>{'Authorization': token});

      if (response.statusCode == 200) {
        return true;
      }
      if (response.statusCode == 401) {
        return false;
      }
      if (response.statusCode == 404) {
        return false;
      }
    } on SocketException catch (_) {
      return false;
    }
    return false;
  }

  @override
  Future<Tuple2<bool, String>> deleteUser(String token) async {
    try {
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
    } on SocketException catch (_) {
      return const Tuple2<bool, String>(false, "No connection");
    }
    return const Tuple2<bool, String>(false, "Fail");
  }

  @override
  Future<Tuple2> getFiles(String token) async {
    try {
      final response = await http.get(Uri.parse('$urlApi/user/files'),
          headers: <String, String>{'Authorization': token});

      if (response.statusCode == 200) {
        return Tuple2(true,
            (json.decode(response.body) as List).cast<Map<String, dynamic>>());
      }
      if (response.statusCode == 401) {
        return const Tuple2(false, "401 - UNAUTHORIZED");
      }
    } on SocketException catch (_) {
      return const Tuple2(false, "No connection");
    }
    return const Tuple2(false, "Fail");
  }

  @override
  Future<Tuple2<bool, String>> connexion(String email, String hash) async {
    try {
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
    } on SocketException catch (_) {
      return const Tuple2(false, "No connection");
    }
    return const Tuple2(false, "Fail");
  }

  @override
  Future<Tuple2<bool, String>> postUser(
      String email, String hash, String username) async {
    var body = {"email": email, "hash": hash, "username": username};
    var header = {"Content-Type": "application/json"};
    try {
      final response = await http.post(Uri.parse('$urlApi/user'),
          headers: header, body: jsonEncode(body));

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
    } on SocketException catch (_) {
      return const Tuple2(false, "No connection");
    }
    return const Tuple2(false, "Fail");
  }

  @override
  Future<Tuple2<bool, String>> modifAttribut(
      String token, String nameAttribut, String newValue) async {
    try {
      final response = await http.put(Uri.parse('$urlApi/user/$nameAttribut'),
          headers: <String, String>{
            'Authorization': token,
            "Content-Type": "application/json"
          },
          body: jsonEncode(<String, String>{nameAttribut: newValue}));

      if (response.statusCode == 200) {
        //Map<String, dynamic> json = jsonDecode(response.body);
        return const Tuple2(true, "200 - OK");
      }
      if (response.statusCode == 400) {
        return const Tuple2(false, "400 - BAD REQUEST");
      }
      if (response.statusCode == 401) {
        return const Tuple2(false, "400 - UNAUTHORIZED");
      }
    } on SocketException catch (_) {
      return const Tuple2(false, "No connection");
    }
    return const Tuple2(false, "Fail");
  }

  // -- Priviligié uploadFileByte -- //
  @override
  Future<Tuple2<bool, String>> uploadFile(String token, File file) async {
    String filename = file.path.split('/').last;
    String categoryActivity = filename.split("_").first.toLowerCase();
    String dateActivity = filename.split("_")[1].split("T").first;

    final uri = Uri.parse('$urlApi/user/files');
    Map<String, String> headers = {'Authorization': token};

    var request = http.MultipartRequest('POST', uri);
    final httpImage = http.MultipartFile.fromBytes(
      'file',
      await file.readAsBytes(),
      filename: filename,
    );
    request.files.add(httpImage);
    request.headers.addAll(headers);
    request.fields["SmartFit_Category"] = categoryActivity;
    request.fields["SmartFit_Date"] = dateActivity;

    try {
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
    } on SocketException catch (_) {
      return const Tuple2(false, "No connection");
    }
    return const Tuple2(false, "Fail ");
  }

  @override
  Future<Tuple2<bool, String>> uploadFileByte(
      String token,
      Uint8List contentFile,
      String nameFile,
      String category,
      DateTime date,
      ActivityInfo activityInfo) async {
    final uri = Uri.parse('$urlApi/user/files');
    Map<String, String> headers = {'Authorization': token};

    var request = http.MultipartRequest('POST', uri);
    final httpImage = http.MultipartFile.fromBytes(
      'file',
      contentFile,
      filename: nameFile,
    );
    request.files.add(httpImage);
    request.headers.addAll(headers);
    request.fields["SmartFit_Category"] = category;
    request.fields["SmartFit_Date"] = date.toString();
    request.fields["info"] = activityInfo.toJson();

    try {
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
    } on SocketException catch (_) {
      return const Tuple2(false, "No connection");
    }
    return const Tuple2(false, "Fail ");
  }

  @override
  Future<Tuple2> getInfoUser(String token) async {
    try {
      final response = await http.get(Uri.parse('$urlApi/user/info'),
          headers: <String, String>{'Authorization': token});
      if (response.statusCode == 200) {
        Map<String, Map<String, List<double>>> json = jsonDecode(response.body);

        return Tuple2(true, json);
      }
      if (response.statusCode == 400) {
        return const Tuple2(false, "400 - BAD REQUEST");
      }
      if (response.statusCode == 401) {
        return const Tuple2(false, "401 - UNAUTHORIZED");
      }
    } on SocketException catch (_) {
      return const Tuple2(false, "No connection");
    }
    return const Tuple2(false, "Fail");
  }

  @override
  Future<Tuple2> getModeleAI(String token, String category) async {
    try {
      final response = await http.get(Uri.parse('$urlApi/user/ai/$category'),
          headers: <String, String>{'Authorization': token});

      if (response.statusCode == 200) {
        Map<String, dynamic> json = jsonDecode(response.body);
        return Tuple2(true, json);
      } else {
        return const Tuple2(false, "Fail");
      }
    } on SocketException catch (_) {
      return const Tuple2(false, "No connection");
    }
  }
}
