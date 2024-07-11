import 'package:counterapp/core/static.dart';
import 'package:counterapp/features/product_details/data/data_sources/remote/getproduct_api.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'features/posts/data/data_source/getpost_api.dart';

GetIt getIt = GetIt.instance;
void locator() {
  // getIt.registerLazySingleton(() => GetProducts());
  getIt.registerLazySingleton(() => ProductRepo());
  getIt.registerLazySingleton(() => ApiService(Dio()));
  getIt.registerLazySingleton(() => ApiService1(Dio()));
}
