// import 'package:counterapp/features/product_screen%20/data/models/getproduct_model/getproduct_model.dart';
import 'dart:developer';
import 'package:auto_route/annotations.dart';
import 'package:counterapp/configs/components/appbar_widget.dart';
import 'package:counterapp/core/internet_bloc/internet_bloc.dart';
import 'package:counterapp/features/product_screen%20/data/data_sources/remote/getproduct_api.dart';
import 'package:counterapp/features/product_screen%20/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/features/product_screen%20/presentation/widgets/productcontainer.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../configs/components/drawer_widget.dart';

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
      appBar: const PreferredSize(
          preferredSize: Size(10, 50),
          child: CommonAppBar(screenName: "Product")),
      // AppBar(
      //     backgroundColor: Colors.blue,
      //     title: const Text(
      //       "Product",
      //       style: TextStyle(color: Colors.white),
      //     )),
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
                    return _body(state);
                    // return FutureBuilder(
                    //     future: GetProducts().getProductData(),
                    //     builder: (context, snapshot) {
                    // if (snapshot.hasData) {
                    // state as ProductLoaded;
                    // return ListView.builder(
                    //     controller: scrollController,
                    //     itemCount: isLoadingMore
                    //         ? state.product.length + 1
                    //         : state.product.length,
                    //     itemBuilder: (context, index) {
                    //       return index < state.product.length
                    //           ? Mycontainer(productData: state.product[index])
                    //           : const Center(
                    //               child: CircularProgressIndicator(
                    //                 color: Colors.black,
                    //               ),
                    //             );
                    //     });
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
      ),
      drawer: const CommonDrawer(),
    );
  }

  FutureBuilder _body(state) {
    final apiService =
        ApiService(Dio(BaseOptions(contentType: "application/json")));
    return FutureBuilder(
      future: apiService.getProductData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          state as ProductLoaded;
          return _products(state.product, state);
          // ListView.builder(
          //     controller: scrollController,
          //     itemCount: isLoadingMore
          //         ? state.product.length + 1
          //         : state.product.length,
          //     itemBuilder: (context, index) {
          //       return index < state.product.length
          //           ? Mycontainer(productData: state.product[index])
          //           : const Center(
          //               child: CircularProgressIndicator(
          //                 color: Colors.black,
          //               ),
          //             );
          //     });
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget _products(List<dynamic> products, state) {
    return ListView.builder(
        controller: scrollController,
        itemCount: state.product.length,
        // isLoadingMore ? state.product.length + 1 : state.product.length,
        itemBuilder: (context, index) {
          return index < state.product.length
              ? Mycontainer(productData: state.product[index])
              : const Center(
                  child: CircularProgressIndicator(
                    color: Colors.black,
                  ),
                );
        });
  }

  void _scrollListener() async {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      // page = page + 1;
      // setState(() {
      //   isLoadingMore = true;
      // });
      // await GetProducts().getProductData();
      // context.read<ProductBloc>().add(const ProductEvent());
      log("Call Api>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      // setState(() {
      //   isLoadingMore = false;
      // });
    }
  }
}
