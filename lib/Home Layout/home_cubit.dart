import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/Components/cache_helper.dart';
import 'package:social_app/Home%20Layout/ChatScreen/chat_screen.dart';
import 'package:social_app/Home%20Layout/HomeScreen/home_screen.dart';
import 'package:social_app/Home%20Layout/PostScreen/add_post_screen.dart';
import 'package:social_app/Home%20Layout/SettingsScreen/settings_screen.dart';
import 'package:social_app/Home%20Layout/UsersScreen/users_screen.dart';
import 'package:social_app/Home%20Layout/home_states.dart';
import 'package:social_app/Models/post_model.dart';
import 'package:social_app/Models/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(HomeInitialState());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<String> titles = [
    'Home',
    'Chats',
    'Add new post',
    'Users',
    'Settings',
  ];

  List<Widget> screens = [
    HomeScreen(),
    ChatScreen(),
    AddPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  int currentIndex = 0;
  void changeNavBar(index) {
    if (index == 2) {
      emit(AddPostIndexState());
    } else {
      currentIndex = index;
      emit(ChangeNavBarState());
    }
  }

  UserModel? userModel;

  void getUserData() {
    final userId = CacheHelper.getData(key: 'uId');

    if (userId == null) {
      print('Error: User ID is null.');
      emit(GetUserDataErrorState('User ID is null.'));
      return;
    }

    emit(GetUserDataLoadingState());

    Supabase.instance.client
        .from('users')
        .select()
        .eq('id_', userId)
        .maybeSingle() // Handles no rows gracefully
        .then((response) {
      if (response == null) {
        print('No user data found for ID: $userId');
        emit(GetUserDataErrorState('No user data found.'));
      } else {
        print('User data retrieved: $response');
        userModel = UserModel.fromJson(response);
        emit(GetUserDataSuccessState());
      }
    }).catchError((error) {
      print('Error retrieving user data: $error');
      emit(GetUserDataErrorState(error.toString()));
    });
  }

  // with firebase
  // UserModel? userModel;
  // void getUserData() {
  //   emit(GetUserDataLoadingState());
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(CacheHelper.getData(key: 'uId'))
  //       .get()
  //       .then((value) {
  //     print(value.data());
  // userModel = UserModel.fromJson(value.data() ?? {});
  //     emit(GetUserDataSuccessState());
  //   }).catchError((error) {
  //     print(error.toString());
  //     emit(GetUserDataErrorState(error));
  //   });
  // }

  File? profileImage;
  var picker = ImagePicker();
  Future<void> pickProfileImage() async {
    emit(ProfileImagePickedLoadingState());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(profileImage);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> pickCoverImage() async {
    emit(CoverImagePickedLoadingState());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(coverImage);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImagePickedErrorState());
    }
  }

  File? postImage;
  Future<void> pickpostImage() async {
    emit(PostImagePickedLoadingState());
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      postImage = File(pickedFile.path);
      print(postImage);
      emit(PostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(PostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(PostImageRemovedState()); // Emit a new state to notify the UI
  }

  Future<String?> updateProfileImage({
    required String uId,
    File? profileImage,
  }) async {
    try {
      if (profileImage == null) {
        print("No profile image provided.");
        return null;
      }

      emit(UpdateProfileImageLoadingState());

      final supabase = Supabase.instance.client;
      String? profileImageUrl;

      // Set a unique file name (you can use a timestamp or UUID)
      final fileName =
          '$uId/profile-${DateTime.now().millisecondsSinceEpoch}.jpg'; // Add timestamp to avoid conflicts

      // Check if the profile image already exists
      final existingProfileImage =
          await supabase.storage.from('profile-images').list();

      // Check if the image already exists with the same name
      bool imageExists =
          existingProfileImage.any((file) => file.name == '$uId/profile.jpg');

      if (imageExists) {
        print("Profile image exists, attempting to delete the old one...");
        final removeResponse = await supabase.storage
            .from('profile-images')
            .remove(['$uId/profile.jpg']);

        // Check if any files were deleted
        if (removeResponse.isEmpty) {
          getUserData();
          print('No existing profile image found to delete.');
        } else {
          getUserData();
          print('Existing profile image deleted successfully.');
        }
        getUserData();
      }

      // Upload the new profile image
      final uploadResponse = await supabase.storage
          .from('profile-images')
          .upload(fileName, profileImage);

      // If the upload is successful, it returns a string (file path)
      if (uploadResponse is String) {
        profileImageUrl =
            supabase.storage.from('profile-images').getPublicUrl(fileName);
        print('Profile Image URL: $profileImageUrl');

        // Update the user record in the database with the new profile image URL
        final response = await supabase.from('users').update({
          'image':
              profileImageUrl, // Update the profile image URL in the 'image' field
        }).eq('id_', uId);

        if (response.error != null) {
          print(
              'Error updating profile image URL in the database: ${response.error?.message}');
          getUserData();
          throw Exception('Error updating profile image URL in the database.');
        }

        print('Profile image URL updated in the database successfully.');
        emit(UpdateProfileImageSuccessState());
        getUserData();
        return profileImageUrl;
      } else {
        getUserData();
        // If the upload failed, handle the error
        throw Exception('Error uploading profile image');
      }
    } catch (e) {
      print('Error: $e');
      getUserData();
      emit(UpdateProfileImageErrorState());
    }
  }

  Future<String?> updateCoverImage({
    required String uId,
    File? coverImage,
  }) async {
    try {
      if (coverImage == null) {
        print("No cover image provided.");
        return null;
      }

      emit(UpdateCoverImageLoadingState());

      final supabase = Supabase.instance.client;
      String? coverImageUrl;

      // Set a unique file name (you can use a timestamp or UUID)
      final fileName =
          '$uId/cover-${DateTime.now().millisecondsSinceEpoch}.jpg'; // Add timestamp to avoid conflicts

      // Check if the cover image already exists
      final existingCoverImage =
          await supabase.storage.from('cover-images').list();

      // Check if the image already exists with the same name
      bool coverImageExists =
          existingCoverImage.any((file) => file.name == '$uId/cover.jpg');

      if (coverImageExists) {
        print("Cover image exists, attempting to delete the old one...");
        final removeResponse = await supabase.storage
            .from('cover-images')
            .remove(['$uId/cover.jpg']);

        // Check if any files were deleted
        if (removeResponse.isEmpty) {
          getUserData();
          print('No existing cover image found to delete.');
        } else {
          getUserData();
          print('Existing cover image deleted successfully.');
        }
      }

      // Upload the new cover image
      final uploadResponse = await supabase.storage
          .from('cover-images')
          .upload(fileName, coverImage);

      // If the upload is successful, it returns a string (file path)
      if (uploadResponse is String) {
        coverImageUrl =
            supabase.storage.from('cover-images').getPublicUrl(fileName);
        print('Cover Image URL: $coverImageUrl');

        // Update the user record in the database with the new cover image URL
        final response = await supabase.from('users').update({
          'cover':
              coverImageUrl, // Update the cover image URL in the 'cover' field
        }).eq('id_', uId);

        if (response.error != null) {
          print(
              'Error updating cover image URL in the database: ${response.error?.message}');
          getUserData();
          throw Exception('Error updating cover image URL in the database.');
        }

        print('Cover image URL updated in the database successfully.');
        emit(UpdateCoverImageSuccessState());
        getUserData();
        return coverImageUrl;
      } else {
        getUserData();
        // If the upload failed, handle the error
        throw Exception('Error uploading cover image');
      }
    } catch (e) {
      print('Error: $e');
      getUserData();
      emit(UpdateCoverImageErrorState());
    }
  }

  Future<void> updateUserData({
    required String uId,
    required String name,
    required String phone,
    required String bio,
  }) async {
    try {
      final supabase = Supabase.instance.client;

      final response = await supabase.from('users').update({
        'name': name,
        'phone': phone,
        'bio': bio,
      }).eq('id_', uId);

      // Handle if response.error exists (though unlikely if data is updated)
      if (response.error != null) {
        print('Error updating profile: ${response.error?.message}');
        emit(UpdateProfileDataErrorState());
        getUserData();
        throw Exception(
            'Error updating profile: ${response.error?.message ?? "Unknown error"}');
      }

      // If the response.data is null or empty, this means the data was not actually updated
      if (response.data == null || response.data.isEmpty) {
        print('No changes were made to the profile.');
        emit(UpdateProfileDataErrorState());
        getUserData();
        throw Exception('No changes made to the profile.');
      }

      // Success case where data is updated
      print('Profile updated successfully!');
      emit(UpdateProfileDataSuccessState());
      getUserData();
    } catch (e) {
      // Catch any error or unexpected response and print it
      print('Catch Error: $e');
      emit(UpdateProfileDataErrorState());
      getUserData();
    }
  }

  PostModel? postModel;
  Future<PostModel?> addPost({
    required UserModel user, // Pass the UserModel directly
    String? date,
    required String text,
  }) async {
    try {
      emit(AddPostLoadingState());
      final supabase = Supabase.instance.client;

      String? postImageUrl;

      // If there's an image to upload
      if (postImage != null) {
        final fileName =
            '${user.uId}/post-${DateTime.now().millisecondsSinceEpoch}.jpg';
        final uploadResponse = await supabase.storage
            .from('post-images') // Your storage bucket name
            .upload(fileName, postImage!);

        if (uploadResponse is String) {
          postImageUrl =
              supabase.storage.from('post-images').getPublicUrl(fileName);
          print("Post image uploaded successfully: $postImageUrl");
        } else {
          throw Exception("Error uploading post image");
        }
      }

      // Insert post data into the database
      final response = await supabase.from('posts').insert({
        'uId': user.uId,
        'profileName': user.name,
        'profileImage': user.image,
        'date': date ??
            DateTime.now()
                .toIso8601String(), // Use current date if not provided
        'text': text,
        'postImage':
            postImageUrl ?? '', // Use the uploaded image URL or leave empty
      }).select();

      // Convert the response to a Post model
      if (response != null && response.isNotEmpty) {
        final post =
            PostModel.fromJson(response.first); // Assuming `Post` model exists
        print("Post added successfully: ${post.toMap()}");
        emit(AddPostSuccessState());
        return post; // Return the created Post object
      } else {
        throw Exception("Failed to add post");
      }
    } catch (error) {
      print("Error adding post: $error");
      emit(AddPostErrorState());
      return null;
    }
  }
}
