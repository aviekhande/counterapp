import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/common/drawerbloc/startup_bloc.dart';
import '../../auth/domain/usecases/sessioncontroller.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
        context.read<StartupBloc>().add(CheckEvent());
    
    super.initState();
  }
 User? isLogin() {
    FirebaseAuth auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      SessionController().userId = user.uid.toString();
    }
    return user;
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<StartupBloc,StartupState>(
      listener: (context,state) {
        if(state is StartupCheck){
          Timer(const Duration(seconds: 2),
        () => AutoRouter.of(context).push(isLogin() !=null ? const HomeScreenRoute():const LoginScreenRoute()));
        }
      },
        child :Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Image.asset(
                  "assets/images/FJE-yDcXEAMsxeD.jpeg",
                  height: 150.h,
                ),
                SizedBox(
                  height: 250.h,
                ),
                const CircularProgressIndicator(
                  color: Colors.blue,
                ),
                SizedBox(
                  height: 10.h,
                )
              ],
            ),
          ),
        ));
      }
    
  }
