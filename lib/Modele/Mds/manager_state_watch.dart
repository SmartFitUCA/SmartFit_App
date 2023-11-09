/*import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mdsflutter/Mds.dart';
import 'package:smartfit_app_mobile/Modele/Mds/DeviceConnectionStatus.dart';
import 'package:smartfit_app_mobile/Modele/Mds/device.dart';

// Doc - https://pub.dev/packages/mdsflutter
//https://github.com/petri-lipponen-movesense/mdsflutter/tree/master/example/lib

class ManagerStateWatch extends ChangeNotifier {
  final Set<Device> _deviceList = {};
  bool _scanning = false;
  // ------------------ //

  bool get scanning => _scanning;
  UnmodifiableListView<Device> get deviceList =>
      UnmodifiableListView(_deviceList);

  // ------------------ //

  void startScan() {
    // On deconnecte les devices si ils sont connecté
    _deviceList.forEach((device) {
      if (device.connectionStatus == DeviceConnectionStatus.CONNECTED) {
        disconnect(device);
      }
    });

    // On vide la liste
    _deviceList.clear();
    notifyListeners();

    // On lance le scan
    try {
      Mds.startScan((name, address) {
        Device device = Device(name, address);
        if (!_deviceList.contains(device)) {
          _deviceList.add(device);
          notifyListeners();
        }
      });
      _scanning = true;
      notifyListeners();
    } on PlatformException {
      _scanning = false;
      notifyListeners();
    }
  }

  void stopScan() {
    Mds.stopScan();
    _scanning = false;
    notifyListeners();
  }

  void disconnect(Device device) {
    // Deconnexion matérielle
    Mds.disconnect(device.address!);

    disconnectOnModele(device.address);
  }

  void disconnectOnModele(String? address) {
    // Deconnexion avec l'enum
    Device foundDevice =
        _deviceList.firstWhere((element) => element.address == address);
    foundDevice.onDisconnected();
    notifyListeners();
  }

  void connectToDevice(Device device) {
    // Changement de l'enum (On connecting)
    device.onConnecting();
    // Connexion matérielle
    Mds.connect(
        device.address!,
        // Connexion établi
        (serial) => _onDeviceMdsConnected(device.address, serial),
        // Connexion coupé
        () => disconnectOnModele(device.address),
        // Erreur dans la connexion
        () => _onDeviceConnectError(device.address));
  }

  // Appeller si la connexion à réussi
  void _onDeviceMdsConnected(String? address, String serial) {
    Device foundDevice =
        _deviceList.firstWhere((element) => element.address == address);
    // On save le serial + changer l'enum en connected
    foundDevice.onMdsConnected(serial);
    notifyListeners();
  }

  // Appeller si une erreur survient dans la connexion
  void _onDeviceConnectError(String? address) {
    disconnectOnModele(address);
  }
}
*/