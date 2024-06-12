// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:datahub/HomeScreens/home_reusables.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../Providers/auth_providers.dart';

class TransactionsScreen extends StatefulWidget {
  const TransactionsScreen({super.key});

  @override
  State<TransactionsScreen> createState() => _TransactionsScreenState();
}

class _TransactionsScreenState extends State<TransactionsScreen> {
  List getData = [];
  List templist = [];

  List<String> filteredItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // filteredItems = List.from(types);
  }

  int roundToWholeNumber(String input) {
    // Convert the input to double
    double number = double.tryParse(input) ?? 0.0;
    // Round the number to the nearest whole number
    int roundedNumber = number.round();
    return roundedNumber;
  }

  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var authApi = Provider.of<AuthProvider>(context);
    isLoading = Provider.of<AuthProvider>(context).getUserIsLoading;
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: AppColors.primaryColor,
        title: Text(
          'Transactions',
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
            // HeightWidget(height: 1),
            // SizedBox(
            //   width: 100 * size.width / 100,
            //   child: TextField(
            //     keyboardType: TextInputType.multiline,
            //     controller: searchController,
            //     onChanged: (value) {
            //       setState(() {
            //         filterItems(value);
            //       });
            //     },
            //     decoration: InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide:
            //             BorderSide(color: Color(0xffe2e2e2), width: 1.0),
            //       ),
            //       enabledBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10),
            //         borderSide:
            //             BorderSide(color: Color(0xffe2e2e2), width: 1.0),
            //       ),
            //       hintText: 'Search transaction',
            //       hintStyle: GoogleFonts.dmSans(
            //         textStyle: TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w400,
            //           color: Color(0xff979797),
            //         ),
            //       ),
            //       filled: true,
            //       fillColor: Colors.white,
            //       prefixIcon: Padding(
            //         padding: EdgeInsets.all(15),
            //         child: SvgPicture.asset(
            //           'assets/icons/search.svg',
            //         ),
            //       ),
            //       border: InputBorder.none,
            //       contentPadding: EdgeInsets.all(12),
            //     ),
            //   ),
            // ),

            HeightWidget(height: 2),
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
                            Center(
                              child: Image.asset(
                                'assets/images/datahub.jpg',
                                height: 7 * size.height / 100,
                                width: 14 * size.width / 100,
                              ),
                            ),
                            HeightWidget(height: 1),
                            Center(
                              child: Text(
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
                            ),
                          ],
                        ),
                      )
                    : Expanded(
                        child: ListView.separated(
                          itemCount: authApi.billTransactions.length,
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
    );
  }
}
