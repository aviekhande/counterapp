import 'dart:developer';
import 'package:auto_route/annotations.dart';
import 'package:counterapp/core/internet_bloc/internet_bloc.dart';
import 'package:counterapp/features/product_screen%20/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/features/product_screen%20/presentation/pages/productcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});
  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  bool isLoadingMore = false;
  int page = 1;
  final scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "Product",
              style: TextStyle(color: Colors.white),
            )),
        body: BlocBuilder<InternetBloc, InternetStatus>(
          builder: (context, state) {
            return state.status == ConnectivityStatus.connected
                ? BlocConsumer<ProductBloc, ProductState>(
                    listener: (context, state) {
                      if (state is ProductLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("all Data Fetch")));
                      }
                    },
                    builder: (context, state) {
                      // return FutureBuilder(
                      //     future: GetProducts().getProductData(),
                      //     builder: (context, snapshot) {
                      // if (snapshot.hasData) {
                      state as ProductLoaded;
                      return ListView.builder(
                          controller: scrollController,
                          itemCount: isLoadingMore
                              ? state.product.length + 1
                              : state.product.length,
                          itemBuilder: (context, index) {
                            return index < state.product.length
                                ? Mycontainer(productData: state.product[index])
                                : const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  );
                          });
                      // }
                      // else {
                      // return const Center(
                      //   child: CircularProgressIndicator(),
                      // );
                      // }
                      // });
                    },
                  )
                : const Center(
                    child: Text("No Internet Connection"),
                  );
          },
        ));
  }

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // page = page + 1;
      setState(() {
        isLoadingMore = true;
      });
      // await GetProducts().getProductData();
      // context.read<ProductBloc>().add(const ProductEvent());
      log("Call Api>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      setState(() {
        isLoadingMore = false;
      });
    }
  }
}
