import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/repositories/posts_repository_interface.dart';
import 'comments_state.dart';

@injectable
class CommentsCubit extends Cubit<CommentsState> {
  final PostsRepositoryI _repository;
  final int postId;

  CommentsCubit(this._repository, @factoryParam this.postId)
    : super(CommentsState());

  CancelToken? _cancelToken;

  Future<void> loadComments() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    await Future.delayed(Duration(seconds: 2));
    try {
      final comments = await _repository.getComments(
        postId: postId,
        cancelToken: _cancelToken,
      );
      emit(state.copyWith(comments: comments, isLoading: false));
    } on DioException catch (error) {
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: "Ошибка при загрузке комментариев",
          ),
        );
      }
    } catch (error) {
      if (!isClosed) {
        emit(
          state.copyWith(isLoading: false, errorMessage: "Неизвестная ошибка"),
        );
      }
    }
  }
}
