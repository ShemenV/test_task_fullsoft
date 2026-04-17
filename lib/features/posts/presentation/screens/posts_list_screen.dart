import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/core/core.dart';
import 'package:test_task/features/posts/posts_list.dart';
import 'package:test_task/features/posts/presentation/state/posts_list/posts_list_cubit.dart';
import 'package:test_task/features/posts/presentation/state/posts_list/posts_list_state.dart';

import '../../../core/di/di.dart';
import '../widgets/post_item.dart';

class PostsListScreen extends StatefulWidget {
  const PostsListScreen({super.key});

  @override
  State<PostsListScreen> createState() => _PostsListScreenState();
}

class _PostsListScreenState extends State<PostsListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<PostsListCubit>()..loadPosts(),
      child: Scaffold(
        appBar: AppBar(title: Text("Посты")),
        body: SafeArea(
          child: BlocListener<PostsListCubit, PostsListState>(
            listenWhen:
                (previous, current) => // Только при изменении
                    current.errorMessage != null,
            listener: (BuildContext context, state) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  backgroundColor: Colors.red,
                  content: Text(
                    state.errorMessage!,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              );
            },
            child: BlocBuilder<PostsListCubit, PostsListState>(
              builder: (context, state) {
                if (state.errorMessage != null && state.posts.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          BaseButton(
                            onTap: () {
                              context.read<PostsListCubit>().loadPosts();
                            },
                            text: "Повторить загрузку",
                          ),
                        ],
                      ),
                    ),
                  );
                }



                return NotificationListener<ScrollNotification>(
                  onNotification: (notification) {
                    if (notification is ScrollEndNotification &&
                        notification.metrics.pixels >=
                            notification.metrics.maxScrollExtent - 200) {
                      context.read<PostsListCubit>().loadMorePosts();
                    }
                    return false;
                  },
                  child: RefreshIndicator(
                    onRefresh: () => context.read<PostsListCubit>().loadPosts(),
                    child: PostsList(
                      posts: state.posts,
                      isLoading: state.isLoading,
                      isLoadingMore: state.isLoadingMore,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
