import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:property/models/installment.dart';
import 'package:http/http.dart' as http;
import 'package:property/provider/PInstallment.dart';
import 'package:property/shared/loading.dart';
import 'package:provider/provider.dart';

class SeeDetail extends StatefulWidget {
  String plotId, plotNo, receivedAmount, remainingAmount, totalAmount;
  SeeDetail(this.plotId, this.plotNo, this.receivedAmount, this.remainingAmount,
      this.totalAmount);

  @override
  _SeeDetailState createState() => _SeeDetailState();
}

class _SeeDetailState extends State<SeeDetail> {
  final oCcy = new NumberFormat("#,##0.00", "en_US");

  List<Installment> parseInstallment(String responseBody) {
    print('start parseBatch');
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print('parsed is $parsed');
    return parsed
        .map<Installment>((json) => Installment.fromJson(json))
        .toList();
  }

  Future<List<Installment>> getInstallment(http.Client client) async {
    print('start FilterDailyWork get');
    var queryParameters = {'PlotId': '${widget.plotId}'};
    var uri = Uri.http('192.168.10.2:3000', '/installment', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return parseInstallment(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final pInstallment = Provider.of<PInstallment>(context, listen: false);
      pInstallment.wrapperGetInstallment(widget.plotId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final pInstallment = Provider.of<PInstallment>(
      context,
    );
    return SafeArea(
      child: Scaffold(
          backgroundColor: Theme.of(context).primaryColorLight,
          body: Container(
              child: Column(children: [
            Container(
              margin: EdgeInsets.all(20),
              child: Card(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Plot# ${widget.plotNo}',
                            style: TextStyle(
                                fontSize: 30,
                                color: Theme.of(context).primaryColorDark,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              '${oCcy.format(double.parse(widget.receivedAmount))} rs',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              '${oCcy.format(double.parse(widget.remainingAmount))} rs',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              '${oCcy.format(double.parse(widget.totalAmount))} rs',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorDark,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: Text(
                              'Received    ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Remaining',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              'Total        ',
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              padding: EdgeInsets.only(left: 20),
              alignment: Alignment.topLeft,
              child: Text(
                'Overview',
                style: TextStyle(
                    fontSize: 30,
                    color: Theme.of(context).primaryColorDark,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                height: 400,
                child: pInstallment.loading
                    ? Container(
                        child: Loading(),
                      )
                    : ListView.builder(
                        itemCount: pInstallment.lInstallment.length,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) =>
                              //             PlotDetail(snapshot.data![index])));
                            },
                            child: Card(
                              elevation: .5,
                              child: ListTile(
                                tileColor: Colors.blue[50],
                                title: Text(
                                  '1',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.purple[600]),
                                ),
                                trailing: Text(
                                    '${pInstallment.lInstallment[index].amount}'),
                                subtitle: Text(DateFormat.yMMMEd().format(
                                    DateTime.parse(pInstallment
                                        .lInstallment[index].date))),
                                // trailing: Text(snapshot.data![index].phoneNo),
                                // subtitle: Column(
                                //   children: [
                                //     Text(snapshot.data![index].cnic),
                                //     SizedBox(
                                //       height: 5,
                                //     ),
                                //     Text(snapshot.data![index].address)
                                //   ],
                                // ),
                              ),
                            ),
                          );
                        }))
          ]))),
    );
  }
}
