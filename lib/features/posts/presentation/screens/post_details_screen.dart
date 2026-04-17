import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/core/core.dart';
import 'package:test_task/features/core/di/di.dart';
import 'package:test_task/features/posts/domain/domain.dart';
import 'package:test_task/features/posts/presentation/state/comments/comments_cubit.dart';
import 'package:test_task/features/posts/presentation/state/comments/comments_state.dart';
import 'package:test_task/features/posts/presentation/widgets/comment_list.dart';

class PostDetailsScreen extends StatefulWidget {
  final Post post;
  const PostDetailsScreen({super.key, required this.post});

  @override
  State<PostDetailsScreen> createState() => _PostDetailsScreenState();
}

class _PostDetailsScreenState extends State<PostDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(widget.post.title.capitalize())),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: BlocProvider(
            create: (context) =>
                getIt<CommentsCubit>(param1: widget.post.id)..loadComments(),
            child: Builder(
              builder: (context) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Text(
                          widget.post.title.capitalize(),
                          textAlign: TextAlign.start,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Text(
                          widget.post.body,
                          textAlign: TextAlign.start,
                          style: theme.textTheme.bodyMedium,
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: Text(
                          "Комментарии:",
                          textAlign: TextAlign.start,
                          style: theme.textTheme.titleLarge,
                        ),
                      ),
                      BlocBuilder<CommentsCubit, CommentsState>(
                        builder: (context, state) {
                          return CommentList(
                            isLoading: state.isLoading,
                            commentsList: state.comments,
                          );
                        },
                      ),
                    ],
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
