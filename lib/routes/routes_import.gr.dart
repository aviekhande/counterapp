// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:counterapp/view/home/home_screen.dart' as _i1;
import 'package:counterapp/view/product/product_screen.dart' as _i2;
import 'package:counterapp/view/wishlistscreen/wishlist_screen.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    ProductScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.ProductScreen(),
      );
    },
    WishListScreenRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.WishListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i4.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.ProductScreen]
class ProductScreenRoute extends _i4.PageRouteInfo<void> {
  const ProductScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          ProductScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.WishListScreen]
class WishListScreenRoute extends _i4.PageRouteInfo<void> {
  const WishListScreenRoute({List<_i4.PageRouteInfo>? children})
      : super(
          WishListScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'WishListScreenRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
