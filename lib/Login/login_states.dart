abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginChangeEyeState extends LoginStates {}

class UserLoginLoadingState extends LoginStates {}

class UserLoginErrorState extends LoginStates {}

class UserLoginSuccessState extends LoginStates {}
