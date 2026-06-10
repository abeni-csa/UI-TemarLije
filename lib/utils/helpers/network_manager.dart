import 'dart:async';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/services.dart';
import 'package:ui_temarlije/utils/popups/loaders.dart';

/// Manages network connectivity status and provides methods to check
/// and monitor internet connection changes throughout the app
class NetworkManager extends GetxController {
  static NetworkManager get instance => Get.find();

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  /// Stream of current connection status (stores all active connection types)
  final RxList<ConnectivityResult> _connectionStatus =
      <ConnectivityResult>[].obs;

  /// Observable boolean indicating if device has internet connection
  final RxBool isConnected = true.obs;

  @override
  void onInit() {
    super.onInit();
    // Listen to connectivity changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _updateConnectionStatus,
    );
    _checkInitialConnection();
  }

  /// Checks initial connection status when app starts
  Future<void> _checkInitialConnection() async {
    final result = await _connectivity.checkConnectivity();
    _updateConnectionStatus(result);
  }

  /// Updates connection status when network state changes
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    _connectionStatus.value = result;
    TemarLijeLoaders.customToast(message: 'No Internet Connection');
    isConnected.value = !result.contains(ConnectivityResult.none);
  }

  /// Checks current connectivity status
  /// Returns true if connected to any network, false otherwise
  Future<bool> checkConnectivity() async {
    try {
      final result = await _connectivity.checkConnectivity();
      TemarLijeLoaders.customToast(message: 'Checking Connectivity');
      return !result.contains(ConnectivityResult.none);
    } on PlatformException catch (_) {
      return true;
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
