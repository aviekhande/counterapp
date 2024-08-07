// ignore_for_file: use_build_context_synchronously

import 'package:auto_route/auto_route.dart';
import 'package:counterapp/core/routes/routes_import.gr.dart';
import 'package:counterapp/features/auth/domain/usecases/authentication.dart';
import 'package:counterapp/features/auth/presentation/widgets/snackbar.dart';
import "package:flutter/material.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/services/network/bloc/internet_bloc/internet_bloc.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});
  @override
  State createState() => SignUpState();
}

class SignUpState extends State {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  late InternetBloc internetBloc;
  @override
  void initState() {
    internetBloc = context.read<InternetBloc>();
    internetBloc.checkInternet();
    internetBloc.trackConnectivityChange();
    super.initState();
  }

  GlobalKey<FormState> checkkey = GlobalKey();
  bool isLoading = false;

  void signUpUser() async {
    // set is loading to true.

    String res = await AuthMethod().signUpUser(
        email: emailController.text,
        password: passwordController.text,
        name: nameController.text);
    // if string return is success, user has been creaded and navigate to next screen other witse show error.
    if (res == "success") {
      //navigate to the next screen
      AutoRouter.of(context).push(const SplashScreenRoute());
      showSnackBar(context, res);
    } else {
      // show error
      showSnackBar(context, res);
    }
  }

  bool unshowpass = true;
  Widget toggleicon() {
    return IconButton(
        onPressed: () {
          setState(() {
            unshowpass = !unshowpass;
          });
        },
        icon: unshowpass
            ? const Icon(Icons.remove_red_eye_outlined)
            : const Icon(Icons.remove_red_eye));
  }

  static List data = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InternetBloc, InternetStatus>(
      listener: (context, state) {
        if (state.status == ConnectivityStatus.disconnected) {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Please connect to Internet")));
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(33),
              child: Form(
                key: checkkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                        child: SvgPicture.asset("assets/images/Group 2.svg")),
                    SizedBox(
                      height: 30.h,
                    ),
                    const Text(
                      "Sign Up",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                          labelText: "Enter Name",
                          hintText: "Enter Name",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter FistName";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          label: const Text("Enter EmailId"),
                          hintText: "Enter EmailId",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter EmailId";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFormField(
                      textAlignVertical: TextAlignVertical.top,
                      obscureText: unshowpass,
                      controller: passwordController,
                      decoration: InputDecoration(
                          contentPadding: const EdgeInsets.only(
                              left: 10, bottom: 12, top: 2),
                          suffix: toggleicon(),
                          labelText: "Enter Password",
                          hintText: "Enter Password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 40.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (state.status == ConnectivityStatus.disconnected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please connect to Internet")));
                        } else {
                          if (checkkey.currentState!.validate()) {
                            signUpUser();
                          }
                        }
                      },
                      child: Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0XFF0063E6)),
                        child: const Center(
                          child: Text(
                            "Create Account",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        const Text(
                          "Already have an account?",
                          style: TextStyle(fontSize: 15),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop(context);
                          },
                          child: const Text(
                            "Sign In",
                            style: TextStyle(
                                color: Color(0XFF0063E6), fontSize: 18),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
