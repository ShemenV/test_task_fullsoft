import 'package:injectable/injectable.dart';
import 'package:talker/talker.dart';
import 'package:talker_flutter/talker_flutter.dart';

@module
abstract class UtilsModule {
  @lazySingleton
  Talker logger() => TalkerFlutter.init(settings: TalkerSettings());
}
