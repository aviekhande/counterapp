import 'package:counterapp/bloc/internet_bloc/internet_bloc.dart';
import 'package:counterapp/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/model/getproduct_model/getproduct_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mycontainer extends StatefulWidget {
  final Product productData;
  const Mycontainer({super.key, required this.productData});

  @override
  State<Mycontainer> createState() => __MycontainerState();
}

class __MycontainerState extends State<Mycontainer> {
  late InternetBloc internetBloc;

  @override
  void initState() {
   internetBloc = context.read<InternetBloc>();
    internetBloc.checkInternet();
    internetBloc.trackConnectivityChange();
    super.initState();
  }

  @override
  void dispose() {
    internetBloc.dispose();
    super.dispose();
  }

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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Title: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text("${widget.productData.title}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Description: ",
                    style: TextStyle(fontSize: 20),
                  ),
                  Text('${widget.productData.description}'),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          const Text("Rating : ",
                    style: TextStyle(fontSize: 20),),
                          Text("${widget.productData.rating?.rate}"),
                        ],
                      ),
                      const SizedBox(
                        width: 10, 
                      ),
                      Row(
                        children: [
                          const Text("Count : ",
                    style: TextStyle(fontSize: 20),),
                          Text("${widget.productData.rating?.count}"),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, state) {
                          return GestureDetector(
                              onTap: () {
                                // favlist.add(widget.productData);
                                context
                                    .read<WishlistBloc>()
                                    .add(WishListAdd(widget.productData));
                              },
                              child: const Icon(
                                Icons.favorite_border,
                              ));
                        },
                      ),
                      const Text("Wishlist")
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
