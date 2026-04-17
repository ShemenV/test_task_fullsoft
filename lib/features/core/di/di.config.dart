// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:connectivity_plus/connectivity_plus.dart' as _i895;
import 'package:dio/dio.dart' as _i361;
import 'package:drift/backends.dart' as _i883;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:talker/talker.dart' as _i993;
import 'package:test_task/features/auth/data/data_sources/user_local_data_source.dart'
    as _i986;
import 'package:test_task/features/auth/data/data_sources/user_remote_data_source.dart'
    as _i885;
import 'package:test_task/features/auth/data/repositories/user_repository_impl.dart'
    as _i271;
import 'package:test_task/features/auth/domain/repositories/repositories.dart'
    as _i799;
import 'package:test_task/features/auth/domain/repositories/user_repository_interface.dart'
    as _i425;
import 'package:test_task/features/auth/presentation/state/auth_cubit.dart'
    as _i935;
import 'package:test_task/features/connectivity/presentation/state/connecntivity/connectivity_cubit.dart'
    as _i592;
import 'package:test_task/features/core/core.dart' as _i708;
import 'package:test_task/features/core/database/app_database.dart' as _i192;
import 'package:test_task/features/core/database/dao/comments_dao.dart'
    as _i229;
import 'package:test_task/features/core/database/dao/posts_dao.dart' as _i326;
import 'package:test_task/features/core/di/modules/database_module.dart'
    as _i842;
import 'package:test_task/features/core/di/modules/network_module.dart'
    as _i1002;
import 'package:test_task/features/core/di/modules/storage_module.dart'
    as _i351;
import 'package:test_task/features/core/di/modules/utils_module.dart' as _i606;
import 'package:test_task/features/core/network/api_client/api_client.dart'
    as _i770;
import 'package:test_task/features/core/network/api_client/api_client_interface.dart'
    as _i994;
import 'package:test_task/features/core/services/connectivity_service.dart'
    as _i177;
import 'package:test_task/features/posts/data/data_sources/posts_local_data_source.dart'
    as _i918;
import 'package:test_task/features/posts/data/data_sources/posts_remote_data_source.dart'
    as _i131;
import 'package:test_task/features/posts/data/repositories/posts_repository_impl.dart'
    as _i18;
import 'package:test_task/features/posts/domain/domain.dart' as _i81;
import 'package:test_task/features/posts/domain/repositories/posts_repository_interface.dart'
    as _i368;
import 'package:test_task/features/posts/presentation/state/comments/comments_cubit.dart'
    as _i656;
import 'package:test_task/features/posts/presentation/state/posts_list/posts_list_cubit.dart'
    as _i21;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final databaseModule = _$DatabaseModule();
    final networkModule = _$NetworkModule();
    final storageModule = _$StorageModule();
    final utilsModule = _$UtilsModule();
    gh.lazySingleton<_i883.QueryExecutor>(() => databaseModule.executor());
    gh.lazySingleton<_i895.Connectivity>(() => networkModule.connectivity());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => storageModule.secureStorage(),
    );
    gh.lazySingleton<_i993.Talker>(() => utilsModule.logger());
    gh.lazySingleton<_i994.ApiClientI>(
      () => _i770.DioApiClient(gh<_i361.Dio>()),
    );
    gh.factory<_i131.PostsRemoteDataSource>(
      () => _i131.PostsRemoteDataSource(apiClient: gh<_i994.ApiClientI>()),
    );
    gh.lazySingleton<_i192.AppDatabase>(
      () => databaseModule.database(gh<_i883.QueryExecutor>()),
    );
    gh.factory<_i229.CommentsDao>(
      () => _i229.CommentsDao(gh<_i192.AppDatabase>()),
    );
    gh.factory<_i326.PostsDao>(() => _i326.PostsDao(gh<_i192.AppDatabase>()));
    gh.factory<_i986.UserLocalDataSource>(
      () => _i986.UserLocalDataSource(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i918.PostsLocalDataSource>(
      () => _i918.PostsLocalDataSource(
        gh<_i326.PostsDao>(),
        gh<_i229.CommentsDao>(),
      ),
    );
    gh.factory<_i177.ConnectivityService>(
      () => _i177.ConnectivityService(connectivity: gh<_i895.Connectivity>()),
    );
    gh.factory<_i885.UserRemoteDataSource>(
      () => _i885.UserRemoteDataSource(
        apiClient: gh<_i708.ApiClientI>(),
        logger: gh<_i993.Talker>(),
      ),
    );
    gh.factory<_i81.PostsRepositoryI>(
      () => _i18.PostsRepositoryImpl(
        postsRemoteDataSource: gh<_i131.PostsRemoteDataSource>(),
        postsLocalDataSource: gh<_i918.PostsLocalDataSource>(),
        connectivityService: gh<_i177.ConnectivityService>(),
      ),
    );
    gh.factory<_i592.ConnectivityCubit>(
      () => _i592.ConnectivityCubit(
        connectivityService: gh<_i177.ConnectivityService>(),
      ),
    );
    gh.factory<_i425.UserRepositoryI>(
      () => _i271.UserRepositoryImpl(
        gh<_i885.UserRemoteDataSource>(),
        gh<_i986.UserLocalDataSource>(),
      ),
    );
    gh.factoryParam<_i656.CommentsCubit, int, dynamic>(
      (postId, _) => _i656.CommentsCubit(gh<_i368.PostsRepositoryI>(), postId),
    );
    gh.factory<_i21.PostsListCubit>(
      () => _i21.PostsListCubit(gh<_i81.PostsRepositoryI>()),
    );
    gh.factory<_i935.AuthCubit>(
      () => _i935.AuthCubit(gh<_i799.UserRepositoryI>()),
    );
    return this;
  }
}

class _$DatabaseModule extends _i842.DatabaseModule {}

class _$NetworkModule extends _i1002.NetworkModule {}

class _$StorageModule extends _i351.StorageModule {}

class _$UtilsModule extends _i606.UtilsModule {}
