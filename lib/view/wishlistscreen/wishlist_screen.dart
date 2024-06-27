import 'package:counterapp/bloc/internet_bloc/internet_bloc.dart';
import 'package:counterapp/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/repository/product_repo.dart';
import 'package:counterapp/view/wishlistscreen/widget/wishlistcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                ? BlocConsumer<WishlistBloc, WishlistState>(
                    listener: (context, state) {
                      if (state is WishlistLoaded) {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("all Data Fetch")));
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    builder: (context, state) {
                      return state is WishlistLoaded
                          ? ListView.builder(
                              itemCount: state.product.length,
                              itemBuilder: (context, index) {
                                return 
                                  Container(
                                  padding: const EdgeInsets.all(8),
                                  margin: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: SizedBox(
                                              height: 150,
                                              width: 150,
                                              child: Image.network(
                                                "${state.product[index].image}",
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Title: ",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                  "${state.product[index].title}"),
                                            ],
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Description: ",
                                                style: TextStyle(fontSize: 20),
                                              ),
                                              Text(
                                                  '${state.product[index].description}'),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Rating : ",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          "${state.product[index].rating?.rate}"),
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Row(
                                                    children: [
                                                      const Text(
                                                        "Count : ",
                                                        style: TextStyle(
                                                            fontSize: 20),
                                                      ),
                                                      Text(
                                                          "${state.product[index].rating?.count}"),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Column(
                                                children: [
                                                  BlocBuilder<WishlistBloc,
                                                      WishlistState>(
                                                    builder: (context, state) {
                                                      return GestureDetector(
                                                          onTap: () {
                                                            if (state
                                                                is WishlistLoaded) {
                                                              context
                                                                  .read<
                                                                      WishlistBloc>()
                                                                  .add(WishListRemove(
                                                                      state.product[index]
                                                                          .id));
                                                              setState(() {});
                                                              // var add = state.product.removeAt(index);
                                                              // context.read<WishlistBloc>().add(WishListAdd(state.product));
                                                              if (state.product
                                                                  .isEmpty) {
                                                                // context.read<WishlistBloc>().add(WishListRemove());
                                                              }
                                                              print(state
                                                                  .product
                                                                  .length);
                                                            }
                                                          },
                                                          child: const Icon(
                                                            Icons
                                                                .favorite_outlined,
                                                            color: Colors.red,
                                                          ));
                                                    },
                                                  ),
                                                  const Text("Wishlist")
                                                ],
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                );
  
                                // Mycontainer(
                                //   productData: state.product[index],
                                //   index: index,
                                // );
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
