import 'package:auto_route/annotations.dart';
import 'package:counterapp/core/services/network/bloc/internet_bloc/internet_bloc.dart';
import 'package:counterapp/features/wishlist_details/presentation/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/features/wishlist_details/presentation/widgets/wishlistcontainer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/configs/components/appbar_widget.dart';
import '../../../../core/configs/components/commonbottomnavigationbar.dart';
import '../../../../flutter_gen/gen_l10n/app_localizations.dart';

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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.h),
          child: CommonAppBar(
              screenName: AppLocalizations.of(context)!.wishlistProduct)),
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
                        : Center(
                            child:
                                Text(AppLocalizations.of(context)!.noWishlist),
                          );
                  },
                )
              : Center(
                  child: Text(AppLocalizations.of(context)!.internet),
                );
        },
      ),
      bottomNavigationBar: const Commonbottomnavigationbar(),
    );
  }
}
