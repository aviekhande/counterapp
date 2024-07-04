import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/internet_bloc/internet_bloc.dart';
import 'package:counterapp/configs/components/appbar_widget.dart';
import 'package:counterapp/configs/components/drawer_widget.dart';
import 'package:counterapp/features/product_screen%20/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/features/wishlist_screen%20/presentation/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/configs/routes/routes_import.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  bool loader = false;
  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: BlocListener<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state is ProductLoaded) {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => const ProductScreen()));
              AutoRouter.of(context).push(const ProductScreenRoute());
              context.loaderOverlay.hide();
            }
          },
          child: BlocConsumer<InternetBloc, InternetStatus>(
            listener: (context, state) {
              if (state.status == ConnectivityStatus.disconnected) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Please connect to Internet")));
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: const PreferredSize(
                    preferredSize: Size(50, 50),
                    child: CommonAppBar(screenName: "HomeScreen")),
                body: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 114, 182, 214)),
                            minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                        onPressed: () {
                          if (state.status == ConnectivityStatus.disconnected) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please connect to Internet")));
                          } else {
                            context.loaderOverlay.show();
                            context
                                .read<ProductBloc>()
                                .add(const ProductEvent());
                          }
                        },
                        child: const Text(
                          "Load Products",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, state) {
                          return BlocBuilder<InternetBloc, InternetStatus>(
                            builder: (context, state) {
                              return ElevatedButton(
                                style: const ButtonStyle(
                                    backgroundColor: WidgetStatePropertyAll(
                                        Color.fromARGB(255, 114, 182, 214)),
                                    minimumSize:
                                        WidgetStatePropertyAll(Size(300, 50))),
                                onPressed: () {
                                  if (state.status ==
                                      ConnectivityStatus.disconnected) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text(
                                                "Please connect to Internet")));
                                  } else {
                                    context.loaderOverlay.show();
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const WishListScreen()));
                                    AutoRouter.of(context)
                                        .push(const WishListScreenRoute());
                                  }
                                  context.loaderOverlay.hide();
                                },
                                child: const Text(
                                  "Load WishList Products",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                drawer: const CommonDrawer(),
              );
            },
          )),
    );
  }
}
