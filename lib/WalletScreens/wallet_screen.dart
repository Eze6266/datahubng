// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:datahub/HomeScreens/home_reusables.dart';
import 'package:datahub/HomeScreens/top_up_screen.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:datahub/WalletScreens/all_wallet_trans.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  List subs = [
    'WEMA',
    'MONNIEPOINT',
    'STERLING',
    'MONNIEPOINT',
  ];
  List amount = [
    '-10,000',
    '+25,000',
    '-3,000',
    '-1,800',
  ];

  List dates = [
    '10:30am, 05 Dec 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
  ];
  String formatDate(String inputDate) {
    DateTime dateTime = DateTime.parse(inputDate);
    String formattedDate =
        DateFormat('d MMMM yyyy').format(dateTime); // Format: 8 May 2024
    String formattedTime =
        DateFormat('h:mma').format(dateTime); // Format: 12:19pm
    return '$formattedTime, $formattedDate';
  }

  bool eye = false;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authApi = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Wallet',
          style: GoogleFonts.aBeeZee(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            HeightWidget(height: 2),
            Center(
              child: Container(
                padding: EdgeInsets.all(5),
                height: 15 * size.height / 100,
                width: 90 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue,
                      Color.fromARGB(255, 9, 90, 155),
                    ], // Define your gradient colors
                    begin: Alignment.centerLeft,
                    end: Alignment.bottomRight,
                    // Add more stops if needed
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Wallet Balance',
                      style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    HeightWidget(height: 3),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          eye
                              ? '******'
                              : authApi.balance.toString() == '0' ||
                                      authApi.balance.toString() == 'null'
                                  ? '0'
                                  : authApi.balance.toString(),
                          style: GoogleFonts.acme(
                            textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        WidthWidget(width: 3),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              eye = !eye;
                            });
                          },
                          child: Icon(
                            eye
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            HeightWidget(height: 4),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Wallet Transactions',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => AllWalletTransScreen(),
                  //       ),
                  //     );
                  //   },
                  //   child: Text(
                  //     'See all',
                  //     style: GoogleFonts.aBeeZee(
                  //       textStyle: TextStyle(
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 12,
                  //         color: Colors.black,
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            HeightWidget(height: 0.5),
            authApi.topupTransactions.length == '0' ||
                    authApi.topupTransactions.length == 0 ||
                    authApi.topupTransactions.length == 'null' ||
                    authApi.topupTransactions.length == null
                ? Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/datahub.jpg',
                          height: 7 * size.height / 100,
                          width: 14 * size.width / 100,
                        ),
                        HeightWidget(height: 1),
                        Text(
                          'You have no recent topups',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                              color: Color.fromARGB(255, 97, 96, 96),
                            ),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  )
                : Expanded(
                    child: ListView.separated(
                      itemCount: authApi.topupTransactions.length,
                      itemBuilder: (context, index) {
                        return WalletTile(
                          amount: authApi.topupTransactions[index]['amount'],
                          date: formatDate(
                              authApi.topupTransactions[index]['createdAt']),
                          subs: '',
                          size: size,
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Divider(color: Colors.grey);
                      },
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
