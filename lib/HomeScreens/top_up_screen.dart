// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:clipboard/clipboard.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TopUpAccountScreen extends StatefulWidget {
  const TopUpAccountScreen({super.key});

  @override
  State<TopUpAccountScreen> createState() => _TopUpAccountScreenState();
}

class _TopUpAccountScreenState extends State<TopUpAccountScreen> {
  void copyToClipboard(BuildContext context, accountNumber) {
    FlutterClipboard.copy(accountNumber).then((value) {
      Fluttertoast.showToast(
        msg: "Account number copied",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.black.withOpacity(0.8),
        textColor: Colors.white,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var regUserApi = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 18,
              ),
            ),
            WidthWidget(width: 26),
            Text(
              'Wallet Top-up',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              HeightWidget(height: 2),
              FundingTipTag(size: size),
              HeightWidget(height: 3),
              AccountNumberCard(
                size: size,
                accNumber: regUserApi.transactionsaccNumbers,
                accName: regUserApi.accountName,
                bankName: regUserApi.userBankName,
                gradColor: Colors.orange,
                gradColor2: Colors.red,
                onTap: () {
                  copyToClipboard(context, regUserApi.transactionsaccNumbers);
                },
              ),
              HeightWidget(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
