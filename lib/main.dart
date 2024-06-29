import 'package:counterapp/bloc/internet_bloc/internet_bloc.dart';
import 'package:counterapp/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/repository/getproduct_api/getproduct_api.dart';
import 'package:counterapp/routes/routes_import.dart';
import 'package:counterapp/view/home/home_screen.dart';
import 'package:counterapp/view/static.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  locator();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
   final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(productrepo: getIt()),
        ),
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
      ],
      child:  MaterialApp.router(
        
          debugShowCheckedModeBanner: false,
          routerConfig: _appRouter.config(),),
    );
  }
}

void locator() {
  getIt.registerLazySingleton(() => GetProducts());
  getIt.registerLazySingleton(() => ProductRepo());
}
