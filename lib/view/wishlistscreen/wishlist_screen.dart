import 'dart:developer';

import 'package:counterapp/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/view/wishlistscreen/widget/wishlistcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});
  @override
  State<WishListScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<WishListScreen> {

  @override
  Widget build(BuildContext context) {
    log("!!!!!!!!!!!!!!!!!!!!!!!!!!!");
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "WishListProduct",
              style: TextStyle(color: Colors.white),
            )),
        body: BlocConsumer<WishlistBloc, WishlistState>(
          listener: (context, state) {
            if (state is WishlistLoaded) {
              print("object");
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("all Data Fetch")));
            }
          },
          builder: (context, state) {
            final sucessState = state as WishlistLoaded;
            return sucessState.product.isNotEmpty? ListView.builder(
                itemCount: sucessState.product.length,
                itemBuilder: (context, index) {
                  return Mycontainer(productData: sucessState.product[index],index: index,);
                }):
                const Center(
                  child: CircularProgressIndicator(),
                );
          },
        ));
  }
}
