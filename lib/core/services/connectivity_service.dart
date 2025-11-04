import 'dart:async';
import 'package:get/get.dart';
import 'package:BetterMe/core/enums/connectivity_status.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

/// Connectivity Service - GetX Service
/// يتعامل مع التحقق من حالة الاتصال بالإنترنت
class ConnectivityService extends GetxService {
  late StreamSubscription<ConnectivityResult> _subscription;
  
  // Observable for reactive updates
  final Rx<ConnectivityStatus> connectionStatus =
      ConnectivityStatus.unknown.obs;

  // Singleton pattern
  static ConnectivityService get to => Get.find();

  @override
  void onInit() {
    super.onInit();
    _initConnectivityListener();
  }

  /// Initialize connectivity listener
  void _initConnectivityListener() {
    final Connectivity connectivity = Connectivity();

    _subscription = connectivity.onConnectivityChanged.listen((result) {
      connectionStatus.value = _getStatus(result);
      debugLog('Connectivity Status: ${connectionStatus.value}');
    });
  }

  /// Get connectivity status from result
  ConnectivityStatus _getStatus(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.bluetooth:
      case ConnectivityResult.wifi:
      case ConnectivityResult.ethernet:
      case ConnectivityResult.mobile:
      case ConnectivityResult.vpn:
        return ConnectivityStatus.online;
      case ConnectivityResult.none:
        return ConnectivityStatus.offline;
      case ConnectivityResult.other:
        return ConnectivityStatus.unknown;
    }
  }

  /// Check if connected to internet
  bool get isConnected => connectionStatus.value == ConnectivityStatus.online;

  /// Check if disconnected
  bool get isOffline => connectionStatus.value == ConnectivityStatus.offline;

  /// Debug log utility
  void debugLog(String message) {
    // print('ConnectivityService: $message');
  }

  @override
  void onClose() {
    _subscription.cancel();
    super.onClose();
  }
}
