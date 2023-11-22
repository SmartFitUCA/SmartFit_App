import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smartfit_app_mobile/modele/api/i_data_strategy.dart';
import 'package:smartfit_app_mobile/modele/api/request_api.dart';
import 'package:smartfit_app_mobile/modele/manager_file.dart';
import 'package:smartfit_app_mobile/modele/user.dart';
import 'package:tuple/tuple.dart';

class ListActivityUtile {
  final IDataStrategy _strategy = RequestApi();
  final ManagerFile _managerFile = ManagerFile();

  Future<void> getContentOnTheFirstFileMobile(BuildContext context) async {
    String fileUuid =
        Provider.of<User>(context, listen: false).listActivity[0].fileUuid;

    Tuple2 result = await _strategy.getFile(
        Provider.of<User>(context, listen: false).token,
        Provider.of<User>(context, listen: false).listActivity[0].fileUuid);
    if (result.item1 == false) {
      //Erreur
      //print(result);
      return;
    }
    File file = File(
        "${await _managerFile.localPath}/${Provider.of<User>(context, listen: false).listActivity[0].nameFile}");
    await file.create();
    await file.writeAsBytes(result.item2);
    Provider.of<User>(context, listen: false).listActivity[0].contentActivity =
        await _managerFile.readFitFileWhithFile(file);
  }

  Future<void> getContentOnTheFirstFileWeb(BuildContext context) async {
    User user = Provider.of<User>(context, listen: false);
    Tuple2 result =
        await _strategy.getFile(user.token, user.listActivity[0].fileUuid);
    if (result.item1 == false) {
      //Erreur
      //print(result);
      return;
    }
    Provider.of<User>(context, listen: false).listActivity[0].contentActivity =
        await _managerFile.readFitFileWeb(result.item2);
  }
}
