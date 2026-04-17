import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/connectivity/presentation/presentation.dart';
import 'package:test_task/features/core/core.dart';
import 'package:test_task/features/core/di/di.dart';
import 'package:test_task/features/core/router/router.dart';
import 'package:test_task/features/core/services/connectivity_service.dart';

import 'features/auth/auth.dart';
import 'features/core/theme/theme.dart';

class PostsApp extends StatefulWidget {
  const PostsApp({super.key});

  @override
  State<PostsApp> createState() => _PostsAppState();
}

class _PostsAppState extends State<PostsApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => getIt<ConnectivityCubit>()),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: themeData,
        routerConfig: router,

        builder: (context, child) {
          return GlobalOverlayWrapper(child: child!);
        },
      ),
    );
  }
}
