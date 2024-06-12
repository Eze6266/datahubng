// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:datahub/AccountScreens/account_screen.dart';
import 'package:datahub/HomeScreens/home_screen.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/WalletScreens/wallet_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'TransactionsScreens/transactions_screen.dart';

class NavBar extends StatefulWidget {
  NavBar({super.key, required this.chosenmyIndex});
  int chosenmyIndex;
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int myIndex = 0;
  DateTime currentTime = DateTime.now();
  List<Widget> widgetList = [
    HomeScreen(),
    WalletScreen(),
    TransactionsScreen(),
    AccountScreen(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    myIndex = widget.chosenmyIndex;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
      child: Container(
        child: AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: AppColors.primaryColor,
            statusBarBrightness: Brightness.light,
          ),
          child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              selectedLabelStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: AppColors.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              selectedItemColor: AppColors.primaryColor,
              unselectedItemColor: Color(0xff626d7d),
              unselectedLabelStyle: GoogleFonts.poppins(
                textStyle: TextStyle(
                  color: Color(0xff626d7d),
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                ),
              ),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.white,
              showSelectedLabels: true,
              showUnselectedLabels: true,
              onTap: (index) {
                setState(() {
                  myIndex = index;
                });
              },
              currentIndex: myIndex,
              items: [
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.home_outlined,
                    color: AppColors.primaryColor,
                  ),
                  label: 'Home',
                  icon: Icon(
                    Icons.home_outlined,
                    color: Color(0xff626d7d),
                  ),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: AppColors.primaryColor,
                  ),
                  label: 'Wallet',
                  icon: Icon(
                    Icons.account_balance_wallet_outlined,
                    color: Color(0xff626d7d),
                  ),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.receipt_long_outlined,
                    color: AppColors.primaryColor,
                  ),
                  label: 'Transactions',
                  icon: Icon(
                    Icons.receipt_long_outlined,
                    color: Color(0xff626d7d),
                  ),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    Icons.person_outline,
                    color: AppColors.primaryColor,
                  ),
                  label: 'Profile',
                  icon: Icon(
                    Icons.person_outline,
                    color: Color(0xff626d7d),
                  ),
                ),
              ],
            ),
            body: widgetList[myIndex],
          ),
        ),
      ),
    );
  }
}
