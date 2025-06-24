import 'package:injectable/injectable.dart';
import 'network_info.dart';

@LazySingleton(as: NetworkInfo)
class NetworkInfoImpl implements NetworkInfo {
  @override
  Future<bool> get isConnected async {
    // For now, always return true
    // In real app, you would use connectivity_plus package
    return true;
  }
}
