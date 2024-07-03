import "package:auto_route/auto_route.dart";
import "package:counterapp/configs/routes/routes_import.gr.dart";
import "package:counterapp/features/auth/domain/usecases/google_auth.dart";
import "package:counterapp/features/auth/presentation/widgets/snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter_svg/flutter_svg.dart";
import "package:google_sign_in/google_sign_in.dart";

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
    setState(() {
      isLoading = true;
    });
    // signUp user using our authMethod
    String res = await AuthMethod().loginUser(
        email: emailController.text, password: passwordController.text);

    if (res == "success") {
      setState(() {
        isLoading = false;
      });
      // navigate to the home screen
      AutoRouter.of(context).push(const HomeScreenRoute());
      showSnackBar(context, "Login successful");
    } else {
      setState(() {
        isLoading = false;
      });
      // show error
      showSnackBar(context, res);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(33),
          child: Form(
            key: validkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(child: SvgPicture.asset("assets/images/Group 1.svg")),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  "Log In",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 10,
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
                const SizedBox(
                  height: 30,
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
                const SizedBox(
                  height: 50,
                ),
                GestureDetector(
                  onTap: () {
                    loginUser(context);
                    validkey.currentState!.validate();
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
                    height: 54,
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
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    var login = await FirebaseServices().signInWithGoogle();
                    if (login) {
                      AutoRouter.of(context).push(const HomeScreenRoute());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color.fromARGB(255, 81, 87, 96)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/google.svg",
                          height: 25,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("Continue With Google",
                            style:
                                TextStyle(fontSize: 15, color: Colors.white)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
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
                        AutoRouter.of(context).push(const SignUpScreenRoute());
                        emailController.clear();
                        passwordController.clear();
                      },
                      child: const Text(
                        "Sign Up",
                        style:
                            TextStyle(color: Color(0XFF0063E6), fontSize: 17),
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
  }
}