// ignore_for_file: prefer_const_constructors

import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationBox extends StatelessWidget {
  NotificationBox({
    super.key,
    required this.size,
    required this.titles,
    required this.message,
  });

  final Size size;
  String titles, message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      width: 80 * size.width / 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue.shade100,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: Color(0xfffbbc05),
            radius: 20,
            backgroundImage: AssetImage('assets/images/avatar.png'),
          ),
          WidthWidget(width: 2),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                titles,
                style: GoogleFonts.acme(
                  textStyle: TextStyle(
                    color: Colors.black,
                    // color: Color.fromARGB(255, 198, 204, 213),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              HeightWidget(height: 2),
              SizedBox(
                width: 70 * size.width / 100,
                child: Text(
                  message,
                  style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
