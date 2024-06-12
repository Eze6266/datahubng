// ignore_for_file: prefer_const_constructors, unnecessary_string_interpolations

import 'package:datahub/HomeScreens/transaction_pin.dart';
import 'package:datahub/Providers/data_providers.dart';
import 'package:datahub/Utilities/app_colors.dart';
import 'package:datahub/Utilities/reusables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class DataProvidersBox extends StatelessWidget {
  DataProvidersBox({
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

class DropdownAndTitle extends StatelessWidget {
  DropdownAndTitle({
    super.key,
    required this.size,
    required this.onTap,
    required this.text,
    required this.title,
  });

  final Size size;
  String title, text;
  Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 2 * size.width / 100),
          child: Align(
            alignment: Alignment.centerLeft,
            child: PoppinsCustText(
              color: Colors.black,
              size: 12.0,
              text: title,
              weight: FontWeight.w600,
            ),
          ),
        ),
        HeightWidget(height: 0.2),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(10),
            height: 7 * size.height / 100,
            width: 90 * size.width / 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                PoppinsCustText(
                  color: Colors.black,
                  size: 14.0,
                  text: '$text',
                  weight: FontWeight.w500,
                ),
                Icon(
                  Icons.expand_more_outlined,
                  color: Colors.black,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ChooseDataType {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet(BuildContext context) {
    var dataType = Provider.of<DataProvider>(context, listen: false);

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
                height: 60 * size.height / 100,
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
                          text: 'Choose Data Type',
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
                    SheetTiles(
                      size: size,
                      onTap: () {
                        print('pressed');
                        Navigator.pop(context);
                        dataType.seldataType = 1;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      selected: false,
                      type: 'SME',
                    ),
                    HeightWidget(height: 1),
                    SheetTiles(
                      size: size,
                      onTap: () {
                        Navigator.pop(context);
                        dataType.seldataType = 2;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      type: 'Normal Data',
                      selected: dataType.seldataType == 2 ? true : false,
                    ),
                    HeightWidget(height: 1),
                    SheetTiles(
                      size: size,
                      onTap: () {
                        Navigator.pop(context);
                        dataType.seldataType = 3;
                        dataType.callDataNotifier();
                        setState(() {});
                      },
                      type: 'Enterprise Data',
                      selected: dataType.seldataType == 3 ? true : false,
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

class SheetTiles extends StatelessWidget {
  SheetTiles({
    super.key,
    required this.onTap,
    required this.type,
    required this.size,
    required this.selected,
  });

  final Size size;
  String type;
  Function() onTap;
  bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2 * size.width / 100),
        height: 7 * size.height / 100,
        width: 100 * size.width / 100,
        color: const Color.fromARGB(255, 238, 236, 236),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 86 * size.width / 100,
              child: Text(
                type,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.start,
              ),
            ),
            Container(
              height: 2 * size.height / 100,
              width: 4 * size.width / 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: AppColors.primaryColor),
              ),
              child: selected
                  ? Icon(
                      Icons.check,
                      size: 12,
                      color: AppColors.primaryColor,
                    )
                  : SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

class ChooseDataPlan {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet(BuildContext context) {
    var dataType = Provider.of<DataProvider>(context, listen: false);
    String extractNumericString(String input) {
      // Remove "NGN" prefix and any leading/trailing whitespace
      String numericString = input.replaceAll('NGN', '').trim();

      // Return the extracted numeric string
      return numericString;
    }

    String roundString(String numberString, {int decimalPlaces = 0}) {
      try {
        double number = double.parse(numberString);
        if (decimalPlaces < 0) {
          throw FormatException("Decimal places can't be negative");
        }
        if (decimalPlaces == 0) {
          return number.round().toString();
        } else {
          return number.toStringAsFixed(decimalPlaces);
        }
      } catch (e) {
        return "Invalid input";
      }
    }

    String _formattedNumber = '';
    String formatNumber(String input) {
      if (input.isNotEmpty && input.startsWith('N')) {
        try {
          // Remove the 'N'
          input = input.substring(1);

          // Parse the number
          double number = double.parse(input);

          // Add 10%
          number += number * 0.1;

          // Round to the nearest whole number
          int roundedNumber = number.round();

          // Format with commas
          final NumberFormat formatter = NumberFormat('#,##0');
          String formatted = formatter.format(roundedNumber);

          return formatted;
        } catch (e) {
          return 'Invalid input';
        }
      } else {
        return 'Invalid input';
      }
    }

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
                          text: 'Choose Data Plan',
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
                    Expanded(
                      child: ListView.builder(
                        itemCount: dataType.tempo.length,
                        itemBuilder: (context, index) {
                          final dataPlan = dataType.tempo[index];
                          return Padding(
                            padding:
                                EdgeInsets.only(bottom: 1 * size.height / 100),
                            child: SheetTiles(
                                size: size,
                                onTap: () {
                                  print(dataPlan['planID']);
                                  Navigator.pop(context);
                                  dataType.selectedDataPlan =
                                      '${dataPlan['description']}   -    N${formatNumber(
                                    (dataPlan['price']),
                                  )}';
                                  dataType.selectedDataId =
                                      dataPlan['planID'].toString();
                                  dataType.selectedDataPrice =
                                      formatNumber((dataPlan['price']));
                                  dataType.callDataNotifier();
                                  // setState(() {});
                                },
                                selected: false,
                                type:
                                    '${dataPlan['description']}   -   N${formatNumber(dataPlan['price'])}'),
                            // '${dataPlan['description'].split(' - ')[0]} - N${roundString((dataPlan['price'] * 1.12).toStringAsFixed(2), decimalPlaces: 0)} 30days'),
                          );
                        },
                      ),
                    ),
                    HeightWidget(height: 0.3),
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

class ShowDataSummary {
  TextEditingController searchController = TextEditingController();
  void showBottomSheet({
    required String userid,
    required String selectedDataId,
    required BuildContext context,
    required String which,
    required String price,
    required String network,
    required String phone,
    required String selectedDataPlan,
  }) {
    var dataType = Provider.of<DataProvider>(context, listen: false);
    String addCommasToNumber(String numberString) {
      String reversedString = numberString.split('').reversed.join();
      String result = '';
      for (int i = 0; i < reversedString.length; i++) {
        result += reversedString[i];
        if ((i + 1) % 3 == 0 && i != reversedString.length - 1) {
          result += ',';
        }
      }
      return result.split('').reversed.join();
    }

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
                height: 48 * size.height / 100,
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
                                      ? 'GLO'
                                      : network == '03'
                                          ? 'AIRTEL'
                                          : '9MOBILE',
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
                      keyText: 'Data Plan',
                      valueText: '$selectedDataPlan',
                    ),
                    HeightWidget(height: 2),
                    SheetRowText(
                      keyText: 'Amount To Pay',
                      valueText: 'N${addCommasToNumber(price)}',
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
                              amount: price,
                              phone: phone,
                              serviceid: '',
                              userid: userid,
                              network: network,
                              selectedDataId: selectedDataId,
                              selectedDataPlan: selectedDataPlan,
                              cableTv: '',
                              iucNumber: '',
                              electricID: '',
                              electricType: '',
                              meterNumber: '',
                            ),
                          ),
                        );
                      },
                      isLoading: isLoading,
                    ),
                    HeightWidget(height: 1),
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

class SheetRowText extends StatelessWidget {
  SheetRowText({
    super.key,
    required this.keyText,
    required this.valueText,
  });
  String keyText, valueText;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$keyText',
          style: GoogleFonts.acme(
            textStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: const Color.fromARGB(255, 103, 102, 102),
            ),
          ),
        ),
        SizedBox(
          width: 66 * size.width / 100,
          child: Text(
            '$valueText',
            style: GoogleFonts.abel(
              textStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
