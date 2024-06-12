// ignore_for_file: prefer_const_constructors

import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/transaction_pin.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ShowAirtimeSummary {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet({
    required BuildContext context,
    required String which,
    required String number,
    required String network,
    required String amount,
    required String amountToPay,
    required String userid,
  }) {
    bool isLoading = false;
    showModalBottomSheet(
      enableDrag: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
      ),
      context: context,
      builder: (BuildContext context) {
        Size size = MediaQuery.of(context).size;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              // height: 80 * size.height / 100,
              child: Container(
                padding: EdgeInsets.all(8),
                width: double.infinity,
                height: 43 * size.height / 100,
                child: Column(
                  children: [
                    Container(
                      height: 0.5 * size.height / 100,
                      width: 15 * size.width / 100,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.grey,
                      ),
                    ),
                    HeightWidget(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PoppinsCustText(
                          color: Colors.black,
                          size: 16.0,
                          text: 'Transaction Summary',
                          weight: FontWeight.w600,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                    HeightWidget(height: 1.5),
                    Divider(),
                    HeightWidget(height: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Network Provider',
                          style: GoogleFonts.acme(
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: const Color.fromARGB(255, 103, 102, 102),
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              network == '01'
                                  ? 'MTN'
                                  : network == '02'
                                      ? 'Glo'
                                      : network == '03'
                                          ? 'Airtel'
                                          : 'Etisalat',
                              style: GoogleFonts.abel(
                                textStyle: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    HeightWidget(height: 2),
                    SheetRowText(
                      keyText: 'Phone Number',
                      valueText: '$number',
                    ),
                    HeightWidget(height: 2),
                    SheetRowText(
                      keyText: 'Airtime Amount',
                      valueText: 'N$amount',
                    ),
                    HeightWidget(height: 8),
                    GeneralButton(
                      size: size,
                      buttonColor: AppColors.primaryColor,
                      height: 7,
                      text: 'Proceed',
                      width: 90,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransactionPinScreen(
                              which: which,
                              amount: amount,
                              phone: number,
                              serviceid: '$network',
                              userid: userid,
                              selectedDataPlan: '',
                              network: network,
                              cableTv: '',
                              iucNumber: '',
                              selectedDataId: '',
                              electricID: '',
                              electricType: '',
                              meterNumber: '',
                            ),
                          ),
                        );
                        // ShowDataSummary().showBottomSheet(context);
                      },
                      isLoading: isLoading,
                    ),
                    HeightWidget(height: 2),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
