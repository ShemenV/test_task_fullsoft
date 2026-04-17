import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:test_task/features/core/services/connectivity_service.dart';

@injectable
class ConnectivityCubit extends Cubit<bool> {
  final ConnectivityService connectivityService;

  StreamSubscription<bool>? _subscription;

  ConnectivityCubit({required this.connectivityService}) : super(true) {
    _init();
  }

  void _init() async {
    emit(await connectivityService.isOnline);

    _subscription = connectivityService.onConnectivityChanged.listen((event) {
      print(event);
      emit(event);
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
