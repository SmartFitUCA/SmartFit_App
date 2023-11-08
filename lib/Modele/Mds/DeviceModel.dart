import 'package:flutter/material.dart';
import 'package:mdsflutter/Mds.dart';

class DeviceModel extends ChangeNotifier {
  String? _serial;
  String? _info;

  // ------------ //

  String? get info => _info;

  // ------------ //

  void getInfo() {
    MdsAsync.get(Mds.createRequestUri(_serial!, "/Info"), "{}")
        .then((value) => {_info = value});
    notifyListeners();
  }
}
