import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:test_task/features/auth/presentation/state/auth_cubit.dart';
import 'package:test_task/features/auth/presentation/state/auth_state.dart';
import 'package:test_task/features/core/core.dart';
import 'package:test_task/features/core/di/di.dart';
import 'package:test_task/features/core/router/router_consts.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: BlocProvider(
              create: (BuildContext context) => getIt<AuthCubit>(),
              child: BlocListener<AuthCubit, AuthState>(
                listener: (BuildContext context, state) {
                  if (state.isAuthenticated) {
                    context.pushReplacementNamed(postsList);
                  }

                  if (state.errorMessage != null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red,
                        content: Text(
                          state.errorMessage!,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
                child: BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: TextFormField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              hintText: "Введите email",
                            ),
                            onChanged: (value) {
                              context.read<AuthCubit>().updateEmail(value);
                            },
                          ),
                        ),
                        BaseButton(
                          isLoading: state.isLoading,
                          onTap: () {
                            context.read<AuthCubit>().login();
                          },
                          text: 'Войти',
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
