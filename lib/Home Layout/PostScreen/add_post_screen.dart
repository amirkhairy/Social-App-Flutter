import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Home%20Layout/home_cubit.dart';
import 'package:social_app/Home%20Layout/home_layout.dart';
import 'package:social_app/Home%20Layout/home_states.dart';

class AddPostScreen extends StatelessWidget {
  AddPostScreen({super.key});
  var textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is AddPostSuccessState) {
          HomeCubit.get(context).changeNavBar(0);
          HomeCubit.get(context).removePostImage();

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
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text(
              'Create Post',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 22,
              ),
            ),
            titleSpacing: 0,
            actions: [
              TextButton(
                onPressed: () {
                  if (HomeCubit.get(context).postImage == null &&
                      textController.text.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('???'),
                          content: Text('Write something...'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    HomeCubit.get(context).addPost(
                      user: HomeCubit.get(context).userModel!,
                      text: textController.text,
                    );
                  }
                },
                child: state is! AddPostLoadingState
                    ? Text(
                        'Post',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                          color: Colors.blue,
                        ),
                      )
                    : CircularProgressIndicator(
                        color: Colors.blue,
                      ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                // Content at the top of the screen
                Expanded(
                  child: SingleChildScrollView(
                    physics: BouncingScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                HomeCubit.get(context).userModel!.image!,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              HomeCubit.get(context).userModel!.name!,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          maxLines: 20,
                          controller: textController,
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                            hintText: 'Write what you want... ',
                            hintStyle: TextStyle(
                              fontWeight: FontWeight.w800,
                              color: Colors.grey,
                            ),
                            border: UnderlineInputBorder(
                                borderSide: BorderSide.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                // Buttons at the bottom of the screen
                if (HomeCubit.get(context).postImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        height: 180,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(HomeCubit.get(context).postImage!),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          HomeCubit.get(context).removePostImage();
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          HomeCubit.get(context).pickpostImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.photo,
                              color: Colors.blue,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Add Photo',
                              style: TextStyle(
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          '# Logs',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
