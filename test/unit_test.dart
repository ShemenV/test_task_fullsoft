import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'package:test_task/features/auth/data/data_sources/user_local_data_source.dart';
import 'package:test_task/features/auth/data/data_sources/user_remote_data_source.dart';
import 'package:test_task/features/auth/data/models/user_model/user_model.dart';
import 'package:test_task/features/auth/data/repositories/user_repository_impl.dart';
import 'package:test_task/features/auth/domain/domain.dart';
import 'package:test_task/features/core/exceptions/user_not_found_exception.dart';
import 'package:test_task/features/core/services/connectivity_service.dart';
import 'package:test_task/features/posts/data/data.dart';

import 'unit_test.mocks.dart';

@GenerateMocks([
  UserRemoteDataSource,
  UserLocalDataSource,
  ConnectivityService,
  PostsRemoteDataSource,
  PostsLocalDataSource,
])
void main() {
  late UserRepositoryImpl userRepository;
  late MockUserRemoteDataSource userRemote;
  late MockUserLocalDataSource userLocal;

  final mockUserModel = UserModel(
    id: 1,
    name: 'Test',
    email: 'test@email.ru',
    username: 'test_111',
  );

  late PostsRepositoryImpl postsRepository;
  late MockConnectivityService connectivityService;
  late MockPostsRemoteDataSource postsRemote;
  late MockPostsLocalDataSource postsLocal;

  final mockPage = 1;
  final mockModels = [
    PostModel(id: 1, title: "Mock Post", body: "Mock post description"),
  ];
  final mockEntities = mockModels.map((e) => e.toEntity()).toList();

  setUp(() {
    userRemote = MockUserRemoteDataSource();
    userLocal = MockUserLocalDataSource();
    userRepository = UserRepositoryImpl(userRemote, userLocal);

    connectivityService = MockConnectivityService();
    postsLocal = MockPostsLocalDataSource();
    postsRemote = MockPostsRemoteDataSource();
    postsRepository = PostsRepositoryImpl(
      postsRemoteDataSource: postsRemote,
      postsLocalDataSource: postsLocal,
      connectivityService: connectivityService,
    );
  });

  test('get user and save when found', () async {
    when(
      userRemote.getUserByEmail(email: "test@email.ru"),
    ).thenAnswer((_) async => mockUserModel);
    when(userLocal.saveUserId(1)).thenAnswer((_) async {});

    final result = await userRepository.getUserByEmail("test@email.ru");

    expect(result, isA<User>());
    expect(result.id, 1);

    verify(userLocal.saveUserId(1)).called(1);
  });

  test('throw UserNotFoundException when user not found', () async {
    when(
      userRemote.getUserByEmail(email: "wrong@email.ru"),
    ).thenAnswer((_) async => null);

    expect(
      () => userRepository.getUserByEmail("wrong@email.ru"),
      throwsA(isA<UserNotFoundException>()),
    );
  });

  test('get current user from storage', () async {
    when(userLocal.getUserId()).thenAnswer((_) async => 1);

    final result = await userRepository.getCurrentUserId();

    expect(result, 1);
  });
  
  test("get from remote, when online and save posts in local", () async {
    when(connectivityService.isOnline).thenAnswer((_) async => true);
    when(postsRemote.getPosts(page: mockPage)).thenAnswer((_) async => mockModels);
    when(postsLocal.savePosts(mockModels, mockPage)).thenAnswer((_) async => {});
    
    final result = await postsRepository.getPosts(mockPage);
    
    expect(result, equals(mockEntities));
    
    verify(postsRemote.getPosts(page: mockPage)).called(1);
    verify(postsLocal.savePosts(mockModels, mockPage)).called(1);
    
    verifyNever(postsLocal.getPosts(page: anyNamed("page")));
  });

  test("get from local, when offline", () async {
    when(connectivityService.isOnline).thenAnswer((_) async => false);
    when(postsLocal.getPosts(page: mockPage)).thenAnswer((_) async => mockModels);

    final result = await postsRepository.getPosts(mockPage);

    expect(result, equals(mockEntities));

    verify(postsLocal.getPosts(page: mockPage)).called(1);

    verifyNever(postsRemote.getPosts(page: anyNamed("page")));
    verifyNoMoreInteractions(postsRemote);
  });
}
