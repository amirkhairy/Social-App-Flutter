import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
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
              itemBuilder: (context, index) => buildPostItem(context),
              separatorBuilder: (context, index) => const SizedBox(
                height: 5,
              ),
              itemCount: 10,
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }
    Widget buildPostItem(context) => Card(
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
                  const CircleAvatar(
                    radius: 25,
                    backgroundImage: NetworkImage(
                      'https://img.freepik.com/free-photo/young-girl-model-standing-posing-white-gray_144627-58037.jpg?ga=GA1.1.79403536.1737118503&semt=ais_incoming',
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Amir Khairy',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          CircleAvatar(
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
                        'January 21, 2021 at 11:00 pm',
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
              const Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: Text(
                  'A definite article is an article that marks a definite noun phrase. Definite articles, such as the English the, are used to refer to a particular member of a group. It may be something that the speaker has already mentioned, or it may be otherwise something uniquely specified.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsetsDirectional.only(start: 8),
                child: Wrap(
                  spacing: 6,
                  children: [
                    SizedBox(
                      height: 20,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#Software',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                      child: MaterialButton(
                        onPressed: () {},
                        minWidth: 1.0,
                        padding: EdgeInsets.zero,
                        child: const Text(
                          '#Flutter',
                          style: TextStyle(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 160,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                  image: const DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      'https://img.freepik.com/free-photo/young-girl-model-blue-sweater-pointing-away-white-gray_144627-57854.jpg?t=st=1737119518~exp=1737123118~hmac=ef8ab9c9810bd13b16aac56e18156803eab2c4c61b3c1b5e49d95e16fc1d3ff1&w=740',
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
                              '120',
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
                              '120 comment',
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
                      child: const Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: NetworkImage(
                              'https://img.freepik.com/free-photo/young-girl-model-standing-posing-white-gray_144627-58037.jpg?ga=GA1.1.79403536.1737118503&semt=ais_incoming',
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
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
