// ignore_for_file: prefer_const_constructors

import 'package:datahub/HomeScreens/home_reusables.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AllWalletTransScreen extends StatefulWidget {
  const AllWalletTransScreen({super.key});

  @override
  State<AllWalletTransScreen> createState() => _AllWalletTransScreenState();
}

class _AllWalletTransScreenState extends State<AllWalletTransScreen> {
  List subs = [
    'WEMA',
    'MONNIEPOINT',
    'STERLING',
    'MONNIEPOINT',
    'WEMA',
    'MONNIEPOINT',
    'STERLING',
    'MONNIEPOINT',
    'WEMA',
    'MONNIEPOINT',
    'STERLING',
    'MONNIEPOINT',
  ];
  List amount = [
    '+10,000',
    '+25,000',
    '+3,000',
    '+1,800',
    '+10,000',
    '+25,000',
    '+3,000',
    '+1,800',
    '+10,000',
    '+25,000',
    '+3,000',
    '+1,800',
  ];

  List dates = [
    '10:30am, 05 Dec 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
    '10:30am, 05 Dec 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
    '10:30am, 05 Dec 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
    '08:43pm, 30 May 2023',
  ];
  List getData = [];
  List templist = [];
  void filterItems(String query) {
    // Clear the previous filtered items
    filteredItems.clear();

    // Filter items based on the query
    for (var item in subs) {
      if (item.toLowerCase().contains(query.toLowerCase())) {
        filteredItems.add(item);
      }
    }

    setState(() {}); // Trigger a rebuild to update the UI
  }

  List<String> filteredItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredItems = List.from(subs);
  }

  bool isLoading = false;
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              'Wallet Transactions',
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
        child: Column(
          children: [
            HeightWidget(height: 1),
            SizedBox(
              width: 100 * size.width / 100,
              child: TextField(
                keyboardType: TextInputType.multiline,
                controller: searchController,
                onChanged: (value) {
                  setState(() {
                    filterItems(value);
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xffe2e2e2), width: 1.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        BorderSide(color: Color(0xffe2e2e2), width: 1.0),
                  ),
                  hintText: 'Search transaction',
                  hintStyle: GoogleFonts.dmSans(
                    textStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff979797),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(15),
                    child: SvgPicture.asset(
                      'assets/icons/search.svg',
                    ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(12),
                ),
              ),
            ),
            HeightWidget(height: 2),
            Expanded(
              child: ListView.separated(
                itemCount: subs.length,
                itemBuilder: (context, index) {
                  return WalletTile(
                    amount: amount[index],
                    date: dates[index],
                    subs: subs[index],
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
