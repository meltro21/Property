import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:property/models/buyer.dart';
import 'package:http/http.dart' as http;

//Get Buyer
List<Buyer> parseBuyer(String responseBody) {
  print('start parseBatch');
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  print('parsed is $parsed');
  return parsed.map<Buyer>((json) => Buyer.fromJson(json)).toList();
}

Future<List<Buyer>> getBuyer(http.Client client) async {
  print('getBuyer');
  final response =
      await client.get(Uri.parse('http://192.168.10.2:3000/buyer'));
  print('response is: ${response.body}');
  //return compute(parseBuyer, response.body);
  return parseBuyer(response.body);
}

//Post Buyer
Future<int> postBuyer(
  String name,
  String cnic,
  String phoneNo,
  String address,
) async {
  final response = await http.post(Uri.http('192.168.10.2:3000', '/buyer'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Name": name,
        "CNIC": cnic,
        "PhoneNo": phoneNo,
        "Address": address,
      }));

  if (response.statusCode == 200) {
    print('postBuyer Success');
    return 1;
  } else {
    print('postBuyer Error');
    return 0;
  }
}

class PBuyer with ChangeNotifier {
  List<Buyer> lBuyer = [];
  bool loading = false;

  wrapperGetBuyer() async {
    loading = true;
    notifyListeners();
    lBuyer = await getBuyer(http.Client());
    loading = false;
    notifyListeners();
  }

  wrapperPostBuyer(String name, cnic, phoneNo, address) async {
    loading = true;
    notifyListeners();
    await postBuyer(name, cnic, phoneNo, address);
    lBuyer = await getBuyer(http.Client());
    loading = false;
    notifyListeners();
  }
}
