import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Components/components.dart';
import 'package:social_app/Home%20Layout/home_layout.dart';
import 'package:social_app/Login/login_screen.dart';
import 'package:social_app/Register/register_cubit.dart';
import 'package:social_app/Register/register_states.dart';
import 'package:social_app/constants.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var userNameController = TextEditingController();
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateUserSuccessState) {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => HomeLayout(),
              ),
              (route) => false,
            );
          }
        },
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
                          'User Name',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: userNameController,
                          hintText: 'Amir Khairy',
                          prefixIcon: Icons.person,
                          keyboardType: TextInputType.name,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your user name';
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
                          'Phone Number',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          controller: phoneNumberController,
                          hintText: '01032078026',
                          prefixIcon: Icons.phone,
                          keyboardType: TextInputType.phone,
                          obscureText: false,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your phone number';
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
                                    context: context,
                                    email: emailController.text,
                                    password: passwordController.text,
                                    userName: userNameController.text,
                                    phoneNumber: phoneNumberController.text,
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
