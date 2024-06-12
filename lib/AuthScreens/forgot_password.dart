// ignore_for_file: prefer_const_constructors

import 'package:datahub/AuthScreens/reset_password.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();

  String _validationResult = '';

  bool _validateEmail(String email) {
    // Basic email format validation using a regular expression
    final RegExp emailRegExp = RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
    return emailRegExp.hasMatch(email);
  }

  void _validateAndShowResult() {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      setState(() {
        _validationResult = 'Email cannot be empty';
      });
    } else if (!_validateEmail(email)) {
      setState(() {
        _validationResult = 'Invalid email format';
      });
    } else {
      setState(() {
        _validationResult = 'Email is valid';
      });
    }
  }

  bool isLoading = false;
  bool emailError = false;
  @override
  Widget build(BuildContext context) {
    var forgotPwdApi = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).forgotPwdIsLoading;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        centerTitle: true,
        title: Text(
          'Forgot Password',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              SizedBox(height: 3 * size.height / 100),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Input your DataHubng email",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              HeightWidget(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "An OTP will be sent to ur inbox, use that to reset your password",
                  textAlign: TextAlign.left,
                  style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 3 * size.height / 100),
              TitleTextFieldTile(
                isloading: isLoading,
                size: size,
                whichController: emailController,
                hint: 'Type your email address',
                title: 'Email',
                keyboardtype: TextInputType.emailAddress,
                onChanged: (value) {
                  _validateAndShowResult();
                  if (_validationResult == 'Email is valid') {
                    emailError = false;
                  } else {
                    emailError = true;
                  }
                },
              ),
              SizedBox(height: 3 * size.height / 100),
            ],
          ),
        ),
      ),
      floatingActionButton: GeneralButton(
        isLoading: isLoading,
        size: size,
        buttonColor: emailError ? Color(0xffc2c4cf) : AppColors.primaryColor,
        height: 7,
        text: 'Continue',
        width: 85,
        onPressed: emailError
            ? () {
                showTopSnackBar(
                  Overlay.of(context),
                  CustomSnackBar.error(
                    message: 'Enter a valid email',
                  ),
                  dismissType: DismissType.onSwipe,
                );
              }
            : () async {
                await forgotPwdApi
                    .forgotPassword(emailController.text)
                    .then((value) {
                  if (value == '200' || value == '201') {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.success(
                        message: 'Reset mail sent',
                      ),
                      dismissType: DismissType.onSwipe,
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ResetPasswordScreen(),
                      ),
                    );
                  } else if (value == '500') {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: 'Email is no registered',
                      ),
                      dismissType: DismissType.onSwipe,
                    );
                  } else {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: forgotPwdApi.forgotPwdMessage,
                      ),
                      dismissType: DismissType.onSwipe,
                    );
                  }
                });
              },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
