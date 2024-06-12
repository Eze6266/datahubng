// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';

import '../HomeScreens/top_up_screen.dart';

class HeightWidget extends StatelessWidget {
  HeightWidget({
    super.key,
    required this.height,
  });
  var height;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(height: height * size.height / 100);
  }
}

class WidthWidget extends StatelessWidget {
  WidthWidget({
    super.key,
    required this.width,
  });
  var width;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(width: width * size.width / 100);
  }
}

class PoppinsCustText extends StatelessWidget {
  PoppinsCustText({
    super.key,
    required this.color,
    required this.size,
    required this.text,
    required this.weight,
  });
  String text;
  Color color;
  var size;
  FontWeight weight;
  @override
  Widget build(BuildContext context) {
    return Text(
      '$text',
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: weight,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

class CustomPopAppBar extends StatelessWidget {
  CustomPopAppBar({
    super.key,
    required this.pad,
    required this.text,
  });
  String text;
  var pad;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        WidthWidget(width: pad),
        Text(
          '$text',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}

class TitleTextFieldTile extends StatelessWidget {
  TitleTextFieldTile({
    super.key,
    required this.size,
    required this.whichController,
    required this.hint,
    required this.title,
    required this.keyboardtype,
    this.onChanged,
    required this.isloading,
    this.textColor,
  });

  final Size size;
  final TextEditingController whichController;
  String hint;
  String title;
  TextInputType keyboardtype;
  void Function(String)? onChanged;
  bool isloading;
  Color? textColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1 * size.width / 100),
            child: Align(
              alignment: Alignment.centerLeft,
              child: PoppinsCustText(
                color: Colors.black,
                size: 12.0,
                text: title,
                weight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 0.5 * size.height / 100),
          SizedBox(
            width: 90 * size.width / 100,
            height: 7 * size.height / 100,
            child: TextFormField(
              onChanged: onChanged,
              enabled: isloading ? false : true,
              showCursor: true,
              cursorColor: Colors.grey,
              controller: whichController,
              keyboardType: keyboardtype,
              style: TextStyle(color: textColor ?? Colors.black),
              decoration: InputDecoration(
                fillColor: Color(0xfff8f8f8),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff92a4b5),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(),
                ),
                hintText: '$hint',
                hintStyle: TextStyle(
                  color: Color(0xffc2c4cf),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff92a4b5),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FundingTipTag extends StatelessWidget {
  const FundingTipTag({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
        height: 7 * size.height / 100,
        width: 90 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.primaryColor,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: Color.fromARGB(255, 148, 205, 251),
              radius: 18,
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
            WidthWidget(width: 2),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                PoppinsCustText(
                  color: Colors.white,
                  size: 14.0,
                  text: 'Funding Tip',
                  weight: FontWeight.w500,
                ),
                SizedBox(
                  width: 70 * size.width / 100,
                  child: PoppinsCustText(
                    color: Colors.white,
                    size: 10.0,
                    text:
                        'Transfer to the virtual account number below to fund your account',
                    weight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class AccountNumberCard extends StatelessWidget {
  AccountNumberCard({
    super.key,
    required this.size,
    required this.accName,
    required this.accNumber,
    required this.bankName,
    required this.gradColor,
    required this.gradColor2,
    required this.onTap,
  });

  final Size size;

  String accNumber, accName, bankName;
  Color gradColor, gradColor2;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      height: 18 * size.height / 100,
      width: 90 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        // color: Colors.orange,
        gradient: LinearGradient(
          colors: [gradColor, gradColor2], // Define your gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PoppinsCustText(
                color: Colors.white,
                size: 13.0,
                text: 'Virtual Account',
                weight: FontWeight.w400,
              ),
              PoppinsCustText(
                color: Colors.white,
                size: 14.0,
                text: '$bankName',
                weight: FontWeight.w500,
              ),
            ],
          ),
          HeightWidget(height: 2),
          Align(
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.all(5),
                height: 4.5 * size.height / 100,
                width: 35 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$accNumber',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WidthWidget(width: 2),
                    SvgPicture.asset(
                      'assets/icons/copy.svg',
                      color: Colors.white,
                      height: 2 * size.height / 100,
                      width: 3 * size.width / 100,
                    ),
                  ],
                ),
              ),
            ),
          ),
          HeightWidget(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              PoppinsCustText(
                color: Colors.white,
                size: 13.0,
                text: 'Acc name',
                weight: FontWeight.w400,
              ),
              PoppinsCustText(
                color: Colors.white,
                size: 14.0,
                text: '$accName',
                weight: FontWeight.w500,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class GeneralButton extends StatelessWidget {
  GeneralButton({
    super.key,
    required this.size,
    required this.buttonColor,
    required this.height,
    required this.text,
    required this.width,
    required this.onPressed,
    required this.isLoading,
  });

  final Size size;
  String text;
  Color buttonColor;
  int width;
  int height;
  final VoidCallback? onPressed;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height * size.height / 100,
        width: width * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: buttonColor,
        ),
        child: Center(
          child: isLoading
              ? SizedBox(
                  height: 2 * size.height / 100,
                  width: 4 * size.width / 100,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : PoppinsCustText(
                  color: Colors.white,
                  size: 16.0,
                  text: text,
                  weight: FontWeight.w400,
                ),
        ),
      ),
    );
  }
}

class SuccessPopupCard extends StatelessWidget {
  SuccessPopupCard({
    super.key,
    required this.size,
    required this.textcontent,
  });

  final Size size;

  String textcontent;

  @override
  Widget build(BuildContext context) {
    void _shareText() {
      Share.share('Transaction Receipt $textcontent!');
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: Colors.white,
      ),
      width: 100 * size.width / 100,
      height: 100 * size.height / 100,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            HeightWidget(height: 10),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Text(
            //       'Successful',
            //       style: TextStyle(
            //         color: Colors.black,
            //         fontSize: 19,
            //         fontWeight: FontWeight.w600,
            //       ),
            //     ),
            //   ],
            // ),
            // SizedBox(height: 3 * size.height / 100),
            // Align(
            //   alignment: Alignment.centerLeft,
            //   child: Container(
            //     height: 3,
            //     width: 18 * size.width / 100,
            //     decoration: BoxDecoration(
            //       color: Colors.green.shade700,
            //       borderRadius: BorderRadius.circular(100),
            //     ),
            //   ),
            // ),

            Image.asset(
              'assets/images/headd.png',
              height: 130,
              width: 130,
            ),
            SizedBox(height: 1 * size.height / 100),
            Text(
              '$textcontent',
              style: GoogleFonts.harmattan(
                textStyle: TextStyle(
                  color: Color.fromARGB(255, 81, 79, 79),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 3 * size.height / 100),
            // GestureDetector(
            //   onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => NavBar(chosenmyIndex: 0),
            //   ),
            // );
            //   },
            //   child: Material(
            //     borderRadius: BorderRadius.circular(100),
            //     child: Container(
            //       height: 5.5 * size.height / 100,
            //       width: 65 * size.width / 100,
            //       decoration: BoxDecoration(
            //         color: Colors.white,
            //         borderRadius: BorderRadius.circular(100),
            //         border: Border.all(color: Colors.blue),
            //       ),
            //       child: Center(
            //         child: Text(
            //           'OK',
            //           style: TextStyle(
            //             color: Colors.blue,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            SizedBox(height: 3 * size.height / 100),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NavBar(chosenmyIndex: 0),
                  ),
                );
              },
              child: Material(
                elevation: 2,
                borderRadius: BorderRadius.circular(100),
                child: Container(
                  height: 5.5 * size.height / 100,
                  width: 65 * size.width / 100,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: Colors.blue),
                  ),
                  child: Center(
                    child: Text(
                      'Back To Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5 * size.height / 100),
          ],
        ),
      ),
    );
  }
}

class BalanceAndFundRow extends StatelessWidget {
  BalanceAndFundRow({
    super.key,
  });

  String formatToTwoSF(String input) {
    // Check if the input contains a decimal point
    if (input.contains('.')) {
      // Split the input into integer and fractional parts
      List<String> parts = input.split('.');
      String integerPart = parts[0];
      String fractionalPart = parts[1];

      // If fractional part has more than 2 digits, round it to two significant figures
      if (fractionalPart.length > 2) {
        fractionalPart = fractionalPart.substring(0, 2);
        // Round the last digit
        if (int.parse(fractionalPart[1]) >= 5) {
          int digit = int.parse(fractionalPart[0]) + 1;
          fractionalPart = digit.toString();
        } else {
          fractionalPart = fractionalPart[0];
        }
      }
      return '$integerPart.$fractionalPart';
    }
    // If input does not contain a decimal point, return as it is
    return input;
  }

  @override
  Widget build(BuildContext context) {
    var balanceApi = Provider.of<AuthProvider>(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Wallet Balance:',
              style: GoogleFonts.poppins(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ),
            WidthWidget(width: 1),
            Text(
              'N${formatToTwoSF(balanceApi.balance.toString())}',
              style: GoogleFonts.acme(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
        // GestureDetector(
        //   onTap: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //         builder: (context) => TopUpAccountScreen(),
        //       ),
        //     );
        //   },
        //   child: Text(
        //     'FUND WALLET',
        //     style: GoogleFonts.acme(
        //       textStyle: TextStyle(
        //         fontWeight: FontWeight.w500,
        //         fontSize: 12,
        //         color: AppColors.primaryColor,
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

class VerificationRow extends StatelessWidget {
  VerificationRow({
    super.key,
    required this.size,
    required this.idVerified,
    required this.onTap,
    required this.isLoading,
  });

  final Size size;
  final bool idVerified;
  Function() onTap;
  bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 3.5 * size.height / 100,
              width: 20 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: AppColors.primaryColor,
              ),
              child: Center(
                child: isLoading
                    ? SizedBox(
                        height: 2 * size.height / 100,
                        width: 4 * size.width / 100,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        'Check',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            // color: Color.fromARGB(255, 198, 204, 213),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
              ),
            ),
          ),
          idVerified
              ? Material(
                  elevation: 1,
                  borderRadius: BorderRadius.circular(6),
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.blue,
                    child: Icon(
                      Icons.check,
                      size: 12,
                      color: Colors.white,
                    ),
                  ),
                )
              : SizedBox.shrink(),
        ],
      ),
    );
  }
}

class PasswordTitleTextFieldTile extends StatefulWidget {
  PasswordTitleTextFieldTile({
    super.key,
    required this.size,
    required this.whichController,
    required this.hint,
    required this.title,
    required this.keyboardtype,
    required this.isPasswordVisible,
    required this.onChanged,
  });

  final Size size;
  final TextEditingController whichController;
  String hint;
  String title;
  TextInputType keyboardtype;
  bool isPasswordVisible;
  final void Function(String) onChanged;

  @override
  State<PasswordTitleTextFieldTile> createState() =>
      _PasswordTitleTextFieldTileState();
}

class _PasswordTitleTextFieldTileState
    extends State<PasswordTitleTextFieldTile> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1 * widget.size.width / 100),
            child: Align(
              alignment: Alignment.centerLeft,
              child: PoppinsCustText(
                color: Colors.black,
                size: 12.0,
                text: widget.title,
                weight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 0.5 * widget.size.height / 100),
          SizedBox(
            width: 90 * widget.size.width / 100,
            child: TextFormField(
              onChanged: widget.onChanged,
              obscuringCharacter: '*',
              obscureText: widget.isPasswordVisible,
              showCursor: true,
              cursorColor: Colors.grey,
              controller: widget.whichController,
              keyboardType: widget.keyboardtype,
              decoration: InputDecoration(
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.isPasswordVisible = !widget.isPasswordVisible;
                    });
                  },
                  child: Icon(
                    widget.isPasswordVisible
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 18,
                    color: Colors.black,
                  ),
                ),
                fillColor: Color(0xfff8f8f8),
                filled: true,
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff92a4b5),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(),
                ),
                hintText: '${widget.hint}',
                hintStyle: TextStyle(
                  color: Color(0xffc2c4cf),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xff92a4b5),
                    width: 0.5,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AuthMessageTitle extends StatelessWidget {
  AuthMessageTitle({
    super.key,
    required this.size,
    required this.subtext,
    required this.title,
    required this.lastText,
  });

  final Size size;
  String title;
  String subtext;
  String lastText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: SizedBox(
            width: 85 * size.width / 100,
            child: PoppinsCustText(
              color: Colors.black,
              size: 18.0,
              text: title,
              weight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(height: 2 * size.height / 100),
        SizedBox(
          width: 85 * size.width / 100,
          child: PoppinsCustText(
            color: Color(0xff8c8b90),
            size: 14.0,
            text: subtext,
            weight: FontWeight.w400,
          ),
        ),
        PoppinsCustText(
          color: Color(0xff0d0d0d),
          size: 14.0,
          text: lastText,
          weight: FontWeight.w400,
        ),
      ],
    );
  }
}

class OTPBoxes extends StatelessWidget {
  const OTPBoxes({
    super.key,
    required this.size,
    required this.pinController,
  });

  final Size size;
  final TextEditingController pinController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 8 * size.height / 100,
      width: 16 * size.width / 100,
      child: TextField(
        showCursor: false,
        controller: pinController,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
        ],
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          hintText: '-',
          hintStyle: TextStyle(fontSize: 13),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.primaryColor,
              width: 1.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xffd2d2d2),
              width: 1.0,
            ),
          ),
          filled: true,
          fillColor: Colors.white,
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12),
        ),
      ),
    );
  }
}
