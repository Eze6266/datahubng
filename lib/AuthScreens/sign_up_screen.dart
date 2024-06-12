// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:datahub/AuthScreens/second_signup2.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  bool isPasswordVisible = false;

  bool isLoading = false;
  bool userError = false;
  bool firstNameError = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: isLoading
          ? null
          : AppBar(
              elevation: 0,
              backgroundColor: AppColors.primaryColor,
              leading: Padding(
                padding: EdgeInsets.only(left: 30, top: 5),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              centerTitle: true,
              title: Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
      body: Padding(
        padding:
            EdgeInsets.only(left: 10, right: 10, top: 1 * size.height / 100),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Column(
              children: [
                Text(
                  "Create Account",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(height: 3 * size.height / 100),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                  child: TitleTextFieldTile(
                    size: size,
                    whichController: usernameController,
                    hint: 'Enter a username',
                    title: 'Username',
                    keyboardtype: TextInputType.text,
                    isloading: isLoading,
                    onChanged: (p0) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 3 * size.height / 100),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                  child: TitleTextFieldTile(
                    size: size,
                    whichController: firstNameController,
                    hint: 'Enter first name',
                    title: 'First Name',
                    keyboardtype: TextInputType.text,
                    isloading: isLoading,
                    onChanged: (p0) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 3 * size.height / 100),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                  child: TitleTextFieldTile(
                    size: size,
                    whichController: lastNameController,
                    hint: 'Enter a last name',
                    title: 'Last Name',
                    keyboardtype: TextInputType.text,
                    isloading: isLoading,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 3 * size.height / 100),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                  child: TitleTextFieldTile(
                    size: size,
                    whichController: phoneController,
                    hint: 'Enter phone number',
                    title: 'Phone number',
                    keyboardtype: TextInputType.number,
                    isloading: isLoading,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ),
                SizedBox(height: 6 * size.height / 100),
                GeneralButton(
                  size: size,
                  buttonColor: usernameController.text.isEmpty ||
                          firstNameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          phoneController.text.isEmpty
                      ? Colors.grey
                      : AppColors.primaryColor,
                  height: 7,
                  text: 'Continue',
                  width: 90,
                  onPressed: usernameController.text.isEmpty ||
                          firstNameController.text.isEmpty ||
                          lastNameController.text.isEmpty ||
                          phoneController.text.isEmpty
                      ? () {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: 'Make sure all fields are filled',
                            ),
                            dismissType: DismissType.onSwipe,
                          );
                        }
                      : () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUp2Screen(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                username: usernameController.text,
                                phone: phoneController.text,
                              ),
                            ),
                          );
                        },
                  isLoading: isLoading,
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
