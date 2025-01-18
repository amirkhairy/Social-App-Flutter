import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class AddPostScreen extends StatelessWidget {
  const AddPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
      children: [
        Center(
          child: Text(
            'Add Post Screen',
          ),
        ),
      ],
    ),
    );
  }
}