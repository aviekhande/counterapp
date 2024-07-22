import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/configs/components/commonbottomnavigationbar.dart';
import 'package:counterapp/core/services/network/bloc/internet_bloc/internet_bloc.dart';
import 'package:counterapp/core/configs/components/appbar_widget.dart';
import 'package:counterapp/core/configs/components/drawer_widget.dart';
// import 'package:counterapp/features/posts/presentation/bloc/posts_bloc.dart';
import 'package:counterapp/features/product_details/presentation/bloc/product_bloc/product_bloc.dart';
// import 'package:counterapp/features/wishlist_details/presentation/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
// import 'package:counterapp/core/routes/routes_import.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../flutter_gen/gen_l10n/app_localizations.dart';

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
              // AutoRouter.of(context).push(const ProductScreenRoute());
              context.loaderOverlay.hide();
            }
          },
          child: BlocConsumer<InternetBloc, InternetStatus>(
            listener: (context, state) {
              if (state.status == ConnectivityStatus.disconnected) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(AppLocalizations.of(context)!.internet)));
              }
            },
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Theme.of(context).colorScheme.surface,
                appBar: PreferredSize(
                    preferredSize: Size.fromHeight(45.h),
                    child: CommonAppBar(
                        screenName: AppLocalizations.of(context)!.homeScreen)),
                // body: 
                // Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Center(
                //       child: ElevatedButton(
                //         style: const ButtonStyle(
                //             backgroundColor: WidgetStatePropertyAll(
                //                 // Theme.of(context).colorScheme.primary
                //                 Color.fromARGB(255, 114, 182, 214)),
                //             minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                //         onPressed: () async {
                //           if (state.status == ConnectivityStatus.disconnected) {
                //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                 content: Text(
                //                     AppLocalizations.of(context)!.internet)));
                //           } else {
                //             context.loaderOverlay.show();
                //             context
                //                 .read<ProductBloc>()
                //                 .add(const ProductEvent());
                //           }
                //         },
                //         child: Text(
                //           AppLocalizations.of(context)!.loadProducts,
                //           style: TextStyle(
                //               color: Theme.of(context).colorScheme.primary,
                //               // color: Colors.white,
                //               fontSize: 20),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 20,
                //     ),
                //     Center(
                //       child: BlocBuilder<WishlistBloc, WishlistState>(
                //         builder: (context, state) {
                //           return BlocBuilder<InternetBloc, InternetStatus>(
                //             builder: (context, state) {
                //               return ElevatedButton(
                //                 style: const ButtonStyle(
                //                     backgroundColor: WidgetStatePropertyAll(
                //                         Color.fromARGB(255, 114, 182, 214)),
                //                     minimumSize:
                //                         WidgetStatePropertyAll(Size(300, 50))),
                //                 onPressed: () {
                //                   if (state.status ==
                //                       ConnectivityStatus.disconnected) {
                //                     ScaffoldMessenger.of(context).showSnackBar(
                //                         SnackBar(
                //                             content: Text(
                //                                 AppLocalizations.of(context)!
                //                                     .internet)));
                //                   } else {
                //                     context.loaderOverlay.show();
                //                     // Navigator.push(
                //                     //     context,
                //                     //     MaterialPageRoute(
                //                     //         builder: (context) =>
                //                     //             const WishListScreen()));
                //                     AutoRouter.of(context)
                //                         .push(const WishListScreenRoute());
                //                   }
                //                   context.loaderOverlay.hide();
                //                 },
                //                 child: Text(
                //                   AppLocalizations.of(context)!
                //                       .loadWishlistProducts,
                //                   style: TextStyle(
                //                       color:
                //                           Theme.of(context).colorScheme.primary,
                //                       // Colors.white,
                //                       fontSize: 20),
                //                 ),
                //               );
                //             },
                //           );
                //         },
                //       ),
                //     ),
                //     const SizedBox(
                //       height: 20,
                //     ),
                //     BlocBuilder<InternetBloc, InternetStatus>(
                //         builder: (context, state) {
                //       return ElevatedButton(
                //         style: const ButtonStyle(
                //             backgroundColor: WidgetStatePropertyAll(
                //                 Color.fromARGB(255, 114, 182, 214)),
                //             minimumSize: WidgetStatePropertyAll(Size(300, 50))),
                //         onPressed: () {
                //           context.read<PostsBloc>().add(PostsInitialEvent());
                //           if (state.status == ConnectivityStatus.disconnected) {
                //             ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //                 content: Text(
                //                     AppLocalizations.of(context)!.internet)));
                //           } else {
                //             context.loaderOverlay.show();
                //             AutoRouter.of(context)
                //                 .push(const PostScreenRoute());
                //           }
                //           context.loaderOverlay.hide();
                //         },
                //         child: Text(
                //           AppLocalizations.of(context)!.loadPosts,
                //           style: TextStyle(
                //               color: Theme.of(context).colorScheme.primary,
                //               // Colors.white,
                //               fontSize: 20),
                //         ),
                //       );
                //     })
                //   ],
                // ),
                // 
                drawer: const CommonDrawer(),
                bottomNavigationBar: const Commonbottomnavigationbar(),
              );
            },
          )),
    );
  }
}
