import 'package:counterapp/core/internet_bloc/internet_bloc.dart';
import 'package:counterapp/features/product_screen%20/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/features/wishlist_screen%20/presentation/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/features/product_screen%20/data/repositories/getproduct_api/getproduct_api.dart';
import 'package:counterapp/core/routes/routes_import.dart';
import 'package:counterapp/core/static.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

GetIt getIt = GetIt.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'key',
    appId: 'id',
    messagingSenderId: 'sendid',
    projectId: 'myapp',
    storageBucket: 'myapp-b9yt18.appspot.com',
  ));
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
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: _appRouter.config(),
      ),
    );
  }
}

void locator() {
  getIt.registerLazySingleton(() => GetProducts());
  getIt.registerLazySingleton(() => ProductRepo());
}
