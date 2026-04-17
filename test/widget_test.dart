import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test_task/features/core/core.dart';
import 'package:test_task/features/posts/posts_list.dart';

import 'widget_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PostsListCubit>()])
void main() {
  late MockPostsListCubit mockCubit;

  setUp(() {
    mockCubit = MockPostsListCubit();
  });

  testWidgets("show skeleton where loading", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostsList(posts: [], isLoadingMore: false, isLoading: true),
        ),
      ),
    );

    expect(find.byType(PostItemSkeleton), findsWidgets);
  });

  testWidgets("show refresh button where empty posts", (widgetTester) async {
    await widgetTester.pumpWidget(
      MaterialApp(
        home: BlocProvider<PostsListCubit>.value(
          value: mockCubit,
          child: PostsList(posts: [], isLoadingMore: false, isLoading: false),
        ),
      ),
    );

    expect(find.text("Нет постов"), findsOneWidget);
    expect(find.byType(BaseButton), findsOneWidget);

    await widgetTester.tap(find.byType(BaseButton));
    verify(mockCubit.loadPosts()).called(1);
  });

  testWidgets('show post list and loader where has data', (tester) async {
    final posts = [
      Post(id: 1, title: 'First post', body: 'First post body'),
      Post(id: 2, title: 'Second post', body: 'Second post body'),
    ];

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: PostsList(posts: posts, isLoadingMore: true, isLoading: false),
        ),
      ),
    );

    expect(find.text('First post'), findsOneWidget);
    expect(find.text('Second post'), findsOneWidget);

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
