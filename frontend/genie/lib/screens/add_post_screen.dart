import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:genie/utils/colors.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  @override
  Widget build(BuildContext context) {
    // return Center(
    //   child: IconButton(icon: Icon(Icons.upload)),
    // );

    return Scaffold(
      backgroundColor: mobileBackgroundColor,
      // appBar: AppBar(
      //   backgroundColor: whiteColor,
      //   leading: IconButton(
      //     icon: const Icon(
      //       Icons.arrow_back,
      //       color: secondaryColor,
      //     ),
      //     onPressed: () {},
      //   ),
      //   title: const Text('Add Post'),
      //   centerTitle: false,
      //   actions: [
      //     TextButton(
      //       onPressed: () {},
      //       child: const Text(
      //         'Post',
      //         style: TextStyle(
      //           color: mobileBackgroundColor,
      //           fontWeight: FontWeight.w300,
      //           fontSize: 16,
      //         ),
      //       ),
      //     )
      //   ],
      // ),
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.fromLTRB(16, 0, 22, 34.5),
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
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage("assets/signup.jpeg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                          hintText: 'Description of post/story?'),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      expands: true, // <-- SEE HERE
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
