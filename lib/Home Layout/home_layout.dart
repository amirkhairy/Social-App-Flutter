import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Home%20Layout/PostScreen/add_post_screen.dart';
import 'package:social_app/Home%20Layout/home_cubit.dart';
import 'package:social_app/Home%20Layout/home_states.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is AddPostIndexState) {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  AddPostScreen(),
              ));
        }
      },
      builder: (context, state) {
        var cubit = HomeCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            surfaceTintColor: Colors.white,
            backgroundColor: Colors.white,
            title: Text(
              cubit.titles[cubit.currentIndex],
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.notifications_active_outlined,
                  size: 25,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.search_outlined,
                  size: 30,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            currentIndex: cubit.currentIndex,
            onTap: (value) {
              cubit.changeNavBar(value);
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                ),
                label: 'Chats',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_circle_rounded,
                ),
                label: 'Add Post',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.location_on_sharp,
                ),
                label: 'Users',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                ),
                label: 'Settings',
              ),
            ],
          ),
          body: ConditionalBuilder(
            condition: HomeCubit.get(context).userModel != null,
            builder: (context) {
              return cubit.screens[cubit.currentIndex];
            },
            fallback: (context) => const Center(
                child: CircularProgressIndicator(
              color: Colors.black,
            )),
          ),
        );
      },
    );
  }
}
