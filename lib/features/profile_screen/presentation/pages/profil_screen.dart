import 'dart:developer';
import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:counterapp/configs/components/appbar_widget.dart';
import 'package:counterapp/features/auth/domain/usecases/sessioncontroller.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

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
    getUserData();
  }

  String imageUrl = "";
  // DocumentSnapshot? docSnap;
  Future<DocumentSnapshot?> getUserData() async {
    await FirebaseFirestore.instance
        .collection("profile")
        .doc(SessionController().userId)
        .get()
        .then((value) {
      docSnap = value;
    });
    nameController.text = docSnap?['name'];
    numberController.text = docSnap?['mobile'];
    emailController.text = docSnap?['email'];
    imageUrl = docSnap?['image'];
    setState(() {});
    //  User user =U?ser.fromJson(!docSnap);
    return docSnap;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }

  bool isvalidedata() {
    if (nameController.text.isEmpty ||
        nameController.text.isEmpty ||
        emailController.text.isEmpty) {
      return false;
    }
    return true;
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        SizedBox(
          height: 50.h,
          width: double.infinity,
          child: imageUrl.isEmpty
              ? SvgPicture.asset(
                  "assets/images/Isolation_Mode.svg",
                )
              : Image.network(imageUrl),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            final ImagePicker picker = ImagePicker();
            String uniqueFileName =
                DateTime.now().microsecondsSinceEpoch.toString();
            XFile? file = await picker.pickImage(source: ImageSource.camera);
            Reference referenceToUpload = FirebaseStorage.instance
                .ref()
                .child('images')
                .child(uniqueFileName);
            if (file == null) return;
            try {
              await referenceToUpload.putFile(File(file.path));
              imageUrl = await referenceToUpload.getDownloadURL();
            } catch (e) {
              log("IN Catch");
              rethrow;
            }
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
            "Name", nameController, "Enter your name", "profile.svg"),
        const SizedBox(height: 20),
        _buildTextField("Mobile Number", numberController,
            "Enter your phone number", "call.svg"),
        const SizedBox(height: 20),
        _buildTextField(
            "Email", emailController, "Enter your email address", "email.svg"),
      ],
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      String hint, String icon) {
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
            border: Border.all(color: const Color.fromRGBO(18, 23, 29, 0.1)),
          ),
          child: Row(
            children: [
              // SvgPicture.asset("assets/images/$icon"),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
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
  }

  Widget _buildUpdateButton() {
    return Column(
      children: [
        const Divider(
          color: Color.fromRGBO(29, 18, 18, 0.15),
        ),
        GestureDetector(
          onTap: () {
            if (isvalidedata()) {
              FirebaseFirestore.instance
                  .collection("profile")
                  .doc(SessionController().userId)
                  .set({
                "name": nameController.text,
                "email": emailController.text,
                "mobile": numberController.text,
                "image": imageUrl
              });
              FirebaseFirestore.instance
                  .collection("users")
                  .doc(SessionController().userId)
                  .set({
                'name': nameController.text,
                'uid': SessionController().userId,
                'email': emailController.text,
              });
              setState(() {});
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
}
