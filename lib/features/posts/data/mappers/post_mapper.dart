import 'package:test_task/features/posts/data/models/post_model/post_model.dart';
import 'package:test_task/features/posts/posts_list.dart';

extension PostMapper on PostModel {
  Post toEntity() {
    return Post(id: id, title: title, body: body);
  }
}
