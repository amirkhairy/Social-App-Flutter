abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataSuccessState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {
  final String error;

  GetUserDataErrorState(this.error);
}
