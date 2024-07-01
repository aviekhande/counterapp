import 'package:auto_route/annotations.dart';
import 'package:counterapp/core/internet_bloc/internet_bloc.dart';
import 'package:counterapp/features/wishlist_screen%20/presentation/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/features/wishlist_screen%20/presentation/widgets/wishlistcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key});
  @override
  State<WishListScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<WishListScreen> {
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
    return Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text(
              "WishListProduct",
              style: TextStyle(color: Colors.white),
            )),
        body: BlocBuilder<InternetBloc, InternetStatus>(
          builder: (context, state) {
            return state.status == ConnectivityStatus.connected
                ? BlocBuilder<WishlistBloc, WishlistState>(
                    builder: (context, state) {
                      return state is WishlistLoaded
                          ? ListView.builder(
                              itemCount: state.product.length,
                              itemBuilder: (context, index) {
                                return Mycontainer(
                                  productData: state.product[index],
                                  index: index,
                                );
                              })
                          : const Center(
                              child: Text("No Wishlist found"),
                            );
                    },
                  )
                : const Center(
                    child: Text("No Internet Connection"),
                  );
          },
        ));
  }
}
