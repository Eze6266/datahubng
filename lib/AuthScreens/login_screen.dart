// ignore_for_file: unused_local_variable, prefer_const_declarations, prefer_const_constructors

import 'dart:convert';

import 'package:datahub/AuthScreens/forgot_password.dart';
import 'package:datahub/AuthScreens/sign_up_screen.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../navbar.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // SESSION Step 1. Call SharedPreference and Initialize in init method
  late SharedPreferences prefs;

  Future<void> initPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    var mail = pref.getString('email');
    emailController.text =
        mail == 'null' || mail == '' || mail == null ? '' : mail;
  }
  // SESSION Step 2

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
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

  bool isPasswordVisible = false;
  bool emailError = true;
  bool passwordError = true;
  bool isLoading = false;
  DateTime currentTime = DateTime.now();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var loginUserApi = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).loginUserIsLoading;

    return WillPopScope(
      onWillPop: () async {
        final difference = DateTime.now().difference(currentTime);
        final isExitWarning = difference >= Duration(seconds: 2);
        currentTime = DateTime.now();
        if (isExitWarning) {
          final message = 'Press back again to exit';
          Fluttertoast.showToast(msg: message, fontSize: 14);
          return false;
        } else {
          SystemChannels.platform.invokeMethod('SystemNavigator.pop');
          return Future.value(false);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: AppColors.primaryColor,
          centerTitle: true,
          title: Text(
            'DataHubng',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 5 * size.width / 100),
            child: Column(
              children: [
                SizedBox(height: 3 * size.height / 100),
                Text(
                  "Login To Your Account",
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
                PasswordTitleTextFieldTile(
                  hint: 'Enter your password',
                  isPasswordVisible: isPasswordVisible,
                  size: size,
                  whichController: passwordController,
                  title: 'Password',
                  keyboardtype: TextInputType.text,
                  onChanged: (value) {
                    if (value.length < 6) {
                      passwordError = true;
                      setState(() {});
                    } else {
                      passwordError = false;
                      setState(() {});
                    }
                  },
                ),
                SizedBox(height: 2 * size.height / 100),
                Padding(
                  padding: EdgeInsets.only(right: 2 * size.width / 100),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen(),
                          ),
                        );
                      },
                      child: PoppinsCustText(
                        color: Colors.black,
                        size: 14.0,
                        text: 'Forgot password?',
                        weight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 3 * size.height / 100),
                GeneralButton(
                    isLoading: isLoading,
                    size: size,
                    buttonColor: emailError || passwordError
                        ? Color(0xffc2c4cf)
                        : AppColors.primaryColor,
                    height: 7,
                    text: 'Login',
                    width: 85,
                    onPressed: emailError || passwordError
                        ? () {}
                        : () async {
                            await loginUserApi
                                .loginUser(emailController.text,
                                    passwordController.text)
                                .then(
                              (value) async {
                                if (value == 'success') {
                                  isLoading = loginUserApi.getUserIsLoading;
                                  await loginUserApi
                                      .getUser(loginUserApi.loginUserId)
                                      .then((value) {
                                    if (value == 'success') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NavBar(chosenmyIndex: 0),
                                        ),
                                      );
                                    } else {
                                      showTopSnackBar(
                                        Overlay.of(context),
                                        CustomSnackBar.error(
                                          message: loginUserApi.getUserMessage,
                                        ),
                                        dismissType: DismissType.onSwipe,
                                      );
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              NavBar(chosenmyIndex: 0),
                                        ),
                                      );
                                    }
                                  });
                                } else {
                                  showTopSnackBar(
                                    Overlay.of(context),
                                    CustomSnackBar.error(
                                      message: loginUserApi.loginUserMessage,
                                    ),
                                    dismissType: DismissType.onSwipe,
                                  );
                                }
                              },
                            );
                          }),
                SizedBox(height: 5 * size.height / 100),
                RichText(
                  text: TextSpan(
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        color: Color(0xff8c8b90),
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    children: [
                      TextSpan(
                        text: "Don\'t have an account? ",
                      ),
                      TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpScreen(),
                              ),
                            );
                          },
                        text: 'Create account',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12 * size.height / 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
