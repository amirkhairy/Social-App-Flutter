import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/cache_helper.dart';
import 'package:social_app/Home%20Layout/home_cubit.dart';
import 'package:social_app/Home%20Layout/home_layout.dart';
import 'package:social_app/Login/login_states.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

// with supapase
  void userLogin({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    emit(UserLoginLoadingState());

    final supabase = Supabase.instance.client;

    try {
      // Attempt to sign in with the provided email and password
      final response = await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Check if the login was successful
      if (response.user != null) {
        print('Login Success');
        print(response.user?.email);
        print(response.user?.id);
        CacheHelper.setData(key: 'uId', value: response.user?.id);
        emit(UserLoginSuccessState());
      } else {
        // Handle case where the user is not found (unexpected case)
        print('Login failed: User not found.');
        emit(UserLoginErrorState());
      }
    } catch (error) {
      // Handle login failure
      print(error.toString());

      // Check if the error is an instance of AuthException
      if (error is AuthException) {
        // Check for invalid credentials error
        if (error.message == 'Invalid login credentials') {
          // Show a dialog for incorrect email or password
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content: const Text(
                    'The email or password you entered is incorrect. Please try again.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          // Handle other AuthException errors
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Login Failed'),
                content: const Text(
                    'An error occurred while logging in. Please try again later.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Close the dialog
                    },
                    child: const Text('OK'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        // Handle non-AuthException errors (e.g., network issues)
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Login Failed'),
              content: const Text(
                  'An error occurred while logging in. Please try again later.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }

      emit(UserLoginErrorState());
    }
  }

// with firebase
  // void userLogin({
  //   required String email,
  //   required String password,
  // }) {
  //   emit(UserLoginLoadingState());
  //   FirebaseAuth.instance
  //       .signInWithEmailAndPassword(email: email, password: password)
  //       .then((value) {
  //     print(value.user?.email);
  //     print(value.user?.uid);
  //     CacheHelper.setData(
  //       key: 'uId',
  //       value: value.user?.uid,
  //     );
  //     emit(UserLoginSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(UserLoginErrorState());
  //   });
  // }
}
