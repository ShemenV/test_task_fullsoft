import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_task/features/connectivity/presentation/presentation.dart';

class GlobalOverlayWrapper extends StatelessWidget {
  final Widget child;
  const GlobalOverlayWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        BlocBuilder<ConnectivityCubit, bool>(
          builder: (context, isOnline) {
            if (isOnline) return const SizedBox.shrink();

            return const Positioned(
              top: 120,
              right: 20,
              child: ConnectivityIndicator(),
            );
          },
        ),
      ],
    );
  }
}
