import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> isConnected();

  Stream<List<ConnectivityResult>> connectivitySubscription();
}

class NetworkInfoImpl implements NetworkInfo {
  final Connectivity connectivity;

  NetworkInfoImpl(this.connectivity);

  @override
  Future<bool> isConnected() async {
    final result = await connectivity.checkConnectivity();
    return (result.isNotEmpty && (result.first != ConnectivityResult.none));
  }

  @override
  Stream<List<ConnectivityResult>> connectivitySubscription() {
    return connectivity.onConnectivityChanged;
  }
}
