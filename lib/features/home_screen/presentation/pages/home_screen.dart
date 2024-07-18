import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/services/network/bloc/internet_bloc/internet_bloc.dart';
import 'package:counterapp/core/configs/components/appbar_widget.dart';
import 'package:counterapp/core/configs/components/drawer_widget.dart';
import 'package:counterapp/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:counterapp/features/product_details/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/features/wishlist_details/presentation/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
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
    context.read<WishlistBloc>().add(WishListfetch());
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
                backgroundColor: Theme.of(context).colorScheme.surface,
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
                                // Theme.of(context).colorScheme.primary
                                Color.fromARGB(255, 114, 182, 214)),
                            minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                        onPressed: () async {
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
                        child: Text(
                          "Load Products",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              // color: Colors.white,
                              fontSize: 20),
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
                                child: Text(
                                  "Load WishList Products",
                                  style: TextStyle(
                                      color:
                                          Theme.of(context).colorScheme.primary,
                                      // Colors.white,
                                      fontSize: 20),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    BlocBuilder<InternetBloc, InternetStatus>(
                        builder: (context, state) {
                      return ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor: WidgetStatePropertyAll(
                                Color.fromARGB(255, 114, 182, 214)),
                            minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                        onPressed: () {
                          context.read<PostsBloc>().add(PostsInitialEvent());
                          if (state.status == ConnectivityStatus.disconnected) {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content:
                                        Text("Please connect to Internet")));
                          } else {
                            context.loaderOverlay.show();
                            AutoRouter.of(context)
                                .push(const PostScreenRoute());
                          }
                          context.loaderOverlay.hide();
                        },
                        child: Text(
                          "Load Posts",
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              // Colors.white,
                              fontSize: 20),
                        ),
                      );
                    })
                  ],
                ),
                drawer: const CommonDrawer(),
              );
            },
          )),
    );
  }
}
