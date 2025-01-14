import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Models/user_model.dart';
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
    required String userName,
    required String phoneNumber,
  }) {
    emit(UserRegisterLoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user?.email.toString());
      print(value.user?.uid.toString());
      userCreate(
        email: email,
        name: userName,
        phone: phoneNumber,
        uId: value.user!.uid,
      );
    }).catchError((error) {
      print(error.toString());
      emit(UserRegisterErrorState());
    });
  }

  void userCreate({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    UserModel userModel = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(userModel.toMap())
        .then((value) {
      emit(CreateUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(CreateUserErrorState(error.toString()));
    });
  }
}
