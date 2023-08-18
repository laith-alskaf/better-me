import 'dart:async';
import 'package:BetterMe/core/enums/connectivity_status.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService {

  StreamController<ConnectivityStatus> connectivityStatusController =
      StreamController<ConnectivityStatus>.broadcast();

  ConnectivityService() {
    final Connectivity connectivity = Connectivity();

    connectivity.onConnectivityChanged.listen((ConnectivityResult event) {
      // print("Connection From ConnectivityService Changed To $event");

      connectivityStatusController.add(getStatus(event));
    });
  }

  ConnectivityStatus getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.wifi:
        return ConnectivityStatus.ONLINE;

      case ConnectivityResult.ethernet:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.mobile:
        return ConnectivityStatus.ONLINE;
      case ConnectivityResult.none:
        return ConnectivityStatus.OFFLINE;
      case ConnectivityResult.vpn:
        return ConnectivityStatus.ONLINE;
      // case ConnectivityResult.mobile:
      //   return ConnectivityStatus.ONLINE;
    }
  }
}
