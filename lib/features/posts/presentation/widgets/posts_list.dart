import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/posts/domain/domain.dart';
import 'package:test_task/features/posts/presentation/widgets/post_item.dart';
import 'package:test_task/features/posts/presentation/widgets/post_item_skeleton.dart';

import '../../../core/widgets/base_button.dart';
import '../state/posts_list/posts_list_cubit.dart';

class PostsList extends StatelessWidget {
  final List<Post> posts;
  final bool isLoadingMore;
  final bool isLoading;
  const PostsList({super.key, required this.posts, required this.isLoadingMore, required this.isLoading});

  @override
  Widget build(BuildContext context) {
    if (isLoading && posts.isEmpty) {
      return ListView.builder(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        itemCount: 5,
        itemBuilder: (context, index) {
          return PostItemSkeleton();
        },
      );
    }

    if (posts.isEmpty) {
      return Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: const Text("Нет постов"),
            ),
            BaseButton(
              onTap: () {
                context.read<PostsListCubit>().loadPosts();
              },
              text: "Повторить загрузку",
            ),
          ],
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      itemCount: posts.length + (isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index <posts.length) {
          return Padding(
            padding: const EdgeInsets.only(
              bottom: 16,
              right: 16,
              left: 16,
            ),
            child: PostItem(post: posts[index]),
          );
        }

        return const Padding(
          padding: EdgeInsets.symmetric(vertical: 16),
          child: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
