import 'package:drift/backends.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:test_task/features/core/database/app_database.dart';

@module
abstract class DatabaseModule {
  @lazySingleton
  QueryExecutor executor() => driftDatabase(
    name: 'my_database',
    native: const DriftNativeOptions(
      databaseDirectory: getApplicationSupportDirectory,
    ),
  );

  @lazySingleton
  AppDatabase database(QueryExecutor executor) => AppDatabase(executor);
}
