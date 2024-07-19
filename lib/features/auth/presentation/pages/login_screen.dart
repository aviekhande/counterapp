// ignore_for_file: use_build_context_synchronously

import "package:auto_route/auto_route.dart";
import "package:counterapp/core/routes/routes_import.gr.dart";
import "package:counterapp/features/auth/domain/usecases/google_auth.dart";
import "package:counterapp/features/auth/presentation/widgets/snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_sign_in/google_sign_in.dart";

import "../../../../core/services/network/bloc/internet_bloc/internet_bloc.dart";
import "../../../../core/services/notification/notificaton_service.dart";
import "../../domain/usecases/authentication.dart";

@RoutePage()
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State createState() => _LoginScreenState();
}

class _LoginScreenState extends State {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  late InternetBloc internetBloc;
  @override
  void initState() {
    internetBloc = context.read<InternetBloc>();
    internetBloc.checkInternet();
    internetBloc.trackConnectivityChange();
    super.initState();
  }

  GlobalKey<FormState> validkey = GlobalKey();
  // List loginData = SignUpState.data;
  bool isLoading = false;
  bool unshowpass = true;
  void checkUserIsLoginOrNot() async {
    bool isLogin = await _googleSignIn.isSignedIn();
    if (isLogin) {
      AutoRouter.of(context).push(const HomeScreenRoute());
    }
  }

  Icon toggleicon() {
    return Icon(
        unshowpass ? Icons.remove_red_eye_outlined : Icons.remove_red_eye);
  }

  void loginUser(context) async {
    // signUp user using our authMethod
    String res = await AuthMethod().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      LocalNotificationService().uploadFcmToken();
      // navigate to the home screen
      AutoRouter.of(context).push(const SplashScreenRoute());
      emailController.clear();
      passwordController.clear();
      showSnackBar(context, "Login successful");
    } else {
      // show error
      showSnackBar(context, res);
    }
  }

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
                key: validkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 30.h,
                    ),
                    Center(
                        child: SvgPicture.asset("assets/images/Group 1.svg")),
                    SizedBox(
                      height: 30.h,
                    ),
                    const Text(
                      "Log In",
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 25),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                          labelText: "Enter Email",
                          hintText: "Email",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Email";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFormField(
                      obscureText: unshowpass,
                      obscuringCharacter: "*",
                      controller: passwordController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.only(
                            left: 10, bottom: 14, top: 10, right: 10),
                        suffix: GestureDetector(
                            onTap: () {
                              setState(() {
                                unshowpass = !unshowpass;
                                toggleicon();
                              });
                            },
                            child: toggleicon()),
                        labelText: "Enter Password",
                        hintText: "Password",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Enter Password";
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (state.status == ConnectivityStatus.disconnected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please connect to Internet")));
                        } else {
                          loginUser(context);
                          validkey.currentState!.validate();
                        }

                        if (true) {
                          // AutoRouter.of(context)
                          //     .popAndPush(const HomeScreenRoute());
                        }
                        // else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(content: Text("Enter Valid Data")));
                        // }
                      },
                      child: Container(
                        height: 40.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: const Color(0XFF0063E6)),
                        child: const Center(
                          child: Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 19),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 25.h,
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (state.status == ConnectivityStatus.disconnected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Please connect to Internet")));
                        } else {
                          var login =
                              await FirebaseServices().signInWithGoogle();
                          if (login) {
                            AutoRouter.of(context)
                                .push(const SplashScreenRoute());
                            emailController.clear();
                            passwordController.clear();
                          }
                        }
                      },
                      child: Container(
                        height: 30.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color.fromARGB(255, 81, 87, 96)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/images/google.svg",
                              height: 20.h,
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            const Text("Continue With Google",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have account?",
                            style: TextStyle(fontSize: 15)),
                        const SizedBox(
                          width: 5,
                        ),
                        GestureDetector(
                          onTap: () {
                            AutoRouter.of(context)
                                .push(const SignUpScreenRoute());
                            emailController.clear();
                            passwordController.clear();
                          },
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                                color: Color(0XFF0063E6), fontSize: 17),
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
