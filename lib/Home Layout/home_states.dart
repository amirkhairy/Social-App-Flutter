abstract class HomeStates {}

class HomeInitialState extends HomeStates {}

class AddPostIndexState extends HomeStates {}

class ChangeNavBarState extends HomeStates {}

class GetUserDataLoadingState extends HomeStates {}

class GetUserDataErrorState extends HomeStates {
  final String error;

  GetUserDataErrorState(this.error);
}

class GetUserDataSuccessState extends HomeStates {}

class ProfileImagePickedLoadingState extends HomeStates {}

class ProfileImagePickedSuccessState extends HomeStates {}

class ProfileImagePickedErrorState extends HomeStates {}

class CoverImagePickedLoadingState extends HomeStates {}

class CoverImagePickedSuccessState extends HomeStates {}

class CoverImagePickedErrorState extends HomeStates {}

class PostImagePickedErrorState extends HomeStates {}

class PostImagePickedLoadingState extends HomeStates {}

class PostImagePickedSuccessState extends HomeStates {}

class PostPickedErrorState extends HomeStates {}

class UpdateProfileImageSuccessState extends HomeStates {}

class UpdateProfileImageLoadingState extends HomeStates {}

class UpdateProfileImageErrorState extends HomeStates {}

class UpdateCoverImageSuccessState extends HomeStates {}

class UpdateCoverImageLoadingState extends HomeStates {}

class UpdateCoverImageErrorState extends HomeStates {}

class UpdateProfileDataErrorState extends HomeStates {}

class UpdateProfileDataLoadingState extends HomeStates {}

class UpdateProfileDataSuccessState extends HomeStates {}

class AddPostErrorState extends HomeStates {}

class AddPostLoadingState extends HomeStates {}

class AddPostSuccessState extends HomeStates {}

class PostImageRemovedState extends HomeStates {}

class GetPostsLoadingState extends HomeStates {}

class GetPostsErrorState extends HomeStates {
  final String error;

  GetPostsErrorState(this.error);
}

class GetPostsSuccessState extends HomeStates {}
