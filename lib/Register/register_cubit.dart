import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Register/register_states.dart';

class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);
  bool passwrodObscureText = true;
  IconData? passwrodSuffixIcon = Icons.visibility;
  void changePasswordEye() {
    passwrodObscureText = !passwrodObscureText;
    if (passwrodObscureText == true) {
      passwrodSuffixIcon = Icons.visibility;
    } else {
      passwrodSuffixIcon = Icons.visibility_off;
    }
    emit(RegisterChangePasswordEyeState());
  }

  bool confirmPasswordObscureText = true;
  IconData? confirmPasswrodSuffixIcon = Icons.visibility;
  void changeConfirmPasswordEye() {
    confirmPasswordObscureText = !confirmPasswordObscureText;
    if (confirmPasswordObscureText == true) {
      confirmPasswrodSuffixIcon = Icons.visibility;
    } else {
      confirmPasswrodSuffixIcon = Icons.visibility_off;
    }
    emit(RegisterChangeConfirmPasswordEyeState());
  }

  void userRegister({
    required String email,
    required String password,
  }) {
    emit(UserRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email.toString());
      print(value.user?.uid.toString());
      emit(UserRegisterSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(UserRegisterErrorState());
    });
  }
}
