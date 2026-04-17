import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/features/core/core.dart';
import 'package:test_task/features/core/router/router_consts.dart';
import 'package:test_task/features/posts/domain/domain.dart';

class PostItem extends StatelessWidget {
  final Post post;
  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        context.pushNamed(postDetails, extra: post);
      },
      child: Container(
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 8,
            children: [
              Text(
                post.title.capitalize(),
                textAlign: TextAlign.start,
                style: theme.textTheme.titleMedium,
              ),

              Text(
                post.body,
                textAlign: TextAlign.start,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Подробнее"),
                  Icon(Icons.navigate_next, color: theme.colorScheme.onPrimary),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
