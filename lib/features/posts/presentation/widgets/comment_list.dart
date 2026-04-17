import 'package:flutter/material.dart';
import 'package:test_task/features/posts/domain/domain.dart';
import 'package:test_task/features/posts/presentation/widgets/comment_item.dart';
import 'package:test_task/features/posts/presentation/widgets/comment_item_skeleton.dart';

class CommentList extends StatelessWidget {
  final List<Comment> commentsList;
  final bool isLoading;
  const CommentList({
    super.key,
    required this.commentsList,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: CommentItemSkeleton(),
          );
        },
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: commentsList.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: CommentItem(comment: commentsList[index]),
        );
      },
    );
  }
}
