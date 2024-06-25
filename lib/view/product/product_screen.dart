import 'package:counterapp/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/repository/getproduct_api/getproduct_api.dart';
import 'package:counterapp/view/product/widget/productcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "Product",
              style: TextStyle(color: Colors.white),
            )),
        body: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductLoaded) {
              print("object");
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("all Data Fetch")));
            }
          },
          builder: (context, state) {
            return FutureBuilder(
                future: GetProducts().getProductData(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final sucessState = state as ProductLoaded;
                    return ListView.builder(
                        itemCount: sucessState.product.length,
                        itemBuilder: (context, index) {
                          return Mycontainer(
                              productData: sucessState.product[index]);
                        });
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                });
          },
        ));
  }
}
