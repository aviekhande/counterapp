// import 'package:counterapp/bloc/home_bloc/counter_bloc.dart';
// import 'package:counterapp/bloc/home_bloc/counter_state.dart';
// import 'package:counterapp/view/employeeinfo/employee_screen.dart';
// import 'package:counterapp/view/insertemployeedata/insertemployeedata.dart';
import 'package:counterapp/bloc/internet_bloc/internet_bloc.dart';
import 'package:counterapp/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/view/product/product_screen.dart';
//import 'package:counterapp/view/static.dart';
import 'package:counterapp/view/wishlistscreen/wishlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'widget/widget.dart';
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
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProductScreen()));
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
                  appBar: AppBar(
                    backgroundColor: Colors.blue,
                    title: const Text(
                      "HomeScreen",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  body: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Center(
                        child: ElevatedButton(
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
                                      minimumSize: WidgetStatePropertyAll(
                                          Size(300, 50))),
                                  onPressed: () {
                                    if (state.status ==
                                        ConnectivityStatus.disconnected) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                              content: Text(
                                                  "Please connect to Internet")));
                                    } else{
                                    context.loaderOverlay.show();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const WishListScreen()));}
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
                  ));
            },
          )),
    );
  }
}
