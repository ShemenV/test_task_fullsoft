import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/features/auth/auth.dart';
import 'package:test_task/features/posts/posts_list.dart';
import 'package:test_task/features/posts/presentation/screens/post_details_screen.dart';
import 'router_consts.dart';

final GlobalKey<NavigatorState> globalNavigatorKey =
    GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  initialLocation: "/auth",
  // initialLocation: "/select_auth_method",
  navigatorKey: globalNavigatorKey,

  routes: [
    GoRoute(
      path: "/auth",
      name: auth,
      builder: (context, state) => AuthScreen(),
    ),

    GoRoute(
      path: "/posts_list",
      name: postsList,
      builder: (context, state) => PostsListScreen(),
    ),

    GoRoute(
      path: "/post_details",
      name: postDetails,
      builder: (context, state) {
        final post = state.extra as Post;
        return PostDetailsScreen(post: post);
      },
    ),
  ],
);
