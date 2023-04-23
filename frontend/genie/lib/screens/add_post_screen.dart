import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:genie/utils/colors.dart';
import 'package:genie/widgets/text_input.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final TextEditingController _postController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Text('Discard'),
                  ),
                  Text(
                    'CREATE',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.grey[300],
                        letterSpacing: 2),
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 13, vertical: 5),
                      decoration: BoxDecoration(
                        color: redColor,
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      child: const Text(
                        "Post",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage("assets/signup.jpeg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Description of post/story",
                        ),
                        scrollPadding: EdgeInsets.all(20.0),
                        autofocus: true,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: lightBlueColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: IconButton(
                      color: whiteColor,
                      padding: EdgeInsets.zero,
                      // constraints: BoxConstraints(),
                      onPressed: () {},
                      icon: Icon(Icons.add),
                    ),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: lightBlueColor,
                      borderRadius: BorderRadius.all(
                        Radius.circular(25),
                      ),
                    ),
                    child: Row(
                      children: [
                        IconButton(
                          color: whiteColor,
                          padding: EdgeInsets.zero,
                          // constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: Icon(Icons.image_outlined),
                        ),
                        IconButton(
                          color: whiteColor,
                          padding: EdgeInsets.zero,
                          // constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: Icon(Icons.gif_box_outlined),
                        ),
                        IconButton(
                          color: whiteColor,
                          padding: EdgeInsets.zero,
                          // constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: Icon(Icons.camera_alt_outlined),
                        ),
                        IconButton(
                          color: whiteColor,
                          padding: EdgeInsets.zero,
                          // constraints: BoxConstraints(),
                          onPressed: () {},
                          icon: Icon(Icons.attach_file_outlined),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
