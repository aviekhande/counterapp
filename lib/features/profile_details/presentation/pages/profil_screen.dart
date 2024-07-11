// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';
import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/core/configs/components/appbar_widget.dart';
import 'package:counterapp/features/auth/domain/usecases/sessioncontroller.dart';
import 'package:counterapp/features/profile_details/presentation/bloc/bloc/profiledata_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

DocumentSnapshot? docSnap;

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ProfiledataBloc>().add(ProfileInfoFetch());
  }

  String imageUrl = "";
  String imageUrl1 = "";
  // DocumentSnapshot? docSnap;
  // Future<DocumentSnapshot?> getUserData() async {
  //   await FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(SessionController().userId)
  //       .get()
  //       .then((value) {
  //     docSnap = value;
  //   });
  //   nameController.text = docSnap?['name'];
  //   numberController.text = docSnap?['mobile'];
  //   emailController.text = docSnap?['email'];
  //   imageUrl = docSnap?['image'];
  //   setState(() {});
  //   //  User user =U?ser.fromJson(!docSnap);
  //   return docSnap;
  // }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(40.h),
          child: const CommonAppBar(
            screenName: "Profile",
            isProfile: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.h,
                ),
                _buildProfileHeader(),
                SizedBox(height: 20.h),
                _buildPrimaryInfo(),
                SizedBox(height: 20.h),
                _buildUpdateButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isvalidedata() {
    if (nameController.text.isEmpty ||
        numberController.text.isEmpty ||
        emailController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        BlocConsumer<ProfiledataBloc, ProfiledataState>(
            listener: (context, state) {
          if (state is ProfileImageLoading) {
            imageUrl1 = state.image;
          }
        }, builder: (context, state) {
          if (state is ProfileDataLoading) {
            imageUrl = state.docSnap?['image'];
          }
          if (state is ProfileImageLoading) {
            imageUrl1 = state.image;
          }
          return Builder(builder: (context) {
            return SizedBox(
                height: 50.h,
                width: double.infinity,
                child: imageUrl.isEmpty
                    ? SvgPicture.asset(
                        "assets/images/Isolation_Mode.svg",
                      )
                    : state is ProfileImageLoading
                        ? Image.file(File(state.image))
                        : Image.network(imageUrl));
          });
        }),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            await showOptionBottomSheet();
          },
          child: Container(
            width: 122.w,
            height: 34.h,
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(23, 55, 175, 1),
              ),
              borderRadius: BorderRadius.circular(200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset("assets/images/Upload.svg"),
                Text(
                  "Upload image",
                  style: GoogleFonts.poppins(
                    color: const Color.fromRGBO(23, 55, 175, 1),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w500,
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryInfo() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(color: Color.fromRGBO(29, 18, 18, 0.1)),
        const SizedBox(height: 18),
        Text(
          "Primary info",
          style: GoogleFonts.poppins(
            color: const Color.fromRGBO(29, 18, 18, 0.75),
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        _buildTextField(
          "name",
          nameController,
          "Enter your name",
        ),
        const SizedBox(height: 20),
        _buildTextField(
          "mobile",
          numberController,
          "Enter your phone number",
        ),
        const SizedBox(height: 20),
        _buildTextField(
          "email",
          emailController,
          "Enter your email address",
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return BlocConsumer<ProfiledataBloc, ProfiledataState>(
      listener: (context, state) {
        //  if (state is ProfileDataLoading) {
        //   print("In ProfileLoadinc");
        //   nameController.text = state.docSnap?['name'];
        //   numberController.text = state.docSnap?['mobile'];
        //   emailController.text = state.docSnap?['email'];
        //   imageUrl = state.docSnap?['image'];
        // }
      },
      builder: (context, state) {
        if (state is ProfileDataLoading) {
          nameController.text = state.docSnap?['name'];
          numberController.text = state.docSnap?['mobile'];
          emailController.text = state.docSnap?['email'];
          imageUrl = state.docSnap?['image'];
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                color: const Color.fromRGBO(18, 23, 29, 1),
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: EdgeInsets.only(left: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                color: const Color.fromRGBO(18, 23, 29, 0.05),
                border:
                    Border.all(color: const Color.fromRGBO(18, 23, 29, 0.1)),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      keyboardType: label == "Mobile Number"
                          ? TextInputType.number
                          : TextInputType.text,
                      readOnly: label == "Email",
                      controller: controller,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: hint,
                        hintStyle: GoogleFonts.poppins(
                          fontSize: 12.sp,
                          color: const Color.fromRGBO(18, 23, 29, 0.25),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildUpdateButton() {
    return Column(
      children: [
        const Divider(
          color: Color.fromRGBO(29, 18, 18, 0.15),
        ),
        GestureDetector(
          onTap: () async {
            if (isvalidedata()) {
              await FirebaseFirestore.instance
                  .collection("users")
                  .doc(SessionController().userId)
                  .set({
                "image": imageUrl,
                "mobile": numberController.text,
                'name': nameController.text,
                'uid': SessionController().userId,
                'email': emailController.text,
              });
              log("$imageUrl>>>>>>>>>>>>>>>>>>");
              context.read<ProfiledataBloc>().add(ProfileInfoFetch());
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Data Save")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter All Details")));
            }
          },
          child: Container(
            padding: const EdgeInsets.all(12),
            color: const Color.fromARGB(255, 114, 182, 214),
            child: Center(
              child: Text(
                "Update Changes",
                style: GoogleFonts.exo(
                    fontWeight: FontWeight.w600,
                    color: const Color.fromRGBO(249, 242, 242, 1)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 20.h,
        ),
      ],
    );
  }

  Future<String> showOptionBottomSheet() async {
    var check = "";
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 100,
          child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 114, 182, 214))),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.black,
                  ),
                  onPressed: () async => await upLoadPhoto("cam"),
                ),
                SizedBox(
                  width: 30.w,
                ),
                ElevatedButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(
                          Color.fromARGB(255, 114, 182, 214))),
                  child: const Icon(
                    Icons.photo,
                    color: Colors.black,
                  ),
                  onPressed: () async => await upLoadPhoto("gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
    return check;
  }

  Future<void> upLoadPhoto(option) async {
    final ImagePicker picker = ImagePicker();
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    XFile? file = await picker.pickImage(
        source: option == "cam" ? ImageSource.camera : ImageSource.gallery);
    AutoRouter.of(context).popForced();
    Reference referenceToUpload =
        FirebaseStorage.instance.ref().child('images').child(uniqueFileName);
    if (file == null) return;
    try {
      context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));
      context.loaderOverlay.show();
      await referenceToUpload.putFile(File(file.path));
      imageUrl = await referenceToUpload.getDownloadURL();
      context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));
      context.loaderOverlay.hide();
      log(imageUrl);
    } catch (e) {
      log("IN Catch");
      rethrow;
    }
  }
}
