abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class AddPostState extends HomeStates {}

class ChangeNavBarState extends HomeStates {}

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class GetUserDataSuccessState extends HomeStates {}

class ProfileImagePickedSuccessState extends HomeStates {}

class ProfileImagePickedErrorState extends HomeStates {}

class CoverImagePickedSuccessState extends HomeStates {}

class CoverImagePickedErrorState extends HomeStates {}

class UpdateProfileImageSuccessState extends HomeStates {}

class UpdateProfileImageLoadingState extends HomeStates {}

class UpdateProfileImageErrorState extends HomeStates {}

class UpdateCoverImageSuccessState extends HomeStates {}

class UpdateCoverImageLoadingState extends HomeStates {}

class UpdateCoverImageErrorState extends HomeStates {}

class UpdateProfileDataErrorState extends HomeStates {}

class UpdateProfileDataLoadingState extends HomeStates {}

class UpdateProfileDataSuccessState extends HomeStates {}
