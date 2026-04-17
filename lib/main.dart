import 'package:flutter/material.dart';
import 'package:test_task/posts_app.dart';
import 'features/core/di/di.dart';

void main() {
  configureDependencies();
  runApp(const PostsApp());
}



