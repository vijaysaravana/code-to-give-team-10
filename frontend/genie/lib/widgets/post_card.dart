import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:genie/utils/colors.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // IMAGE
          Container(
            margin: EdgeInsets.fromLTRB(0, 0, 0, 15.5),
            // width: 343,
            // height: 343,
            child: Image.network(
              "https://pbs.twimg.com/media/FVoOF1FWUAM6MqT?format=jpg&name=medium",
            ),
          ),

          // USERNAME, USER ID AND LIKES COMMENTS SHARE
          Container(
            width: double.infinity,
            height: 28.5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // USERNAME, USERID
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0.5, 8, 0),
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "https://pbs.twimg.com/media/FVoOF1FWUAM6MqT?format=jpg&name=medium",
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: double.infinity,
                      child: Stack(
                        children: [
                          Text(
                            'Make A Wish GA',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Positioned(
                            left: 0,
                            top: 15,
                            child: Text(
                              '@makeawishga',
                              style: TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                // LIKE COMMENT SHARE
                Row(
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.star,
                        color: yellowColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.mode_comment_outlined,
                        color: secondaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.send,
                        color: secondaryColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(
            height: 20,
          ),

          Divider(
            height: 2,
            color: secondaryColor,
          ),

          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class OldPostCard extends StatelessWidget {
  const OldPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: mobileBackgroundColor,
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Column(
        children: [
          // HEADER SECTION
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(children: [
              CircleAvatar(
                radius: 16,
                backgroundImage: AssetImage("assets/signup.jpeg"),
              ),
              Expanded(
                child: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Username",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    )),
              ),
              IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        shrinkWrap: true,
                        children: [
                          'Delete',
                          'Report',
                          'Save',
                        ]
                            .map(
                              (e) => InkWell(
                                onTap: () {},
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 12,
                                    horizontal: 16,
                                  ),
                                  child: Text(e),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.more_vert),
              ),
            ]),
          ),

          // IMAGE SECTION
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35,
            width: double.infinity,
            child: Image.network(
              "https://pbs.twimg.com/media/FVoOF1FWUAM6MqT?format=jpg&name=medium",
              fit: BoxFit.cover,
            ),
          ),

          // LIKE COMMENT SHARE
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.star,
                  color: yellowColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.comment_outlined,
                  color: secondaryColor,
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.send,
                  color: secondaryColor,
                ),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.bottomRight,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.bookmark,
                    color: secondaryColor,
                  ),
                ),
              ))
            ],
          ),

          // DESC, COMMENTS, LIKES

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DefaultTextStyle(
                  style: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(fontWeight: FontWeight.w800),
                  child: Text(
                    '1,234 Stars',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 8),
                  child: RichText(
                    text: TextSpan(
                        style: const TextStyle(color: primaryColor),
                        children: [
                          TextSpan(
                            text: 'Username   ',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: 'Caption Caption Caption!!',
                            style: const TextStyle(fontWeight: FontWeight.w300),
                          )
                        ]),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    child: Text(
                      'View all 47 comments',
                      style: TextStyle(
                        fontSize: 12,
                        color: secondaryColor,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    '4/21/2023',
                    style: TextStyle(
                      fontSize: 12,
                      color: secondaryColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
