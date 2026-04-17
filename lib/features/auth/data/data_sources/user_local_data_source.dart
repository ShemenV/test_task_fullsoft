import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserLocalDataSource {
  final FlutterSecureStorage _storage;

  UserLocalDataSource(this._storage);

  Future<void> saveUserId(int id) async {
    await _storage.write(key: 'user_id', value: id.toString());
  }

  Future<int?> getUserId() async {
    final value = await _storage.read(key: 'user_id');
    return value != null ? int.parse(value) : null;
  }
}
