import 'dart:developer';
import 'package:counterapp/features/product_details/data/models/getproduct_model/getproduct_model.dart';
import 'package:counterapp/features/wishlist_details/presentation/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Mycontainer extends StatefulWidget {
  final Product productData;
  final int index;
  const Mycontainer(
      {super.key, required this.productData, required this.index});

  @override
  State<Mycontainer> createState() => __MycontainerState();
}

class __MycontainerState extends State<Mycontainer> {
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          color: Theme.of(context).colorScheme.primary,
          // color: Colors.white,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  height: 150,
                  width: 150,
                  child: Image.network(
                    "${widget.productData.image}",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.title,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text("${widget.productData.title}"),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppLocalizations.of(context)!.description,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text('${widget.productData.description}'),
                ],
              ),
              Row(
                children: [
                  Text(
                    AppLocalizations.of(context)!.price,
                    style: const TextStyle(fontSize: 20),
                  ),
                  Text("${widget.productData.price}"),
                ],
              ),
              Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.rating,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text("${widget.productData.rating?.rate}"),
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Row(
                        children: [
                          Text(
                            AppLocalizations.of(context)!.count,
                            style: const TextStyle(fontSize: 20),
                          ),
                          Text("${widget.productData.rating?.count}"),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    children: [
                      BlocBuilder<WishlistBloc, WishlistState>(
                        builder: (context, state) {
                          return GestureDetector(
                              onTap: () {
                                if (state is WishlistLoaded) {
                                  context.read<WishlistBloc>().add(
                                      WishListRemove(widget.productData.id));
                                  log("${state.product.length}");
                                }
                              },
                              child: const Icon(
                                Icons.favorite_outlined,
                                color: Colors.red,
                              ));
                        },
                      ),
                      Text(
                        AppLocalizations.of(context)!.wishlist,
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
