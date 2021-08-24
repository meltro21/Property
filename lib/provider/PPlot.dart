import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:property/models/plot.dart';
import 'package:http/http.dart' as http;

//Get Plot
List<Plot> parsePlot(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('parsed is $parsed');
  return parsed.map<Plot>((json) => Plot.fromJson(json)).toList();
}

Future<List<Plot>> getPlot(http.Client client, String buyerId) async {
  print('start FilterDailyWork get');
  var queryParameters = {'BuyerId': '${buyerId}'};
  var uri = Uri.http('192.168.10.2:3000', '/plot', queryParameters);
  print('Filter Variety uri is: $uri');
  final response = await http.get(uri);
  if (response.statusCode == 200) {}

  print(response);
  print('end filterVariety get');
  return parsePlot(response.body);
}

//Post Plot
Future<int> postPlot(
  String buyerId,
  String plotNo,
  String length,
  String width,
  String marla,
  String totalAmount,
  String discount,
  String netAmount,
  String installments,
  String year,
  String month,
) async {
  final response = await http.post(Uri.http('192.168.10.2:3000', '/plot'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "BuyerId": buyerId,
        "PlotNo": plotNo,
        "Length": length,
        "Width": width,
        "Marla": marla,
        "TotalAmount": totalAmount,
        "Discount": discount,
        "NetAmount": netAmount,
        "Installments": installments,
        "Year": year,
        "Month": month,
        "Type": "Residency",
        "Date": "no",
        "ReceivedInstallments": "1",
        "RemainingInstallments": "2"
      }));

  if (response.statusCode == 200) {
    print('postPlot Success');
    return 1;
  } else {
    print('postPlot Error');
    return 0;
  }
}

class PPlot with ChangeNotifier {
  List<Plot> lPlot = [];
  bool loading = false;

  wrapperGetPlot(String buyerId) async {
    loading = true;
    notifyListeners();
    lPlot = await getPlot(http.Client(), buyerId);
    loading = false;
    notifyListeners();
  }

  wrapperPostPlot(String buyerId, plotNo, length, width, marla, totalAmount,
      discount, netAmount, installments, year, month) async {
    loading = true;
    notifyListeners();
    await postPlot(buyerId, plotNo, length, width, marla, totalAmount, discount,
        netAmount, installments, year, month);
    lPlot = await getPlot(http.Client(), buyerId);
    loading = false;
    notifyListeners();
  }
}
