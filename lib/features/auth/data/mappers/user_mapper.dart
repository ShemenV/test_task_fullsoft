import 'package:test_task/features/auth/data/models/models.dart';
import 'package:test_task/features/auth/domain/entities/entities.dart';

extension UserMapper on UserModel {
  User toEntity() {
    return User(id: id, name: name, email: email, username: username);
  }
}
