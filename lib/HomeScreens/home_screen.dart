// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, unnecessary_string_interpolations, use_build_context_synchronously

import 'package:datahub/HomeScreens/BuyAirtimeScreens/airtime_screen.dart';
import 'package:datahub/HomeScreens/CableTvScreens/cable_tv_screen.dart';
import 'package:datahub/HomeScreens/DataScreens/data_screens.dart';
import 'package:datahub/HomeScreens/ElectrictyScreens/electricity_screen.dart';
import 'package:datahub/HomeScreens/NotificationScreens/notification_screen.dart';
import 'package:datahub/HomeScreens/home_reusables.dart';
import 'package:datahub/HomeScreens/top_up_screen.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/TransactionsScreens/transactions_screen.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:datahub/navbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:text_scroll/text_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool eye = false;
  String greeting = 'Good Day';
  String getGreeting() {
    var hour = DateTime.now().hour;
    if (hour >= 0 && hour < 12) {
      setState(() {});
      return greeting = 'Good Morning';
    } else if (hour >= 12 && hour < 17) {
      setState(() {});
      return greeting = 'Good Afternoon';
    } else {
      setState(() {});
      return greeting = 'Good Evening';
    }
  }

  List imgs = [
    'assets/images/elek.png',
    'assets/images/pig.png',
    'assets/images/pig.png',
    'assets/images/tv.png',
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<AuthProvider>(context, listen: false).getUser(
          Provider.of<AuthProvider>(context, listen: false).loginUserId);
      Provider.of<AuthProvider>(context, listen: false).getUserTransactions(
          Provider.of<AuthProvider>(context, listen: false).loginUserId);
    });
    super.initState();
  }

  bool isLoading = false;

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

  // double addTenPercent(String input) {
  //   // Convert the input to double
  //   double number = double.tryParse(input) ?? 0.0;
  //   // Add 10% to the number
  //   double resultValue = number * 1.1;
  //   return resultValue;
  // }

  int roundToWholeNumber(String input) {
    // Convert the input to double
    double number = double.tryParse(input) ?? 0.0;
    // Round the number to the nearest whole number
    int roundedNumber = number.round();
    return roundedNumber;
  }

  @override
  Widget build(BuildContext context) {
    getGreeting();
    Size size = MediaQuery.of(context).size;
    var authApi = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).getUserIsLoading;
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.bgColor,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
          child: Column(
            children: [
              HeightWidget(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      // CircleAvatar(
                      //   backgroundColor: Color(0xfffbbc05),
                      //   radius: 20,
                      //   backgroundImage: AssetImage('assets/images/avatar.png'),
                      // ),
                      WidthWidget(width: 1),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          PoppinsCustText(
                            color: Colors.black,
                            size: 14.0,
                            text: '$greeting ${authApi.userName ?? ''}',
                            weight: FontWeight.w400,
                          ),
                          HeightWidget(height: 0.3),
                          PoppinsCustText(
                            color: Color(0xff8c8b90),
                            size: 10.0,
                            text: 'Welcome to DataHubng',
                            weight: FontWeight.w400,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // GestureDetector(
                  //   onTap: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) => NotificationScreen(),
                  //       ),
                  //     );
                  //   },
                  //   child: FaIcon(
                  //     FontAwesomeIcons.bell,
                  //     size: 20,
                  //     color: Colors.black,
                  //   ),
                  // ),
                ],
              ),
              HeightWidget(height: 2),
              HomeWalletCard(
                size: size,
                eye: eye,
                balance: authApi.balance.toString() == '0' ||
                        authApi.balance.toString() == 'null'
                    ? '0'
                    : formatToTwoSF(authApi.balance.toString()),
                onTap: () {
                  setState(() {
                    eye = !eye;
                  });
                },
                topup: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpAccountScreen(),
                    ),
                  );
                },
                transClick: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NavBar(chosenmyIndex: 1),
                    ),
                  );
                },
              ),
              HeightWidget(height: 2),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Services',
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              HeightWidget(height: 0.1),
              Container(
                padding: EdgeInsets.all(8),
                height: 24 * size.height / 100,
                width: 95 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Color.fromARGB(255, 9, 90, 155),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ServicesBoxes(
                          size: size,
                          service: 'Airtime Top-up',
                          iconType: Icons.phone_outlined,
                          boxColor: Color.fromARGB(255, 127, 181, 226),
                          iconColor: Colors.pink,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AirtimeScreens(),
                              ),
                            );
                          },
                        ),
                        ServicesBoxes(
                          size: size,
                          service: 'Data Bundle',
                          iconType: Icons.wifi,
                          boxColor: Colors.green.shade100,
                          iconColor: Colors.green,
                          onTap: () async {
                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            var userid = pref.getString('userid');
                            print(userid);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DataScreen(
                                  userid: userid,
                                ),
                              ),
                            );
                          },
                        ),
                        ServicesBoxes(
                          size: size,
                          service: 'Cable TV',
                          iconType: Icons.live_tv_outlined,
                          boxColor: Colors.orange.shade100,
                          iconColor: Colors.orange,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CableTvScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    HeightWidget(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ServicesBoxes(
                          size: size,
                          service: 'Electricity',
                          iconType: Icons.tips_and_updates_outlined,
                          boxColor: Colors.purple.shade100,
                          iconColor: Colors.purple,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ElectricityScreen(),
                              ),
                            );
                          },
                        ),
                        Container(
                          height: 9 * size.height / 100,
                          width: 24 * size.width / 100,
                        ),
                        // ServicesBoxes(
                        //   size: size,
                        //   service: 'Bulk SMS',
                        //   iconType: Icons.contact_mail_outlined,
                        //   boxColor: Colors.indigo.shade100,
                        //   iconColor: Colors.indigo,
                        //   onTap: () {},
                        // ),
                        Container(
                          height: 9 * size.height / 100,
                          width: 24 * size.width / 100,
                        ),
                        // ServicesBoxes(
                        //   size: size,
                        //   service: 'Gift Cards',
                        //   iconType: Icons.request_quote_outlined,
                        //   boxColor: Colors.brown.shade100,
                        //   iconColor: Colors.brown,
                        //   onTap: () {},
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
              HeightWidget(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Recent Transactions',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavBar(chosenmyIndex: 2),
                        ),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'See more',
                          style: GoogleFonts.aBeeZee(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black,
                          size: 12,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              HeightWidget(height: 0.2),
              isLoading
                  ? Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SpinKitCircle(
                            color: Colors.blue,
                          ),
                          Text(
                            'Loading...',
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
                    ) // Show loading indicator
                  : authApi.billTransactions.length == '0' ||
                          authApi.billTransactions.length == 0 ||
                          authApi.billTransactions.length == 'null' ||
                          authApi.billTransactions.length == null
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
                                'You have no recent transactions',
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
                            itemCount: authApi.billTransactions.length < 5
                                ? authApi.billTransactions.length
                                : 5,
                            itemBuilder: (context, index) {
                              return TransactionsTile(
                                amount: authApi.billTransactions[index]
                                            ['billName'] ==
                                        'Data'
                                    ? roundToWholeNumber(authApi
                                            .billTransactions[index]['amount']
                                            .toString())
                                        .toString()
                                    : authApi.billTransactions[index]['amount'],
                                date: authApi.billTransactions[index]['Date'],
                                img: authApi.billTransactions[index]
                                            ['billName'] ==
                                        'Data'
                                    ? 'assets/images/data.png'
                                    : 'assets/images/tv.png',
                                subs: authApi.billTransactions[index]
                                    ['networkProvider'],
                                title: authApi.billTransactions[index]
                                    ['billName'],
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
      ),
    );
  }
}
