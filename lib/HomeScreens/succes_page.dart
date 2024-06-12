// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:datahub/Utilities/reusables.dart';
import 'package:datahub/navbar.dart';
import 'package:flutter/material.dart';

class SuccessPage extends StatefulWidget {
  SuccessPage({
    super.key,
    required this.which,
    required this.airtime,
    required this.cost,
    required this.number,
    required this.selectedDataPlan,
    required this.cablePlan,
    required this.iucNumber,
    required this.meterNumber,
  });
  var which,
      airtime,
      number,
      cost,
      selectedDataPlan,
      iucNumber,
      cablePlan,
      meterNumber;
  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return WillPopScope(
      onWillPop: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => NavBar(chosenmyIndex: 0),
          ),
        );
        return Future.value(false);
      },
      child: SafeArea(
        child: Scaffold(
          body: Center(
            child: SuccessPopupCard(
              size: size,
              textcontent: widget.which == '1'
                  ? 'You have Successfully recharged N${widget.airtime} Airtime to ${widget.number}. Cost NGN${widget.cost}.'
                  : widget.which == '2'
                      ? 'You have Successfully sent ${widget.selectedDataPlan} to ${widget.number}. Cost NGN${widget.cost}.'
                      : widget.which == '3'
                          ? 'You have Successfully Recharged ${widget.cablePlan} to ${widget.iucNumber}. Cost NGN${widget.cost}.'
                          : 'You have Successfully Bought Electricity for ${widget.meterNumber}. Cost NGN${widget.cost}',
            ),
          ),
        ),
      ),
    );
  }
}
