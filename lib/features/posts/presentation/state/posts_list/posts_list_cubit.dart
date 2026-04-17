import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/posts/domain/domain.dart';
import 'package:test_task/features/posts/presentation/state/posts_list/posts_list_state.dart';

@injectable
class PostsListCubit extends Cubit<PostsListState> {
  final PostsRepositoryI _repository;

  PostsListCubit(this._repository) : super(const PostsListState());

  CancelToken? _cancelToken;

  Future<void> loadPosts() async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true, errorMessage: null));

    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    await Future.delayed(Duration(seconds: 2));
    try {
      final posts = await _repository.getPosts(1, cancelToken: _cancelToken);
      emit(
        state.copyWith(
          posts: posts,
          page: 1,
          hasMore: posts.isNotEmpty,
          isLoading: false,
        ),
      );
    } on DioException catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Ошибка при загрузкe постов",
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(isLoading: false, errorMessage: "Неизвестная ошибка"),
      );
    }
  }

  Future<void> loadMorePosts() async {
    if (state.isLoadingMore || state.hasMore == false) return;

    emit(state.copyWith(isLoadingMore: true));
    _cancelToken?.cancel();
    _cancelToken = CancelToken();
    try {
      final nextPage = state.page + 1;
      final newPosts = await _repository.getPosts(
        nextPage,
        cancelToken: _cancelToken,
      );
      emit(
        state.copyWith(
          posts: [...state.posts, ...newPosts],
          page: nextPage,
          hasMore: newPosts.isNotEmpty,
          isLoadingMore: false,
        ),
      );
    } on DioException catch (error) {
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: "Ошибка при загрузкe постов",
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(isLoading: false, errorMessage: "Неизвестная ошибка"),
      );
    }
  }
}
