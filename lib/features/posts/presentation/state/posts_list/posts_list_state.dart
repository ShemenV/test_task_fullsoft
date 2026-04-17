import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'posts_list_state.freezed.dart';

@freezed
abstract class PostsListState with _$PostsListState {
  const factory PostsListState({
    @Default([]) List<Post> posts,
    @Default(false) bool isLoading,
    @Default(false) bool isLoadingMore,
    @Default(1) int page,
    @Default(true) bool hasMore,
    String? errorMessage,
  }) = _PostsListState;
}
