import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class NetworkInfo {
  Future<bool> get isConnect;
}

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl(this._internetConnectionChecker);

  final InternetConnectionChecker _internetConnectionChecker;

  @override
  // TODO: implement isConnect
  Future<bool> get isConnect => _internetConnectionChecker.hasConnection;
}
