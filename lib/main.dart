import 'package:counterapp/core/common/bloc/appbar_bloc.dart';
import 'package:counterapp/core/services/network/bloc/internet_bloc/internet_bloc.dart';
import 'package:counterapp/core/services/notification/notificaton_service.dart';
import 'package:counterapp/core/theme/app_theme.dart';
import 'package:counterapp/core/theme/bloc/theme_bloc_bloc.dart';
import 'package:counterapp/features/product_details/presentation/bloc/product_bloc/product_bloc.dart';
import 'package:counterapp/features/profile_details/presentation/bloc/bloc/profiledata_bloc.dart';
import 'package:counterapp/features/wishlist_details/presentation/bloc/wishlist_bloc/bloc/wishlist_bloc.dart';
import 'package:counterapp/core/routes/routes_import.dart';
import 'package:counterapp/injection.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'features/posts/presentation/bloc/posts_bloc.dart';
import 'flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyDVmxDCz0N1PmsbezBi1zx3Pk6fnOfMfJk',
    appId: "1:14163675222:android:e57490d6796b28fc71d3f7",
    messagingSenderId: '14163675222',
    projectId: 'fir-demo-ac8a5',
    storageBucket: 'fir-demo-ac8a5.appspot.com',
  ));
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  await LocalNotificationService().requestPermission();
  await LocalNotificationService().init();
  locator();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
    // final FlutterLocalization _localization = FlutterLocalization.instance;

  final _appRouter = AppRouter();

  @override
  void initState() {
    super.initState();

    notificationHandler();
  }

  void notificationHandler() {
    FirebaseMessaging.onMessage.listen((event) async {
      LocalNotificationService().showNotification(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ProductBloc(apiService: getIt()),
        ),
        BlocProvider(
          create: (context) => WishlistBloc(productrepo: getIt()),
        ),
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
        BlocProvider(
          create: (context) => ProfiledataBloc(),
        ),
        BlocProvider(
          create: (context) => PostsBloc(apiService: getIt()),
        ),
        BlocProvider(
          create: (context) => AppbarBloc(),
        ),
        BlocProvider(
          create: (context) => ThemeBlocBloc(),
        ),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          splitScreenMode: true,
          builder: (_, child) {
            return BlocBuilder<ThemeBlocBloc, ThemeBlocState>(
              builder: (context, state) {
                return MaterialApp.router(
                  theme: state is ThemeChangeBloc ? state.themeData : lightMode,
                  darkTheme:
                      state is ThemeChangeBloc ? state.themeData : darkMode,
                  localizationsDelegates:
                    AppLocalizations.localizationsDelegates,
                  supportedLocales:  AppLocalizations.supportedLocales,
                  debugShowCheckedModeBanner: false,
                  routerConfig: _appRouter.config(),
                );
              },
            );
          }),
    );
  }
}
