part of 'routes_import.dart';

@AutoRouterConfig(replaceInRouteName: "Route")
class AppRouter extends $AppRouter {
  User? isLogin(){
  FirebaseAuth auth = FirebaseAuth.instance;
  final user = auth.currentUser;
  if(user !=null){
    SessionController().userId = user.uid.toString();
  
  }
  return user;
  
  }
  @override
  RouteType get defaultRouteType => const RouteType.adaptive();
  @override
  List<AutoRoute> get routes => [
    isLogin()!=null?
        AutoRoute(page: LoginScreenRoute.page,): AutoRoute(page: LoginScreenRoute.page, path: "/"),
        AutoRoute(
          page: SignUpScreenRoute.page,
        ),
        
        AutoRoute(
          page: SignUpScreenRoute.page,
        ),
        AutoRoute(
          page: ProfileScreenRoute.page,
        ),
        isLogin()!=null?
        AutoRoute(page: HomeScreenRoute.page, path: "/"): AutoRoute(page: HomeScreenRoute.page),
        AutoRoute(page: ProductScreenRoute.page),
        AutoRoute(page: WishListScreenRoute.page),
      ];
}