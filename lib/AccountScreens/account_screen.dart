// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations

import 'package:datahub/AuthScreens/login_screen.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var email = '';
  var phone = '';
  Future<void> initPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    email = pref.getString('email').toString();
    phone = pref.getString('phone').toString();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPref();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authApi = Provider.of<AuthProvider>(context);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.blue,
        title: PoppinsCustText(
          color: Colors.white,
          size: 16.0,
          text: 'Profile',
          weight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      backgroundColor: AppColors.bgColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
          child: Column(
            children: [
              HeightWidget(height: 2),
              AccountTiles(
                iconType: Icons.person,
                size: size,
                biz: '${authApi.userName ?? ''}',
                imgUrl: 'imgUrl[index]',
                subText: 'username',
                onTap: () {},
              ),
              HeightWidget(height: 2),
              AccountTiles(
                iconType: Icons.email,
                size: size,
                biz: '${authApi.email ?? ''}',
                imgUrl: 'imgUrl[index]',
                subText: 'email',
                onTap: () {},
              ),
              HeightWidget(height: 2),
              AccountTiles(
                iconType: Icons.phone,
                size: size,
                biz: '$phone',
                imgUrl: 'imgUrl[index]',
                subText: 'phone number',
                onTap: () {},
              ),
              HeightWidget(height: 10),
              GestureDetector(
                onTap: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  pref.clear();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Material(
                  elevation: 2,
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    width: 30 * size.width / 100,
                    height: 5 * size.height / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.red),
                      color: Colors.transparent,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'LOGOUT',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        WidthWidget(width: 2),
                        Icon(
                          Icons.logout,
                          color: Colors.red,
                          size: 22,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AccountTiles extends StatelessWidget {
  AccountTiles({
    super.key,
    required this.size,
    required this.biz,
    required this.imgUrl,
    required this.subText,
    required this.onTap,
    required this.iconType,
  });

  final Size size;
  String biz, subText, imgUrl;
  Function() onTap;
  IconData iconType;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(bottom: 2 * size.height / 100),
        child: Container(
          padding: EdgeInsets.all(10),
          height: 8 * size.height / 100,
          width: 93 * size.width / 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  WidthWidget(width: 2),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 55 * size.width / 100,
                        child: Text(
                          '$biz',
                          style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        '$subText',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                            color: const Color.fromARGB(255, 127, 126, 126),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Icon(
                iconType,
                color: AppColors.primaryColor,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
