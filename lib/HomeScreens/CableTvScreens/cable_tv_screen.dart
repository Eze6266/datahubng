// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:datahub/HomeScreens/CableTvScreens/cable_tv_reusables.dart';
import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Providers/cable_provider.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class CableTvScreen extends StatefulWidget {
  const CableTvScreen({super.key});

  @override
  State<CableTvScreen> createState() => _CableTvScreenState();
}

class _CableTvScreenState extends State<CableTvScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController iucController = TextEditingController();
  TextEditingController verifiedNameController = TextEditingController();
  bool isLoading = false;
  bool dstv = false;
  bool gotv = false;

  bool startimes = false;

  bool idVerified = false;
  bool verifyisLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var cableApi = Provider.of<CableProvider>(context);
    var authApi = Provider.of<AuthProvider>(context);
    verifyisLoading = Provider.of<CableProvider>(context).verifyIucisLoading;
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
            WidthWidget(width: 35),
            Text(
              'Cable TV',
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
              HeightWidget(height: 3),
              Padding(
                padding: EdgeInsets.only(left: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PoppinsCustText(
                    color: Colors.black,
                    size: 12.0,
                    text: 'Select Cable Provider',
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              HeightWidget(height: 0.6),
              SizedBox(
                height: 10 * size.height / 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CableProvidersBox(
                      size: size,
                      colorType: Colors.yellow,
                      provider: 'DSTV',
                      imgUrl: 'dstv.png',
                      clicked: () {
                        setState(() {
                          dstv = true;
                          gotv = false;
                          startimes = false;
                          cableApi.selectedCablePlan = '';
                          iucController.clear();
                          cableApi.getCablePlans(
                            cableTv: 'dstv',
                            userid: authApi.loginUserId,
                          );

                          idVerified = false;
                        });
                      },
                      selected: dstv,
                    ),
                    WidthWidget(width: 3),
                    CableProvidersBox(
                      size: size,
                      colorType: Colors.red,
                      provider: 'GOTV',
                      imgUrl: 'otv.png',
                      clicked: () {
                        setState(() {
                          dstv = false;
                          gotv = true;
                          startimes = false;
                          cableApi.selectedCablePlan = '';
                          iucController.clear();
                          cableApi.getCablePlans(
                            cableTv: 'gotv',
                            userid: authApi.loginUserId,
                          );

                          idVerified = false;
                        });
                      },
                      selected: gotv,
                    ),
                    WidthWidget(width: 3),
                    CableProvidersBox(
                      size: size,
                      colorType: Colors.green,
                      provider: 'StarTimes',
                      imgUrl: 'time.png',
                      clicked: () {
                        setState(() {
                          dstv = false;
                          gotv = false;
                          startimes = true;
                          cableApi.selectedCablePlan = '';
                          iucController.clear();
                          cableApi.getCablePlans(
                            cableTv: 'startimes',
                            userid: authApi.loginUserId,
                          );
                          idVerified = false;
                        });
                      },
                      selected: startimes,
                    ),
                    WidthWidget(width: 3),

                    // CableProvidersBox(
                    //   size: size,
                    //   colorType: Colors.green,
                    //   provider: 'Showmax',
                    //   imgUrl: 'max.png',
                    //   clicked: () {
                    //     setState(() {
                    //       dstv = false;
                    //       gotv = false;
                    //       startimes = false;
                    //       showmax = true;
                    //     });
                    //   },
                    //   selected: showmax,
                    // ),
                  ],
                ),
              ),
              HeightWidget(height: 4),
              // DropdownAndTitle(
              //   size: size,
              //   text: cableApi.selectedCablePlan == ''
              //       ? 'Select Cable Type'
              //       : cableApi.selectedCablePlan,
              //   title: 'Select Plan',
              //   onTap: () {
              //     if (dstv == false && gotv == false && startimes == false) {
              //       showTopSnackBar(
              //         Overlay.of(context),
              //         CustomSnackBar.error(
              //           message: 'Please select a provider',
              //         ),
              //       );
              //     } else {
              //       if (cableApi.cablePlans.isEmpty) {
              //         showToast();
              //       } else {
              //         ChooseCableType().showBottomSheet(context);
              //       }
              //     }
              //   },
              // ),

              // HeightWidget(height: 3),
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
              HeightWidget(height: 3),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 2 * size.width / 100,
                ),
                child: TitleTextFieldTile(
                  size: size,
                  whichController: iucController,
                  hint: 'Enter IUC number',
                  title: 'IUC/Card Number',
                  keyboardtype: TextInputType.number,
                  isloading: isLoading,
                ),
              ),
              HeightWidget(height: 0.5),
              VerificationRow(
                size: size,
                idVerified: idVerified,
                isLoading: verifyisLoading,
                onTap: () async {
                  setState(() {
                    idVerified = false;
                  });
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  var userid = pref.getString('userid');
                  if (iucController.text.isEmpty ||
                      iucController.text.length < 3) {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: 'Enter a valid IUC Number',
                      ),
                    );
                  } else {
                    if (dstv == false && gotv == false && startimes == false) {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: 'Select a cable provider',
                        ),
                      );
                    } else {
                      await cableApi
                          .verifyIUCNumber(
                        cableTv: dstv
                            ? 'dstv'
                            : gotv
                                ? 'gotv'
                                : startimes
                                    ? 'startimes'
                                    : 'showmax',
                        iucNumber: iucController.text,
                        token: userid.toString(),
                      )
                          .then((value) {
                        if (value == 'success') {
                          setState(() {
                            idVerified = true;
                          });
                        } else {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(
                              message: '${cableApi.verifyIucMessage}',
                            ),
                          );
                        }
                      });
                    }
                  }
                },
              ),
              idVerified ? Divider() : SizedBox.shrink(),
              idVerified
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: RowTextCable(
                            keyText: 'Name',
                            valText:
                                '${cableApi.cableCustomerName == '' ? '' : cableApi.cableCustomerName}',
                          ),
                        ),
                        HeightWidget(height: 0.5),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 3 * size.width / 100),
                        //   child: BalanceAndFundRow(),
                        // ),
                      ],
                    )
                  : SizedBox.shrink(),
              HeightWidget(height: 1),
              idVerified
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: RowTextCable(
                            keyText: 'renewal amount',
                            valText:
                                'N${cableApi.cableRenewalAmount == '' ? '' : cableApi.cableRenewalAmount}',
                          ),
                        ),
                        HeightWidget(height: 0.5),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 3 * size.width / 100),
                        //   child: BalanceAndFundRow(),
                        // ),
                      ],
                    )
                  : SizedBox.shrink(),
              HeightWidget(height: 1),
              idVerified
                  ? Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white,
                          ),
                          child: RowTextCable(
                            keyText: 'plan',
                            valText:
                                '${cableApi.cableCurrentPlan == '' ? '' : cableApi.cableCurrentPlan}',
                          ),
                        ),
                        HeightWidget(height: 0.5),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: 3 * size.width / 100),
                        //   child: BalanceAndFundRow(),
                        // ),
                      ],
                    )
                  : SizedBox.shrink(),
              HeightWidget(height: 4),
              GeneralButton(
                size: size,
                buttonColor: AppColors.primaryColor,
                height: 7,
                text: 'Continue',
                width: 90,
                onPressed: () async {
                  SharedPreferences pref =
                      await SharedPreferences.getInstance();
                  var userid = pref.getString('userid');
                  if (idVerified == false) {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: 'Please verify your iuc number',
                      ),
                    );
                  } else {
                    if (dstv == false && gotv == false && startimes == false) {
                      showTopSnackBar(
                        Overlay.of(context),
                        CustomSnackBar.error(
                          message: 'Please select a cable provider',
                        ),
                      );
                    } else {
                      if (phoneController.text.isEmpty ||
                          iucController.text.isEmpty ||
                          iucController.text.length < 3) {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: 'Please make sure all fields are filled',
                          ),
                        );
                      } else {
                        ShowCableSummary().showBottomSheet(
                          iucNumber: iucController.text,
                          verifiedName: cableApi.cableCustomerName,
                          plan: cableApi.cableCurrentPlan,
                          amount: cableApi.cableRenewalAmount,
                          userid: userid.toString(),
                          phone: phoneController.text,
                          cableType: gotv
                              ? 'gotv'
                              : dstv
                                  ? 'dstv'
                                  : 'startimes',
                          context: context,
                          which: '3',
                        );
                      }
                    }
                  }
                },
                isLoading: isLoading,
              ),
              HeightWidget(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: 'Fetching cable plans',
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

class RowTextCable extends StatelessWidget {
  RowTextCable({
    super.key,
    required this.keyText,
    required this.valText,
  });
  String keyText, valText;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        Text(
          '$keyText:  ',
          style: GoogleFonts.roboto(
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(
          width: 60 * size.width / 100,
          child: Text(
            '$valText',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14,
              color: Colors.green,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
