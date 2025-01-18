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
      cover: 'https://img.freepik.com/free-photo/uneven-sandstone-tile-wall-surface_53876-88521.jpg?ga=GA1.1.79403536.1737118503&semt=ais_incoming',
      image: 'https://img.freepik.com/free-photo/aesthetic-dark-wallpaper-background-neon-light_53876-128291.jpg?t=st=1737208636~exp=1737212236~hmac=5ec034bdcf4f6a610b1a741ece26020690bf9957e4e946bd3e405991715df93b&w=740',
      bio: 'Write your bio...',
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
