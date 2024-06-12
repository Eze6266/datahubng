// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/home_reusables.dart';
import 'package:datahub/HomeScreens/top_up_screen.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Providers/data_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class DataScreen extends StatefulWidget {
  DataScreen({
    super.key,
    required this.userid,
  });
  var userid;
  @override
  State<DataScreen> createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen>
    with SingleTickerProviderStateMixin {
  TextEditingController phoneController = TextEditingController();
  bool mtn = false;
  bool airtel = false;
  bool glo = false;
  bool etisalat = false;
  bool isLoading = false;
  bool phoneError = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<DataProvider>(context, listen: false).getAllData('');
      Provider.of<DataProvider>(context, listen: false).selectedDataPlan = '';
      // Add Your Code here.
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var dataType = Provider.of<DataProvider>(context);
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
            WidthWidget(width: 26),
            Text(
              'Buy Data Bundle',
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

              Padding(
                padding: EdgeInsets.only(left: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Select Network',
                    style: GoogleFonts.acme(
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
                          dataType.selectedDataPlan = '';
                          dataType.getAllData('mtn');
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
                          dataType.selectedDataPlan = '';
                          dataType.getAllData('airtel');
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
                          dataType.selectedDataPlan = '';
                          dataType.getAllData('glo');
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
                          dataType.selectedDataPlan = '';
                          dataType.getAllData('9mobile');
                        });
                      },
                      selected: etisalat,
                    ),
                  ],
                ),
              ),
              HeightWidget(height: 2),
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
                  onChanged: (value) {
                    if (value.length < 11) {
                      setState(() {
                        phoneError = true;
                      });
                    } else {
                      setState(() {
                        phoneError = false;
                      });
                    }
                  },
                ),
              ),
              // HeightWidget(height: 2),
              // DropdownAndTitle(
              //   size: size,
              //   text: dataType.seldataType == 1
              //       ? 'SME'
              //       : dataType.seldataType == 2
              //           ? 'Normal Data'
              //           : dataType.seldataType == 3
              //               ? 'Enterprise Data'
              //               : 'Select Data Type',
              //   title: 'Choose Data Type',
              //   onTap: () {
              //     ChooseDataType().showBottomSheet(context);
              //   },
              // ),

              HeightWidget(height: 3),
              DropdownAndTitle(
                size: size,
                text: dataType.selectedDataPlan == ''
                    ? 'Select Plan'
                    : dataType.selectedDataPlan,
                title: 'Choose Data Plan',
                onTap: () {
                  mtn == false &&
                          airtel == false &&
                          glo == false &&
                          etisalat == false
                      ? showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: 'select a network',
                          ),
                          dismissType: DismissType.onSwipe,
                        )
                      : dataType.tempo.isEmpty
                          ? showToast()
                          : ChooseDataPlan().showBottomSheet(context);
                },
              ),
              HeightWidget(height: 0.3),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 3 * size.width / 100),
                child: BalanceAndFundRow(),
              ),

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
            if (phoneController.text.isEmpty || phoneError) {
              showTopSnackBar(
                Overlay.of(context),
                CustomSnackBar.error(
                  message: 'Enter a valid number',
                ),
                dismissType: DismissType.onSwipe,
              );
            } else {
              ShowDataSummary().showBottomSheet(
                context: context,
                which: '2',
                phone: phoneController.text,
                userid: authApi.loginUserId,
                price: dataType.selectedDataPrice,
                selectedDataPlan: dataType.selectedDataPlan,
                selectedDataId: dataType.selectedDataId,
                network: mtn
                    ? '01'
                    : glo
                        ? '02'
                        : airtel
                            ? '03'
                            : '04',
              );
            }
          }
        },
        isLoading: isLoading,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: 'Fetching data plans',
      toastLength: Toast
          .LENGTH_SHORT, // Duration for which the toast should be displayed
      gravity: ToastGravity.BOTTOM, // Position of the toast message
      timeInSecForIosWeb:
          1, // Time duration in seconds for which the message should be displayed
      backgroundColor: Colors.black54, // Background color of the toast message
      textColor: Colors.white, // Text color of the toast message
      fontSize: 16.0, // Font size of the toast message
    );
  }
}
