import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:task_todo/data/storage_repostory.dart';
import 'package:task_todo/model/auth.dart';
import 'package:task_todo/model/login_model.dart';
import 'package:task_todo/repositories/auth_repository.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({required this.authRepository}) : super(AuthInitial());

  final AuthRepository authRepository;

  Future<void> loginUser({required LoginModel loginModel}) async {
    emit(AuthLoadingState());
    AuthenticationModel authenticationModel =
        await authRepository.loginUser(loginModel: loginModel);
    if (authenticationModel.access.isNotEmpty) {
      await StorageRepository.putString("TOKEN", authenticationModel.access);

      emit(AuthLoggedState());
      emit(AuthSendCodeSuccessState());
    } else {
      emit(AuthErrorState(errorText: 'bunday login topilmadi'));
    }
  }

  updateState() {
    emit(AuthInitial());
  }
}
