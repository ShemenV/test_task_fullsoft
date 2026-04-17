import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_task/features/core/core.dart';
import 'package:test_task/features/core/di/di.dart';
import 'package:test_task/features/posts/posts_list.dart';
// Обязательно импортируйте PostItem!
import 'package:test_task/features/posts/presentation/widgets/post_item.dart';
import 'package:test_task/posts_app.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(()  {
    configureDependencies();
  });

  testWidgets('app full test', (tester) async {
    await tester.pumpWidget(const PostsApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextFormField), "Sincere@april.biz");
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BaseButton));

    await tester.pump();

    bool isPostsLoaded = false;
    for (int i = 0; i < 20; i++) {
      await tester.pump(const Duration(milliseconds: 500));

      if (find.byType(PostItem).evaluate().isNotEmpty) {
        isPostsLoaded = true;
        break;
      }
    }

    expect(isPostsLoaded, isTrue, reason: 'Посты так и не загрузились');

    await tester.tap(find.byType(PostItem).first);
    await tester.pumpAndSettle();

    expect(find.text("Комментарии:"), findsOneWidget);
  });
}