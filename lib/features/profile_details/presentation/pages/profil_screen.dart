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

import '../../../../core/configs/components/commonbottomnavigationbar.dart';

@RoutePage()
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

DocumentSnapshot? docSnap;
class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<ProfiledataBloc>().add(ProfileInfoFetch());
  }

  String imageUrl = "";
  String imageUrl1 = "";

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.h),
          child: const CommonAppBar(
            screenName: "Profile",
            isProfile: true,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: BlocBuilder<ProfiledataBloc, ProfiledataState>(
                builder: (context,state) {
                  if (state is ProfileDataLoading) {
              nameController.text = state.docSnap?['name'];
              numberController.text = state.docSnap?['mobile'];
              emailController.text = state.docSnap?['email'];
              imageUrl = state.docSnap?['image'];
            }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      _buildProfileHeader(),
                      SizedBox(height: 20.h),
                      _buildPrimaryInfo(),
                      SizedBox(height: 20.h),
                      _buildUpdateButton(),
                    ],
                  );
                }
              ),
            ),
          ),
        ),
                        bottomNavigationBar: const Commonbottomnavigationbar(),


      ),
    );
  }

  bool isValidMobileNumber(String number) {
    final RegExp mobileRegex = RegExp(r'^\d{10}$');
    return mobileRegex.hasMatch(number);
  }

  bool isValidUsername(String username) {
    final validCharacters = RegExp(r'^[a-zA-Z_" "]+$');
    return username.length >= 3 &&
           username.length <= 20 &&
           validCharacters.hasMatch(username)&&
           username.contains(' ');
  }

  Widget _buildProfileHeader() {
    return Column(
      children: [
        BlocConsumer<ProfiledataBloc, ProfiledataState>(
          listener: (context, state) {
            if (state is ProfileImageLoading) {
              imageUrl1 = state.image;
            }
            if (state is ProfileDataLoading) {
              nameController.text = state.docSnap?['name'];
              numberController.text = state.docSnap?['mobile'];
              emailController.text = state.docSnap?['email'];
              imageUrl = state.docSnap?['image'];
            }
          },
          builder: (context, state) {
            return SizedBox(
              height: 50.h,
              width: double.infinity,
              child: imageUrl.isEmpty
                  ? SvgPicture.asset("assets/images/Isolation_Mode.svg")
                  : state is ProfileImageLoading
                      ? Image.file(File(state.image))
                      : Image.network(imageUrl),
            );
          },
        ),
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
                color: Theme.of(context).colorScheme.surface == Colors.grey.shade200
                    ? const Color.fromRGBO(23, 55, 175, 1)
                    : Colors.grey,
              ),
              borderRadius: BorderRadius.circular(200),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  "assets/images/Upload.svg",
                  color: Theme.of(context).colorScheme.surface == Colors.grey.shade200
                      ? const Color.fromRGBO(23, 55, 175, 1)
                      : Colors.grey,
                ),
                Text(
                  "Upload image",
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.surface == Colors.grey.shade200
                        ? const Color.fromRGBO(23, 55, 175, 1)
                        : Colors.grey,
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
            fontSize: 10.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Name",
          controller: nameController,
          hint: "Enter your name",
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your name';
            }
            if (!isValidUsername(value)) {
              return 'Invalid username';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Mobile Number",
          controller: numberController,
          hint: "Enter your phone number",
          keyboardType: TextInputType.number,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your phone number';
            }
            if (!isValidMobileNumber(value)) {
              return 'Invalid phone number';
            }
            return null;
          },
        ),
        const SizedBox(height: 20),
        _buildTextField(
          label: "Email",
          controller: emailController,
          hint: "Enter your email address",
          readOnly: true,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email address';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    bool readOnly = false,
    required String? Function(String?) validator,
  }) {
    return BlocConsumer<ProfiledataBloc, ProfiledataState>(
      listener: (context, state) {
        if (state is ProfileDataLoading) {
          // Handle loading state
        }
      },
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: keyboardType,
              readOnly: readOnly,
              controller: controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.surface == Colors.grey.shade200
                        ? Colors.blue
                        : Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide:const  BorderSide(
                    color: Colors.blue,
                  ),
                ),
                hintText: hint,
                hintStyle: GoogleFonts.poppins(
                  fontSize: 12.sp,
                ),
              ),
              validator: validator,
            ),
          ],
        );
      },
    );
  }

  Widget _buildUpdateButton() {
    return Column(
      children: [
        const Divider(color: Color.fromRGBO(29, 18, 18, 0.15)),
        GestureDetector(
          onTap: () async {
            if (_formKey.currentState?.validate() ?? false) {
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
              context.read<ProfiledataBloc>().add(ProfileInfoFetch());
              ScaffoldMessenger.of(context)
                  .showSnackBar(const SnackBar(content: Text("Data Saved")));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Enter Correct Details")));
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
        SizedBox(height: 20.h),
      ],
    );
  }

  Future<void> showOptionBottomSheet() async {
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
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 114, 182, 214),
                    ),
                  ),
                  child: const Icon(Icons.camera_alt, color: Colors.black),
                  onPressed: () async => await uploadPhoto("cam"),
                ),
                SizedBox(width: 30.w),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(
                      const Color.fromARGB(255, 114, 182, 214),
                    ),
                  ),
                  child: const Icon(Icons.photo, color: Colors.black),
                  onPressed: () async => await uploadPhoto("gallery"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> uploadPhoto(String option) async {
    final ImagePicker picker = ImagePicker();
    String uniqueFileName = DateTime.now().microsecondsSinceEpoch.toString();
    XFile? file = await picker.pickImage(
        source: option == "cam" ? ImageSource.camera : ImageSource.gallery);
    AutoRouter.of(context).popForced();
    if (file == null) return;

    Reference referenceToUpload =
        FirebaseStorage.instance.ref().child('images').child(uniqueFileName);

    try {
      context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));
      context.loaderOverlay.show();
      await referenceToUpload.putFile(File(file.path));
      imageUrl = await referenceToUpload.getDownloadURL();
      context.read<ProfiledataBloc>().add(ProfileUpdate(image: file.path));
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
      context.loaderOverlay.hide();
      log(imageUrl);
    } catch (e) {
      log("IN Catch");
      rethrow;
    }
  }
}
