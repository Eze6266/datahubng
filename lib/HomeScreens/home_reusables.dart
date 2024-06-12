// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';

class HomeWalletCard extends StatelessWidget {
  HomeWalletCard({
    super.key,
    required this.size,
    required this.balance,
    required this.onTap,
    required this.eye,
    required this.topup,
    required this.transClick,
  });

  final Size size;
  String balance;
  Function() onTap, topup, transClick;
  bool eye;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      height: 15 * size.height / 100,
      width: 95 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Colors.blue,
            Color.fromARGB(255, 9, 90, 155),
          ], // Define your gradient colors
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // Add more stops if needed
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                GestureDetector(
                  onTap: transClick,
                  child: Row(
                    children: [
                      Text(
                        'Transactions',
                        style: GoogleFonts.lato(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: Colors.white,
                        size: 14,
                      ),
                    ],
                  ),
                ),
                // Shimmer.fromColors(
                //   period: Duration(seconds: 3),
                //   baseColor: Colors.red,
                //   highlightColor: Color(0xffFFD700),
                //   child: Text(
                //     'DATAHUB',
                //     style: GoogleFonts.acme(
                //       textStyle: TextStyle(
                //         color: Color(0xffFFD700),
                //         // color: Color.fromARGB(255, 198, 204, 213),
                //         fontSize: 16,
                //         fontWeight: FontWeight.w500,
                //         fontStyle: FontStyle.italic,
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          HeightWidget(height: 3),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      eye ? '******' : 'N$balance',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    WidthWidget(width: 2),
                    GestureDetector(
                      onTap: onTap,
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
                GestureDetector(
                  onTap: topup,
                  child: Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(5),
                    child: Container(
                      height: 4 * size.height / 100,
                      width: 30 * size.width / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.blue,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 18,
                          ),
                          WidthWidget(width: 1),
                          Text(
                            'Top-Up',
                            style: GoogleFonts.acme(
                              textStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ServicesBoxes extends StatelessWidget {
  ServicesBoxes({
    super.key,
    required this.size,
    required this.service,
    required this.iconType,
    required this.boxColor,
    required this.iconColor,
    required this.onTap,
  });

  final Size size;
  String service;
  IconData iconType;
  Color boxColor, iconColor;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(2),
        height: 9 * size.height / 100,
        width: 24 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.brown.shade100,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconType,
              size: 18,
              color: Colors.black,
            ),
            HeightWidget(height: 0.5),
            Text(
              '$service',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopProvidersShit extends StatelessWidget {
  TopProvidersShit({
    super.key,
    required this.size,
    required this.colorType,
    required this.provider,
    required this.imgUrl,
  });

  final Size size;
  String provider, imgUrl;
  Color colorType;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5 * size.width / 100),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 4 * size.height / 100,
            width: 9 * size.width / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              image: DecorationImage(
                image: AssetImage('assets/images/$imgUrl'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          HeightWidget(height: 0.3),
          Text(
            '$provider',
            style: GoogleFonts.aBeeZee(
              textStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 10,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TransactionsTile extends StatelessWidget {
  TransactionsTile({
    super.key,
    required this.size,
    required this.amount,
    required this.date,
    required this.img,
    required this.subs,
    required this.title,
  });

  final Size size;
  String title, subs, img, amount, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2),
      height: 7 * size.height / 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                img,
                height: 5 * size.height / 100,
                width: 10 * size.width / 100,
                fit: BoxFit.cover,
              ),
              WidthWidget(width: 1),
              SizedBox(
                width: 38 * size.width / 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$title',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '$subs',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color.fromARGB(255, 97, 96, 96),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 40 * size.width / 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '-$amount',
                  style: GoogleFonts.acme(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
                Text(
                  '$date',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Color.fromARGB(255, 97, 96, 96),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class WalletTile extends StatelessWidget {
  WalletTile({
    super.key,
    required this.size,
    required this.amount,
    required this.date,
    required this.subs,
  });

  final Size size;
  String subs, amount, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4),
      height: 7 * size.height / 100,
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/pig.png',
                height: 5 * size.height / 100,
                width: 10 * size.width / 100,
              ),
              WidthWidget(width: 2),
              SizedBox(
                width: 38 * size.width / 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Top-up',
                      style: GoogleFonts.acme(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    Text(
                      '$subs',
                      style: GoogleFonts.aBeeZee(
                        textStyle: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 10,
                          color: Color.fromARGB(255, 97, 96, 96),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            width: 40 * size.width / 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$amount',
                  style: GoogleFonts.acme(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.green,
                    ),
                  ),
                ),
                Text(
                  '$date',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 10,
                      color: Color.fromARGB(255, 97, 96, 96),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
