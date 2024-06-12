// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/ElectrictyScreens/electricty_reusables.dart';
import 'package:datahub/Providers/auth_providers.dart';
import 'package:datahub/Providers/electricty_provider.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class ElectricityScreen extends StatefulWidget {
  const ElectricityScreen({super.key});

  @override
  State<ElectricityScreen> createState() => _ElectricityScreenState();
}

class _ElectricityScreenState extends State<ElectricityScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  TextEditingController meterController = TextEditingController();
  TextEditingController verifiedNameController = TextEditingController();
  bool prepaid = true;
  bool postpaid = false;
  bool isLoading = false;
  bool verificationLoading = false;
  bool idVerified = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ElectricityProvider>(context, listen: false)
        .selectedElectricPlan = '';
  }

  String _errorMessage = '';

  void _validateAmount() {
    setState(() {
      if (amountController.text.isNotEmpty) {
        double amount = double.tryParse(amountController.text) ?? 0;
        if (amount < 500) {
          _errorMessage = 'Amount should be at least 500';
        } else {
          _errorMessage = '';
        }
      } else {
        _errorMessage = '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var electricApi = Provider.of<ElectricityProvider>(context);
    var authApi = Provider.of<AuthProvider>(context);
    verificationLoading =
        Provider.of<ElectricityProvider>(context).verifyMeterisLoading;
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
              'Electricity',
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
              DropdownAndTitle(
                size: size,
                text: electricApi.selectedElectricPlan == ''
                    ? 'Select Electricity Type'
                    : electricApi.selectedElectricPlan,
                title: 'Select Provider',
                onTap: () {
                  ChooseElectricType().showBottomSheet(context);
                },
              ),
              HeightWidget(height: 3),
              Padding(
                padding: EdgeInsets.only(left: 2 * size.width / 100),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: PoppinsCustText(
                    color: Colors.black,
                    size: 12.0,
                    text: 'Select Type',
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              HeightWidget(height: 0.6),
              Container(
                // height: 7 * size.height / 100,
                width: 90 * size.width / 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PrepaidPostpaidChip(
                      size: size,
                      chipColor: prepaid
                          ? AppColors.primaryColor
                          : Color.fromARGB(255, 205, 202, 202),
                      type: 'PREPAID',
                      textColor: prepaid ? Colors.white : Colors.grey,
                      onTap: () {
                        setState(() {
                          prepaid = true;
                          postpaid = false;
                        });
                      },
                    ),
                    WidthWidget(width: 3),
                    PrepaidPostpaidChip(
                      size: size,
                      chipColor: postpaid
                          ? AppColors.primaryColor
                          : Color.fromARGB(255, 205, 202, 202),
                      type: 'POSTPAID',
                      textColor: postpaid ? Colors.white : Colors.grey,
                      onTap: () {
                        setState(() {
                          prepaid = false;
                          postpaid = true;
                        });
                      },
                    ),
                  ],
                ),
              ),
              HeightWidget(height: 3),
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
                  whichController: meterController,
                  hint: 'Enter meter number',
                  title: 'Meter Number',
                  keyboardtype: TextInputType.number,
                  isloading: isLoading,
                ),
              ),
              HeightWidget(height: 0.5),
              VerificationRow(
                isLoading: verificationLoading,
                size: size,
                idVerified: idVerified,
                onTap: () async {
                  setState(() {
                    idVerified = false;
                  });
                  if (meterController.text.isEmpty ||
                      meterController.text.length < 8) {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: 'Input a valid meter number',
                      ),
                      dismissType: DismissType.onSwipe,
                    );
                  } else if (electricApi.selectedElectricPlan == '') {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: 'select electric provider',
                      ),
                      dismissType: DismissType.onSwipe,
                    );
                  } else {
                    await electricApi
                        .verifyMeterNumber(
                      serviceID: electricApi.selectedElectricCode,
                      meterNumber: meterController.text,
                      type: prepaid ? 'prepaid' : 'postpaid',
                      token: authApi.loginUserId,
                    )
                        .then((value) {
                      if (value == 'success') {
                        setState(
                          () {
                            idVerified = true;
                            verifiedNameController.text =
                                electricApi.meterCustomerName == ''
                                    ? ''
                                    : electricApi.meterCustomerName;
                          },
                        );
                      } else {
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: '${electricApi.verifyMeterMessage}',
                          ),
                          dismissType: DismissType.onSwipe,
                        );
                      }
                    });
                  }

                  // setState(() {
                  //   idVerified = true;
                  //   verifiedNameController.text = 'Emmanuel Ezejiobi';
                  // });
                },
              ),
              HeightWidget(height: 3),
              idVerified
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2 * size.width / 100,
                      ),
                      child: TitleTextFieldTile(
                        size: size,
                        whichController: verifiedNameController,
                        hint: 'Enter phone number',
                        title: 'Verified Name',
                        keyboardtype: TextInputType.number,
                        isloading: true,
                      ),
                    )
                  : SizedBox.shrink(),
              HeightWidget(height: 3),
              idVerified
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 2 * size.width / 100,
                      ),
                      child: TitleTextFieldTile(
                        size: size,
                        whichController: amountController,
                        hint: 'Enter amount',
                        title: 'Amount',
                        keyboardtype: TextInputType.number,
                        isloading: isLoading,
                        onChanged: (p0) {
                          _validateAmount();
                        },
                      ),
                    )
                  : SizedBox.shrink(),
              HeightWidget(height: 0.4),
              _errorMessage == ''
                  ? SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(left: 2 * size.width / 100),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'minimum amount is N500',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ),
              idVerified
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 3 * size.width / 100),
                      child: BalanceAndFundRow(),
                    )
                  : SizedBox.shrink(),
              HeightWidget(height: 20),
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
          if (idVerified == false) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: 'Please verify meter number',
              ),
              dismissType: DismissType.onSwipe,
            );
          } else if (amountController.text.isEmpty) {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: 'Enter amount',
              ),
              dismissType: DismissType.onSwipe,
            );
          } else if (_errorMessage != '') {
            showTopSnackBar(
              Overlay.of(context),
              CustomSnackBar.error(
                message: 'Minimum amount is N500',
              ),
              dismissType: DismissType.onSwipe,
            );
          }
          {
            ShowElectricSummary().showBottomSheet(
              context: context,
              which: '4',
              type: prepaid ? 'prepaid' : 'postpaid',
              meterNumber: meterController.text,
              verifiedName: electricApi.meterCustomerName,
              amount: amountController.text,
              userid: authApi.loginUserId,
              phone: phoneController.text,
              electricID: electricApi.selectedElectricCode,
            );
          }
        },
        isLoading: isLoading,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
