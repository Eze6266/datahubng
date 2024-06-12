// ignore_for_file: prefer_const_constructors

import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/transaction_pin.dart';
import 'package:datahub/Providers/cable_provider.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CableProvidersBox extends StatelessWidget {
  CableProvidersBox({
    super.key,
    required this.size,
    required this.colorType,
    required this.provider,
    required this.imgUrl,
    required this.clicked,
    required this.selected,
  });

  final Size size;
  String provider, imgUrl;
  Color colorType;
  Function() clicked;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
      child: GestureDetector(
        onTap: clicked,
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.all(2),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                    color:
                        selected ? AppColors.primaryColor : Colors.transparent),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 6.5 * size.height / 100,
                    width: 14 * size.width / 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      image: DecorationImage(
                        image: AssetImage('assets/images/$imgUrl'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  HeightWidget(height: 0.3),
                  Text(
                    '$provider',
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            selected
                ? Positioned(
                    left: 10 * size.width / 100,
                    child: CircleAvatar(
                      backgroundColor: Colors.green,
                      radius: 8,
                      child: Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 10,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class ChooseCableType {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet(BuildContext context) {
    var cableApi = Provider.of<CableProvider>(context, listen: false);
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
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                color: Colors.white,
              ),
              // height: 80 * size.height / 100,
              child: Container(
                padding: EdgeInsets.all(5),
                width: double.infinity,
                height: 70 * size.height / 100,
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
                          text: 'Choose Cable Plan',
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: cableApi.cablePlans.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: 1 * size.height / 100),
                            child: SheetTiles(
                              size: size,
                              onTap: () {
                                Navigator.pop(context);
                                cableApi.selectedCablePlan =
                                    cableApi.cablePlans[index]['name'];
                                cableApi.selectedCableVarCode = cableApi
                                    .cablePlans[index]['variation_code'];
                                cableApi.selectedCableAmount = cableApi
                                    .cablePlans[index]['variation_amount'];
                                cableApi.cableNotifier();

                                setState(() {});
                              },
                              selected: true,
                              type: cableApi.cablePlans[index]['name'],
                            ),
                          );
                        },
                      ),
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

class ShowCableSummary {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet({
    required BuildContext context,
    required String which,
    required String cableType,
    required String iucNumber,
    required String verifiedName,
    required String plan,
    required String amount,
    required String userid,
    required String phone,
  }) {
    // var dataType = Provider.of<DataProvider>(context, listen: false);
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
                height: 51 * size.height / 100,
                child: SingleChildScrollView(
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
                            'Cable Provider',
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
                              WidthWidget(width: 2),
                              Text(
                                cableType,
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
                        keyText: 'IUC number',
                        valueText: iucNumber,
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Verified name',
                        valueText: verifiedName,
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Plan',
                        valueText: plan,
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Amount',
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
                                amount: amount,
                                phone: phone,
                                serviceid: '',
                                userid: userid,
                                which: which,
                                selectedDataId: '',
                                selectedDataPlan: '',
                                network: '',
                                iucNumber: iucNumber,
                                cableTv: cableType,
                                electricID: '',
                                electricType: '',
                                meterNumber: '',
                              ),
                            ),
                          );
                        },
                        isLoading: isLoading,
                      ),
                      HeightWidget(height: 2),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
