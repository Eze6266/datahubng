// ignore_for_file: prefer_const_constructors

import 'package:datahub/HomeScreens/DataScreens/data_reusables.dart';
import 'package:datahub/HomeScreens/transaction_pin.dart';
import 'package:datahub/Providers/electricty_provider.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../Utilities/reusables.dart';

class PrepaidPostpaidChip extends StatelessWidget {
  PrepaidPostpaidChip({
    super.key,
    required this.size,
    required this.onTap,
    required this.type,
    required this.chipColor,
    required this.textColor,
  });

  final Size size;
  String type;
  Function() onTap;
  Color chipColor, textColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 5 * size.height / 100,
        width: 18 * size.width / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: chipColor,
        ),
        child: Center(
          child: PoppinsCustText(
            color: textColor,
            size: 10.0,
            text: type,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

final List<String> electricityCompanies = [
  "Eko Electricity - EKEDC(PHCN)",
  "Ikeja Electricity - IKEDC(PHCN)",
  "PortHarcourt Electricity - PHEDC",
  "Kaduna Electricity - KAEDC",
  "Abuja Electricity - AEDC",
  "Ibadan Electricity - IBEDC",
  "Kano Electricity - KEDC",
  "Jos Electricity - JEDC",
  "Enugu Electricity - EEDC",
  "Benin Electricity - BEDC"
];

final List<String> electricityCodes = [
  "eko-electric",
  "ikeja-electric",
  "portharcourt-electric",
  "kaduna-electric",
  "abuja-electric",
  "ibadan-electric",
  "kano-electric",
  "jos-electric",
  "enugu-electric",
  "benin-electric"
];

class ChooseElectricType {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet(BuildContext context) {
    var electricApi = Provider.of<ElectricityProvider>(context, listen: false);

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
                          text: 'Choose Electricity Provider',
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
                        itemCount: electricityCompanies.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: 1 * size.height / 100),
                            child: SheetTiles(
                              size: size,
                              onTap: () {
                                print('pressed');
                                Navigator.pop(context);
                                electricApi.selectedElectricCode =
                                    electricityCodes[index].toString();
                                electricApi.selectedElectricPlan =
                                    electricityCompanies[index];
                                electricApi.electricityNotifier();
                                setState(() {});
                              },
                              selected: true,
                              type: electricityCompanies[index],
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

class ShowElectricSummary {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet({
    required BuildContext context,
    required String which,
    required String type,
    required String meterNumber,
    required String verifiedName,
    required String amount,
    required String userid,
    required String phone,
    required String electricID,
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
                height: 56 * size.height / 100,
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
                            'Service Provider',
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
                              Container(
                                height: 4 * size.height / 100,
                                width: 9 * size.width / 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  image: DecorationImage(
                                    image: AssetImage('assets/images/kaed.jpg'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Text(
                                'KAED',
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
                        valueText: '$phone',
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Meter type',
                        valueText: '$type',
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Meter number',
                        valueText: '$meterNumber',
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Verified name',
                        valueText: '$verifiedName',
                      ),
                      HeightWidget(height: 2),
                      SheetRowText(
                        keyText: 'Amount To Pay',
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
                                which: '4',
                                selectedDataId: '',
                                selectedDataPlan: '',
                                network: '',
                                iucNumber: '',
                                cableTv: '',
                                meterNumber: meterNumber,
                                electricID: electricID,
                                electricType: type,
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
