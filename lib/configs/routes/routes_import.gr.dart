// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:counterapp/features/auth/presentation/pages/login_screen.dart'
    as _i2;
import 'package:counterapp/features/auth/presentation/pages/signup_screen.dart'
    as _i5;
import 'package:counterapp/features/home_screen/presentation/pages/home_screen.dart'
    as _i1;
import 'package:counterapp/features/product_screen%20/presentation/pages/product_screen.dart'
    as _i3;
import 'package:counterapp/features/profile_screen/presentation/pages/profil_screen.dart'
    as _i4;
import 'package:counterapp/features/wishlist_screen%20/presentation/widgets/wishlist_screen.dart'
    as _i6;

abstract class $AppRouter extends _i7.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i7.PageFactory> pagesMap = {
    HomeScreenRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.HomeScreen(),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LoginScreen(),
      );
    },
    ProductScreenRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.ProductScreen(),
      );
    },
    ProfileScreenRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ProfileScreen(),
      );
    },
    SignUpScreenRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.SignUpScreen(),
      );
    },
    WishListScreenRoute.name: (routeData) {
      return _i7.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.WishListScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.HomeScreen]
class HomeScreenRoute extends _i7.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(
          HomeScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeScreenRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreenRoute extends _i7.PageRouteInfo<void> {
  const LoginScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(
          LoginScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginScreenRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i3.ProductScreen]
class ProductScreenRoute extends _i7.PageRouteInfo<void> {
  const ProductScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProductScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductScreenRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ProfileScreen]
class ProfileScreenRoute extends _i7.PageRouteInfo<void> {
  const ProfileScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(
          ProfileScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileScreenRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i5.SignUpScreen]
class SignUpScreenRoute extends _i7.PageRouteInfo<void> {
  const SignUpScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(
          SignUpScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'SignUpScreenRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}

/// generated route for
/// [_i6.WishListScreen]
class WishListScreenRoute extends _i7.PageRouteInfo<void> {
  const WishListScreenRoute({List<_i7.PageRouteInfo>? children})
      : super(
          WishListScreenRoute.name,
          initialChildren: children,
        );

  static const String name = 'WishListScreenRoute';

  static const _i7.PageInfo<void> page = _i7.PageInfo<void>(name);
}
