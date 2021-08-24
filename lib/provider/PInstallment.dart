import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:property/models/installment.dart';
import 'package:http/http.dart' as http;

List<Installment> parseInstallment(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('parsed is $parsed');
  return parsed.map<Installment>((json) => Installment.fromJson(json)).toList();
}

Future<List<Installment>> getInstallment(
    http.Client client, String plotId) async {
  print('start FilterDailyWork get');
  var queryParameters = {'PlotId': '$plotId'};
  var uri = Uri.http('192.168.10.2:3000', '/installment', queryParameters);
  print('Filter Variety uri is: $uri');
  final response = await http.get(uri);
  if (response.statusCode == 200) {}

  print(response);
  print('end filterVariety get');
  return parseInstallment(response.body);
}

class PInstallment with ChangeNotifier {
  List<Installment> lInstallment = [];
  bool loading = false;

  wrapperGetInstallment(String plotId) async {
    loading = true;
    notifyListeners();
    lInstallment = await getInstallment(http.Client(), plotId);
    loading = false;
    notifyListeners();
  }
}
