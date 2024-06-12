import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataProvider extends ChangeNotifier {
  int seldataType = 0;

  ///////////////////////**GET ALL DATA PLANS */////////////////////////////

  bool getAllDataIsLoading = false;
  var getAllDataStatus = '';
  var selectedDataPlan = '';
  var selectedDataId = '';
  var selectedDataPrice = '';
  var getAllDataMessage = '';
  List<dynamic> dataPlans = [];
  List tempo = [];
  var getAllDataStatusCode;
  Future<String?> getAllData(
    String dataType,
  ) async {
    dataPlans.clear();
    SharedPreferences pref = await SharedPreferences.getInstance();
    var userid = pref.getString('userid');
    getAllDataIsLoading = true;
    notifyListeners();
    var response = await http.post(
        Uri.parse(
            'https://vtu-apis-gt81.onrender.com/api/users/get-data-plans/$userid'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "network": dataType,
        }));
    print('this is get all data response code ${response.statusCode}');

    getAllDataIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('get all data was a succes');

      String responseString = response.body;
      getAllDataStatus = jsonDecode(responseString)['status'].toString();
      getAllDataMessage = jsonDecode(responseString)['message'];
      var jsonList = jsonDecode(responseString)['Dataplans'];
      // List<dynamic> jsonList =
      //     jsonDecode(jsonDecode(responseString)['Dataplans']);
      tempo = jsonDecode(responseString)['Dataplans'];
      //  dataPlans = jsonList.map((json) => DataPlan.fromJson(json)).toList();
      notifyListeners();
      LogPrint(dataPlans);

      getAllDataStatusCode = response.statusCode.toString();
      notifyListeners();
      return getAllDataStatus;
    } else {
      String responseString = response.body;
      getAllDataStatus = jsonDecode(responseString)['status'].toString();
      getAllDataMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**GET ALL DATA PLANS */////////////////////////////

  ///////////////////////**BUY AIRTIME */////////////////////////////

  bool buyAirtimeIsLoading = false;
  var buyAirtimeStatus = '';
  var buyAirtimeMessage = '';

  Future<String?> buyAirtime({
    required String userid,
    required String serviceID,
    required String phoneNumber,
    required String amount,
    required String pin,
  }) async {
    print('$serviceID $amount $phoneNumber $pin $userid');
    buyAirtimeIsLoading = true;
    notifyListeners();
    var response = await http.post(
      Uri.parse(
          'https://vtu-apis-gt81.onrender.com/api/users/buy-card/$userid'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "network": serviceID,
          "amount": amount,
          "phone": phoneNumber,
          "airtime_type": "001",
          // "transactionPin": pin,
        },
      ),
    );
    print('this is buy airtime response code ${response.statusCode}');

    buyAirtimeIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('get all data was a succes');
      String responseString = response.body;
      buyAirtimeStatus = jsonDecode(responseString)['status'].toString();
      buyAirtimeMessage = jsonDecode(responseString)['message'];

      notifyListeners();
      return buyAirtimeStatus;
    } else {
      String responseString = response.body;
      buyAirtimeStatus = jsonDecode(responseString)['status'].toString();
      buyAirtimeMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**BUY AIRTIME */////////////////////////////

  ///////////////////////**BUY DATA */////////////////////////////

  bool buyDataIsLoading = false;
  var buyDataStatus = '';
  var buyDataMessage = '';

  Future<String?> buyData({
    required String userid,
    required String dataplan,
    required String phoneNumber,
    required String network,
    required String pin,
  }) async {
    print('$network $phoneNumber $dataplan $pin $userid');
    buyDataIsLoading = true;

    notifyListeners();
    var response = await http.post(
      Uri.parse(
          'https://vtu-apis-gt81.onrender.com/api/users/buy-data/$userid'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(
        {
          "network": network,
          "phone": phoneNumber,
          "Dataplan": dataplan,
        },
      ),
    );

    print('this is buy Data response code ${response.statusCode}');

    buyDataIsLoading = false;
    notifyListeners();
    var data = response.body;
    print(data);
    if (response.statusCode == 201 || response.statusCode == 200) {
      debugPrint('get all data was a succes');
      String responseString = response.body;
      buyDataStatus = jsonDecode(responseString)['status'].toString();
      buyDataMessage = jsonDecode(responseString)['message'];

      notifyListeners();
      return buyDataStatus;
    } else {
      String responseString = response.body;
      buyDataStatus = jsonDecode(responseString)['status'].toString();
      buyDataMessage = jsonDecode(responseString)['message'];
      notifyListeners();
    }
    notifyListeners();
    return null;
  }

///////////////////////**BUY DATA */////////////////////////////

  callDataNotifier() {
    notifyListeners();
  }

  static void LogPrint(Object object) async {
    int defaultPrintLength = 1020;
    if (object == null || object.toString().length <= defaultPrintLength) {
      print(object);
    } else {
      String log = object.toString();
      int start = 0;
      int endIndex = defaultPrintLength;
      int logLength = log.length;
      int tmpLogLength = log.length;
      while (endIndex < logLength) {
        print(log.substring(start, endIndex));
        endIndex += defaultPrintLength;
        start += defaultPrintLength;
        tmpLogLength -= defaultPrintLength;
      }
      if (tmpLogLength > 0) {
        print(log.substring(start, logLength));
      }
    }
  }
}

class DataPlan {
  final int id;
  final String description;
  final double price;

  DataPlan({
    required this.id,
    required this.description,
    required this.price,
  });

  factory DataPlan.fromJson(Map<String, dynamic> json) {
    final id = int.parse(json.keys.first);
    final description = json.values.first.toString().trim();
    final price = double.parse(
        description.split('-')[1].trim().split(' ')[0].substring(1));
    return DataPlan(
      id: id,
      description: description,
      price: price,
    );
  }

  double getPriceWithTenPercentIncrease() {
    return price * 1.10;
  }
}
