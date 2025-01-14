abstract class RegisterStates {}

class RegisterInitialState extends RegisterStates {}

class RegisterChangePasswordEyeState extends RegisterStates {}

class RegisterChangeConfirmPasswordEyeState extends RegisterStates {}

class UserRegisterLoadingState extends RegisterStates {}

class UserRegisterErrorState extends RegisterStates {}

class UserRegisterSuccessState extends RegisterStates {}

class CreateUserLoadingState extends RegisterStates {}

class CreateUserErrorState extends RegisterStates {
  final String error;

  CreateUserErrorState(this.error);
}

class CreateUserSuccessState extends RegisterStates {}
