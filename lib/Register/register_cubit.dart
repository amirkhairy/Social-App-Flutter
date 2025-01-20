import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Login/login_screen.dart';
import 'package:social_app/Models/user_model.dart';
import 'package:social_app/Register/register_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

// with supabase
  void userRegister({
    required BuildContext context,
    required String email,
    required String password,
    required String userName,
    required String phoneNumber,
  }) async {
    emit(UserRegisterLoadingState());

    final supabase = Supabase.instance.client;

    try {
      // Attempt to sign up the user
      final response = await supabase.auth.signUp(
        email: email,
        password: password,
      );

      // Check if the response contains a user
      if (response.user != null) {
        print(response.user!.email);
        print(response.user!.id);

        // Call the userCreate method to save the user's details in your database
        userCreate(
          context: context,
          email: email,
          name: userName,
          phone: phoneNumber,
          uId: response.user!.id,
        );
        // Emit success state
        emit(UserRegisterSuccessState());
      } else {
        // Handle unexpected case if `response.user` is null
        print('User registration failed: Unknown error.');
        emit(UserRegisterErrorState());
      }
    } catch (error) {
      // Catch and handle any error during registration process

      // Check if the error is related to the email already being registered
      if (error is AuthException &&
          error.message == 'User already registered') {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("User already registered"),
              content: Text(
                  "This Email is already exists try register with another email."),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        emit(UserRegisterErrorState());

        // Optionally, attempt to sign the user in automatically if the email already exists
      } else {
        // Catch other exceptions
        print("Error occurred during user registration: $error");
        emit(UserRegisterErrorState());
      }
    }
  }

// with firebase
  // void userRegister({
  //   required String email,
  //   required String password,
  //   required String userName,
  //   required String phoneNumber,
  // }) {
  //   emit(UserRegisterLoadingState());
  //   FirebaseAuth.instance
  //       .createUserWithEmailAndPassword(email: email, password: password)
  //       .then((value) {
  //     print(value.user?.email.toString());
  //     print(value.user?.uid.toString());
  //     userCreate(
  //       email: email,
  //       name: userName,
  //       phone: phoneNumber,
  //       uId: value.user!.uid,
  //     );
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(UserRegisterErrorState());
  //   });
  // }

// with supabase
  void userCreate({
    required BuildContext context,
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    emit(CreateUserLoadingState());

    final supabase = Supabase.instance.client;

    UserModel userModel = UserModel(
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      cover:
          'https://img.freepik.com/free-photo/uneven-sandstone-tile-wall-surface_53876-88521.jpg?ga=GA1.1.79403536.1737118503&semt=ais_incoming',
      image:
          'https://img.freepik.com/free-photo/aesthetic-dark-wallpaper-background-neon-light_53876-128291.jpg?t=st=1737208636~exp=1737212236~hmac=5ec034bdcf4f6a610b1a741ece26020690bf9957e4e946bd3e405991715df93b&w=740',
      bio: 'Write your bio...',
    );

    supabase
        .from(
            'users') // Ensure the `users` table exists in your Supabase database
        .insert(userModel.toMap())
        .then((response) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ),
        (route) => false,
      );

      if (response != null) {
        // Check if the response has data or error
        if (response.error == null) {
          if (response.data != null && response.data.isNotEmpty) {
            emit(CreateUserSuccessState());
          } else {
            print('No data returned or inserted.');
            emit(CreateUserErrorState('No data returned or inserted.'));
          }
        } else {
          print('Error: ${response.error?.message}');
          emit(
              CreateUserErrorState(response.error?.message ?? 'Unknown error'));
        }
      } else {
        print('Response is null.');
        emit(CreateUserErrorState('Response is null.'));
      }
    }).catchError((error) {
      print('Error occurred: $error');
      emit(CreateUserErrorState(error.toString()));
    });
  }

// with firebase
  // void userCreate({
  //   required String email,
  //   required String name,
  //   required String phone,
  //   required String uId,
  // }) {
  //   UserModel userModel = UserModel(
  //     email: email,
  //     name: name,
  //     phone: phone,
  //     uId: uId,
  //     cover:
  //         'https://img.freepik.com/free-photo/uneven-sandstone-tile-wall-surface_53876-88521.jpg?ga=GA1.1.79403536.1737118503&semt=ais_incoming',
  //     image:
  //         'https://img.freepik.com/free-photo/aesthetic-dark-wallpaper-background-neon-light_53876-128291.jpg?t=st=1737208636~exp=1737212236~hmac=5ec034bdcf4f6a610b1a741ece26020690bf9957e4e946bd3e405991715df93b&w=740',
  //     bio: 'Write your bio...',
  //   );
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uId)
  //       .set(userModel.toMap())
  //       .then((value) {
  //     emit(CreateUserSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(CreateUserErrorState(error.toString()));
  //   });
  // }
}
