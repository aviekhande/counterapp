import 'package:counterapp/model/getproduct_model/getproduct_model.dart';
import 'package:flutter/material.dart';

class Mycontainer extends StatefulWidget {
  final Product productData;
  const Mycontainer({super.key, required this.productData});

  @override
  State<Mycontainer> createState() => __MycontainerState();
}

class __MycontainerState extends State<Mycontainer> {
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
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.network(
                    "${widget.productData.image}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
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
                      Text("${widget.productData.title}"),
                    ],
                  )),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Expanded(child: Text('${widget.productData.description}')),
                ],
              ),
              Row(
                children: [
                  
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text("Rating : "),
                          Text("${widget.productData.rating?.rate}"),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          const Text("Count : "),
                          Text("${widget.productData.rating?.count}"),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Column(
                    children: [
                      Icon(
                        Icons.favorite_border,
                      ),
                      Text("Wishlist")
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
