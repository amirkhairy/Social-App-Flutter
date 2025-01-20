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
      emit(AddPostState());
    } else {
      currentIndex = index;
      emit(ChangeNavBarState());
    }
  }

  UserModel? userModel;
  void getUserData() {
    emit(GetUserDataLoadingState());
    Supabase.instance.client
        .from('users')
        .select()
        .eq('id_', CacheHelper.getData(key: 'uId'))
        .single()
        .then((response) {
      print(response.toString());
      userModel = UserModel.fromJson(response);
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(GetUserDataErrorState(error));
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
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  File? coverImage;
  Future<void> pickCoverImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.camera,
    );
    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      emit(CoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(CoverImagePickedErrorState());
    }
  }
}
