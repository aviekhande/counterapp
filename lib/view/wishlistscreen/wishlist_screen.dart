
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
            }else{
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return state is WishlistLoaded? ListView.builder(
                itemCount: state.product.length,
                itemBuilder: (context, index) {
                  return Mycontainer(productData: state.product[index],index: index,);
                }):
                const Center(
                  child: Text("No Wishlist found"),

                );
          },
        ));
  }
}
