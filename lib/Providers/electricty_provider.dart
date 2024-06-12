import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ElectricityProvider extends ChangeNotifier {
  var selectedElectricPlan = '';
  var selectedElectricCode = '';

  //***************************** VERIFY METER NUMBER ****************************//

  var verifyMeterMessage;
  var meterCustomerName = '';
  var verifyMeterStatus;
  bool verifyMeterisLoading = false;

  Future<String?> verifyMeterNumber({
    required String serviceID,
    required String meterNumber,
    required String type,
    required String token,
  }) async {
    try {
      print('$serviceID $meterNumber $type $token');
      verifyMeterisLoading = true;

      notifyListeners();
      var response = await http.post(
          Uri.parse(
              'https://vtu-apis-gt81.onrender.com/api/users/verify-meter-number/$token'),
          headers: {
            "Content-type": 'application/json',
          },
          body: jsonEncode({
            "meterNumber": meterNumber,
            "type": type,
            "serviceID": serviceID,
          }));
      verifyMeterisLoading = false;
      notifyListeners();
      print(
          'this is the verify meter number response code ${response.statusCode}');

      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        verifyMeterStatus = 'success';

        if (jsonDecode(data)['status'].toString() == 'success') {
          verifyMeterStatus = 'success';
          meterCustomerName = jsonDecode(data)['MeterDetails']['Customer_Name'];

          notifyListeners();
        } else {
          meterCustomerName = '';
          notifyListeners();
        }
        return verifyMeterStatus;
      } else {
        verifyMeterStatus = jsonDecode(data)['status'].toString();
        verifyMeterMessage = jsonDecode(data)['message'].toString();
        notifyListeners();
        return verifyMeterStatus;
      }
    } catch (e) {
      print("Catch Error ${e.toString()}");
    }
    notifyListeners();
    return null;
  }

  //***************************** VERIFY METER NUMBER ****************************//

  //***************************** BUY ELECTRIC PLAN ****************************//

  var buyElectricMessage;

  var buyElectricStatus;
  bool buyElectricisLoading = false;

  Future<String?> buyElectric({
    required String amount,
    required String meterNumber,
    required String serviceID,
    required String phone,
    required String token,
    required String type,
  }) async {
    try {
      buyElectricisLoading = true;

      notifyListeners();
      var response = await http.post(
        Uri.parse(
            'https://vtu-apis-gt81.onrender.com/api/users/purchase-meter/$token'),
        headers: {
          "Content-type": 'application/json',
        },
        body: jsonEncode(
          {
            "meterNumber": meterNumber,
            "serviceID": serviceID,
            "amount": amount,
            "phone": phone,
            "type": type,
          },
        ),
      );
      buyElectricisLoading = false;
      notifyListeners();
      print('this is the buy Electric response code ${response.statusCode}');

      var data = response.body;
      print(data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        buyElectricStatus = 'success';

        if (jsonDecode(data)['status'].toString() == 'success') {
          buyElectricStatus = 'success';

          notifyListeners();
        } else {
          notifyListeners();
        }
        return buyElectricStatus;
      } else {
        buyElectricStatus = 'error';
        buyElectricMessage = jsonDecode(data)['message'].toString();
        notifyListeners();
        return buyElectricStatus;
      }
    } catch (e) {
      print("Catch Error ${e.toString()}");
    }
    notifyListeners();
    return null;
  }

  //***************************** BUY ELECTRIC PLAN ****************************//
  void electricityNotifier() {
    notifyListeners();
  }
}
