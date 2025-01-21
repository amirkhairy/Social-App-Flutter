import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Home%20Layout/home_cubit.dart';
import 'package:social_app/Home%20Layout/home_states.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var nameController = TextEditingController();
    var bioController = TextEditingController();
    var phoneController = TextEditingController();
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = HomeCubit.get(context).userModel;
        var profileImage = HomeCubit.get(context).profileImage;
        var coverImage = HomeCubit.get(context).coverImage;
        nameController.text = userModel!.name!;
        bioController.text = userModel.bio!;
        phoneController.text = userModel.phone!;
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            titleSpacing: 5.0,
            title: const Text(
              'Edit Profile',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 200,
                      width: double.infinity,
                      child: Stack(
                        children: [
                          Stack(
                            alignment: AlignmentDirectional.topEnd,
                            children: [
                              Container(
                                height: 160,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                  ),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: coverImage == null
                                        ? NetworkImage(
                                            '${userModel.cover}',
                                          )
                                        : FileImage(coverImage),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundColor: Colors.blue,
                                  foregroundColor: Colors.white,
                                  child: IconButton(
                                    onPressed: () {
                                      HomeCubit.get(context).pickCoverImage();
                                    },
                                    icon: const Icon(
                                      Icons.add_a_photo,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                  radius: 62,
                                  child: CircleAvatar(
                                    radius: 60,
                                    backgroundImage: profileImage == null
                                        ? NetworkImage(
                                            '${userModel.image}',
                                          )
                                        : FileImage(profileImage),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CircleAvatar(
                                    radius: 18,
                                    backgroundColor: Colors.blue,
                                    foregroundColor: Colors.white,
                                    child: IconButton(
                                      onPressed: () {
                                        HomeCubit.get(context)
                                            .pickProfileImage();
                                      },
                                      icon: const Icon(
                                        Icons.add_a_photo,
                                        size: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (state is ProfileImagePickedSuccessState ||
                        state is CoverImagePickedSuccessState)
                      const SizedBox(
                        height: 20,
                      ),
                    Row(
                      children: [
                        if (state is ProfileImagePickedSuccessState)
                          Expanded(
                            child: OutlinedButton(
                              style: ButtonStyle(
                                overlayColor: WidgetStatePropertyAll(
                                  Colors.grey[300],
                                ),
                                side: WidgetStateProperty.all(
                                  BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                foregroundColor: const WidgetStatePropertyAll(
                                  Colors.blue,
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                HomeCubit.get(context).updateProfileImage(
                                  uId: userModel.uId!,
                                  profileImage: profileImage,
                                );
                              },
                              child: const Text('Update Profile Image'),
                            ),
                          ),
                        const SizedBox(
                          width: 10,
                        ),
                        if (state is CoverImagePickedSuccessState)
                          Expanded(
                            child: OutlinedButton(
                              style: ButtonStyle(
                                overlayColor: WidgetStatePropertyAll(
                                  Colors.grey[300],
                                ),
                                side: WidgetStateProperty.all(
                                  BorderSide(
                                    color: Colors.grey[300]!,
                                  ),
                                ),
                                foregroundColor: const WidgetStatePropertyAll(
                                  Colors.blue,
                                ),
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                HomeCubit.get(context).updateCoverImage(
                                  uId: userModel.uId!,
                                  coverImage: coverImage,
                                );
                              },
                              child: const Text('Update Cover Image'),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: nameController,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                        labelText: 'Name',
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.person_2_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Name must be not empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: bioController,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                        labelText: 'Bio',
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.info_outline,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Bio must be not empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: phoneController,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                        labelText: 'Phone Number',
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        prefixIcon: const Icon(
                          Icons.call_outlined,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Phone Number must be not empty';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            style: ButtonStyle(
                              overlayColor: WidgetStatePropertyAll(
                                Colors.grey[300],
                              ),
                              side: WidgetStateProperty.all(
                                BorderSide(
                                  color: Colors.grey[300]!,
                                ),
                              ),
                              foregroundColor: const WidgetStatePropertyAll(
                                Colors.blue,
                              ),
                              shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              HomeCubit.get(context).updateUserData(
                                uId: userModel.uId!,
                                name: nameController.text,
                                phone: phoneController.text,
                                bio: bioController.text,
                              );
                            },
                            child: const Text('Update User Informations'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
