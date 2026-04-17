import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/auth/data/data_sources/user_remote_data_source.dart';
import 'package:test_task/features/auth/domain/entities/user/user.dart';
import 'package:test_task/features/auth/domain/repositories/user_repository_interface.dart';
import 'package:test_task/features/auth/data/mappers/mappers.dart';
import 'package:test_task/features/core/core.dart';

import '../data_sources/user_local_data_source.dart';

@Injectable(as: UserRepositoryI)
class UserRepositoryImpl implements UserRepositoryI {
  final UserRemoteDataSource _userRemoteDataSource;
  final UserLocalDataSource _userLocalDataSource;

  UserRepositoryImpl(this._userRemoteDataSource, this._userLocalDataSource);

  @override
  Future<User> getUserByEmail(String email, {CancelToken? cancelToken}) async {
    final model = await _userRemoteDataSource.getUserByEmail(
      email: email,
      cancelToken: cancelToken,
    );

    if (model == null) throw UserNotFoundException();

    await _userLocalDataSource.saveUserId(model.id);
    return model.toEntity();
  }

  @override
  Future<int?> getCurrentUserId() async {
    return await _userLocalDataSource.getUserId();
  }
}
