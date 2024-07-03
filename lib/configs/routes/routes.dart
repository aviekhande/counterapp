part of 'routes_import.dart';


@AutoRouterConfig(replaceInRouteName :"Route")
class AppRouter extends $AppRouter {
   @override
 RouteType get defaultRouteType =>const RouteType.adaptive(); 
  @override
  List<AutoRoute> get routes => [
     AutoRoute(page: LoginScreenRoute.page, path: "/"),
     AutoRoute(page: SignUpScreenRoute.page, ),
    AutoRoute(page: HomeScreenRoute.page),
    AutoRoute(page: ProductScreenRoute.page),
    AutoRoute(page: WishListScreenRoute.page),
  ];
}