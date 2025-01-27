import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/Home%20Layout/home_cubit.dart';
import 'package:social_app/Home%20Layout/home_states.dart';
import 'package:social_app/Models/post_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {},
      builder: (context, state) {
        
        return ConditionalBuilder(
          condition: HomeCubit.get(context).posts.isNotEmpty,
          builder: (context) => SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  Card(
                    elevation: 5,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: const SizedBox(
                        height: 250,
                        child: Stack(
                          alignment: Alignment.topLeft,
                          children: [
                            Image(
                              width: double.infinity,
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                  'https://img.freepik.com/free-photo/young-girl-model-blue-sweater-pointing-away-white-gray_144627-57854.jpg?t=st=1737119518~exp=1737123118~hmac=ef8ab9c9810bd13b16aac56e18156803eab2c4c61b3c1b5e49d95e16fc1d3ff1&w=740'),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 2),
                              child: Text(
                                'Communicate with your friends',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) => buildPostItem(
                      context,
                      HomeCubit.get(context).posts[index],
                    ),
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 5,
                    ),
                    itemCount: HomeCubit.get(context).posts.length,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ),
          fallback: (context) => const Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ),
          ),
        );
      },
    );
  }

  Widget buildPostItem(context, PostModel model) => Card(
        color: Colors.white,
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      model.profileImage!,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            model.profileName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const CircleAvatar(
                            radius: 6,
                            backgroundColor: Colors.blue,
                            child: Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 10,
                            ),
                          )
                        ],
                      ),
                      Text(
                        model.date!,
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.more_horiz,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Text(
                  model.text!,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              // Container(
              //   width: double.infinity,
              //   padding: const EdgeInsetsDirectional.only(start: 8),
              //   child: Wrap(
              //     spacing: 6,
              //     children: [
              //       SizedBox(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1.0,
              //           padding: EdgeInsets.zero,
              //           child: const Text(
              //             '#Software',
              //             style: TextStyle(
              //               color: Colors.blue,
              //             ),
              //           ),
              //         ),
              //       ),
              //       SizedBox(
              //         height: 20,
              //         child: MaterialButton(
              //           onPressed: () {},
              //           minWidth: 1.0,
              //           padding: EdgeInsets.zero,
              //           child: const Text(
              //             '#Flutter',
              //             style: TextStyle(
              //               color: Colors.blue,
              //             ),
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              if (model.postImage != '')
                Container(
                  height: 160,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      5,
                    ),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(
                        model.postImage!,
                      ),
                    ),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 15,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: const Row(
                          children: [
                            Icon(
                              Icons.favorite_border_outlined,
                              color: Colors.red,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.chat_sharp,
                              color: Colors.amber,
                              size: 20,
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              '0 comment',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              HomeCubit.get(context).userModel!.image!,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            'Write a comment...',
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: const Row(
                        children: [
                          Icon(
                            Icons.favorite_border_outlined,
                            color: Colors.red,
                            size: 20,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Like',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
