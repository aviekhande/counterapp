
import 'package:flutter/material.dart';

class MycontainerState extends StatefulWidget {
  final Map empData;
  const MycontainerState({super.key, required this.empData});

  @override
  State<MycontainerState> createState() => __MycontainerStateState();
}

class __MycontainerStateState extends State<MycontainerState> {

  @override
  Widget build(BuildContext context) {
    return   Container(
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
                    "Employ Name: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 6,
                      ),
                      Text("${widget.empData['employee_name']}"),
                    ],
                  )),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Id: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("${widget.empData['id']}"),
                ],
              ),
              Row(
                children: [
                  const Text(
                    "Age: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("${widget.empData['employee_age']}"),
                ],
              ),
              //  Row(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //    children: [
              //      const Text("Description: ",
              //       style: TextStyle(fontSize: 20),
              //     ),
              //     Expanded(child: Text("${productList[index]['description']}")),
              //    ],
              //  )
            ],
          ),
        ],
      ),
    );
 
  }
}