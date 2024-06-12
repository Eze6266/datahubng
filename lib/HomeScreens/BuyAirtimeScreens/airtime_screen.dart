// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:datahub/HomeScreens/BuyAirtimeScreens/airtime_reusables.dart';
import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/top_up_screen.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class AirtimeScreens extends StatefulWidget {
  const AirtimeScreens({super.key});

  @override
  State<AirtimeScreens> createState() => _AirtimeScreensState();
}

class _AirtimeScreensState extends State<AirtimeScreens> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  bool isLoading = false;
  bool mtn = false;
  bool airtel = false;
  bool glo = false;
  bool etisalat = false;

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
        title: Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 3 * size.height / 100,
                width: 6 * size.width / 100,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Padding(
                  padding: EdgeInsets.only(left: 1 * size.width / 100),
                  child: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 16,
                  ),
                ),
              ),
            ),
            WidthWidget(width: 30),
            Text(
              'Buy Airtime',
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
              HeightWidget(height: 4),
              Padding(
                padding: EdgeInsets.only(left: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Network',
                    style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
              HeightWidget(height: 1),
              SizedBox(
                height: 10 * size.height / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DataProvidersBox(
                      size: size,
                      colorType: Colors.yellow,
                      provider: 'MTN',
                      imgUrl: 'tn.jpg',
                      clicked: () {
                        setState(() {
                          mtn = true;
                          airtel = false;
                          glo = false;
                          etisalat = false;
                        });
                      },
                      selected: mtn,
                    ),
                    DataProvidersBox(
                      size: size,
                      colorType: Colors.red,
                      provider: 'Airtel',
                      imgUrl: 'tel.jpg',
                      clicked: () {
                        setState(() {
                          mtn = false;
                          airtel = true;
                          glo = false;
                          etisalat = false;
                        });
                      },
                      selected: airtel,
                    ),
                    DataProvidersBox(
                      size: size,
                      colorType: Colors.green,
                      provider: 'Glo',
                      imgUrl: 'lo.png',
                      clicked: () {
                        setState(() {
                          mtn = false;
                          airtel = false;
                          glo = true;
                          etisalat = false;
                        });
                      },
                      selected: glo,
                    ),
                    DataProvidersBox(
                      size: size,
                      colorType: Colors.green,
                      provider: 'Etisalat',
                      imgUrl: 'etisalat.png',
                      clicked: () {
                        setState(() {
                          mtn = false;
                          airtel = false;
                          glo = false;
                          etisalat = true;
                        });
                      },
                      selected: etisalat,
                    ),
                  ],
                ),
              ),
              HeightWidget(height: 4),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2 * size.width / 100,
                ),
                child: TitleTextFieldTile(
                  size: size,
                  whichController: phoneController,
                  hint: 'Enter phone number',
                  title: 'Phone Number',
                  keyboardtype: TextInputType.number,
                  isloading: isLoading,
                ),
              ),
              HeightWidget(height: 4),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2 * size.width / 100,
                ),
                child: TitleTextFieldTile(
                  size: size,
                  whichController: amountController,
                  hint: 'Enter amount to recharge',
                  title: 'Input Amount',
                  keyboardtype: TextInputType.number,
                  isloading: isLoading,
                ),
              ),
              HeightWidget(height: 0.3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                child: BalanceAndFundRow(),
              ),
              HeightWidget(height: 5),
              // Center(
              //   child: PoppinsCustText(
              //     color: Colors.black,
              //     size: 14.0,
              //     text: 'TOTAL AMOUNT ',
              //     weight: FontWeight.w500,
              //   ),
              // ),
              // HeightWidget(height: 0.5),
              // Container(
              //   height: 7 * size.height / 100,
              //   width: 90 * size.width / 100,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(8),
              //     color: Color.fromARGB(255, 216, 215, 215),
              //   ),
              //   child: Center(
              //     child: PoppinsCustText(
              //       color: Colors.black,
              //       size: 20.0,
              //       text: 'N2,500',
              //       weight: FontWeight.w600,
              //     ),
              //   ),
              // ),
              HeightWidget(height: 10),
            ],
          ),
        ),
      ),
      floatingActionButton: GeneralButton(
        size: size,
        buttonColor: AppColors.primaryColor,
        height: 7,
        text: 'Continue',
        width: 90,
        onPressed: () {
          if (airtel == false &&
              mtn == false &&
              glo == false &&
              etisalat == false) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: 'Select network',
              ),
              dismissType: DismissType.onSwipe,
            );
          } else {
            amountController.text.isEmpty || phoneController.text.isEmpty
                ? showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      message: 'input a valid number or amount',
                    ),
                    dismissType: DismissType.onSwipe,
                  )
                : ShowAirtimeSummary().showBottomSheet(
                    context: context,
                    which: '1',
                    number: phoneController.text,
                    network: mtn
                        ? '01'
                        : glo
                            ? '02'
                            : airtel
                                ? '03'
                                : '04',
                    amount: amountController.text,
                    amountToPay: amountController.text,
                    userid: authApi.loginUserId,
                  );
          }
        },
        isLoading: isLoading,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
