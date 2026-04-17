import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'comments_state.freezed.dart';

@freezed
abstract class CommentsState with _$CommentsState {
  const factory CommentsState({
    @Default([]) List<Comment> comments,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _CommentsState;
}
