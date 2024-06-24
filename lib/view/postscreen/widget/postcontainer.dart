import 'package:counterapp/model/getpost_model/getpost_model.dart';
import 'package:flutter/material.dart';

class MycontainerState extends StatefulWidget {
  final Posts postsData;
  const MycontainerState({super.key, required this.postsData});

  @override
  State<MycontainerState> createState() => __MycontainerStateState();
}

class __MycontainerStateState extends State<MycontainerState> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text("${widget.postsData.title}"),
                    ],
                  )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Content: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(child: Text('${widget.postsData.body}')),
                ],
              ),
              // Row(
              //   children: [
              //     const Text(
              //       "Age: ",
              //       style: TextStyle(fontSize: 20),
              //     ),
              //     Text("${widget.postsData['employee_age']}"),
              //   ],
              // ),
              Row(
                children: [
                  Column(
                    children: [
                      const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      Text("${widget.postsData.reactions!.likes}"),
                      const Text("Likes")
                    ],
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Column(
                    children: [
                      const Icon(
                        Icons.favorite_border_outlined,
                      ),
                      Text("${widget.postsData.reactions!.dislikes}"),
                      const Text("DisLikes")
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      const Icon(
                        Icons.remove_red_eye,
                      ),
                      Text("${widget.postsData.views}"),
                      const Text("Views")
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
