// import 'package:counterapp/features/product_screen%20/data/models/getproduct_model/getproduct_model.dart';
import 'dart:developer';
import 'package:auto_route/annotations.dart';
import 'package:counterapp/core/configs/components/appbar_widget.dart';
import 'package:counterapp/core/services/network/bloc/internet_bloc/internet_bloc.dart';
// import 'package:counterapp/features/product_details/data/data_sources/remote/getproduct_api.dart';
import 'package:counterapp/features/product_details/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/features/product_details/presentation/widgets/productcontainer.dart';
import 'package:counterapp/flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/configs/components/drawer_widget.dart';

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
    context.read<ProductBloc>().add(const ProductEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.h),
          child:
              CommonAppBar(screenName: AppLocalizations.of(context)!.product)),
      body: BlocBuilder<InternetBloc, InternetStatus>(
        builder: (context, state) {
          return state.status == ConnectivityStatus.connected
              ? BlocBuilder<ProductBloc, ProductState>(
                  builder: (context, state) {
                    return state is ProductLoaded
                        ? _products(state)
                        : const Center(
                            child: CircularProgressIndicator(
                              color: Colors.blue,
                            ),
                          );
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

  Widget _products(state) {
    return ListView.builder(
        itemCount: state.product.length,
        itemBuilder: (context, index) {
          return Mycontainer(productData: state.product[index]);
        });
  }
}
