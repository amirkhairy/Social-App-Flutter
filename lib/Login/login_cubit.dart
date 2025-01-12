import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Login/login_states.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);

  bool obscureText = true;
  IconData? suffixIcon = Icons.visibility;
  void changePasswordEye() {
    obscureText = !obscureText;
    if (obscureText == true) {
      suffixIcon = Icons.visibility;
    } else {
      suffixIcon = Icons.visibility_off;
    }
    emit(LoginChangeEyeState());
  }
}
