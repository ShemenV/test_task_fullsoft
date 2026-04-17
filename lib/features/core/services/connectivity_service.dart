import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';

@injectable
class ConnectivityService {
  final Connectivity connectivity;

  ConnectivityService({required this.connectivity});

  Future<bool> get isOnline async {
    final result = (await connectivity.checkConnectivity()).any(
      (r) => r != ConnectivityResult.none,
    );
    return result;
  }

  Stream<bool> get onConnectivityChanged =>
      connectivity.onConnectivityChanged.map((event) {
        final isOnline = event.any((r) => r != ConnectivityResult.none);
        return isOnline;
      });
}
