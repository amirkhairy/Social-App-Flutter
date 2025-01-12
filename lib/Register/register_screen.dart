import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/components.dart';
import 'package:social_app/Login/login_screen.dart';
import 'package:social_app/Register/register_cubit.dart';
import 'package:social_app/Register/register_states.dart';
import 'package:social_app/constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              surfaceTintColor: Colors.white,
            ),
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/flutter.png',
                            fit: BoxFit.cover,
                            height: 180,
                          ),
                        ),
                        const Text(
                          'Email',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: emailController,
                          hintText: 'example@gmail.com',
                          prefixIcon: Icons.email,
                          keyboardType: TextInputType.emailAddress,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            }
                            return null;
                          },
                          onFieldSubmitted: (value) {},
                          thereSuffixIcon: false,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Password',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: passwordController,
                          hintText: '123456',
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.passwrodObscureText,
                          thereSuffixIcon: true,
                          suffixIcon: cubit.passwrodSuffixIcon,
                          onSuffixIconTap: () {
                            cubit.changePasswordEye();
                          },
                          onFieldSubmitted: (value) {
                            if (_formKey.currentState!.validate()) {}
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          'Confirm Password',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: confirmPasswordController,
                          hintText: '123456',
                          prefixIcon: Icons.lock,
                          keyboardType: TextInputType.visiblePassword,
                          obscureText: cubit.confirmPasswordObscureText,
                          thereSuffixIcon: true,
                          suffixIcon: cubit.confirmPasswrodSuffixIcon,
                          onSuffixIconTap: () {
                            cubit.changeConfirmPasswordEye();
                          },
                          onFieldSubmitted: (value) {
                            if (_formKey.currentState!.validate()) {}
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (value != passwordController.text) {
                              return 'Not the same password';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: SizedBox(
                            width: screenWidth(context),
                            height: 60,
                            child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  cubit.userRegister(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  );
                                }
                              },
                              style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.black),
                              ),
                              child: state is! UserRegisterLoadingState
                                  ? const Text(
                                      'Sign Up',
                                      style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 25,
                                        color: Colors.white,
                                      ),
                                    )
                                  : const CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
