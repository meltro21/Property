import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:property/provider/PPlot.dart';
import 'package:provider/provider.dart';

class AddPlot extends StatefulWidget {
  String buyerId;
  AddPlot(this.buyerId);

  @override
  _AddPlotState createState() => _AddPlotState();
}

class _AddPlotState extends State<AddPlot> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController plotNoController = TextEditingController();
  TextEditingController lengthController = TextEditingController();
  TextEditingController widthController = TextEditingController();
  TextEditingController marlaController = TextEditingController();
  TextEditingController totalAmountController = TextEditingController();
  TextEditingController discountController = TextEditingController();
  TextEditingController netAmountController = TextEditingController();
  TextEditingController installmentsController = TextEditingController();
  TextEditingController yearController = TextEditingController();
  TextEditingController monthController = TextEditingController();
  TextEditingController typeController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  final spinkit = SpinKitChasingDots(
    color: Colors.purple[300],
    size: 50.0,
  );

  Future<int> postPlot(
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
    final response =
        await http.post(Uri.https('propertysabir.herokuapp.com', '/plot'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, String>{
              "BuyerId": widget.buyerId,
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

  void showDialogBox() {
    showCupertinoDialog(
        context: context,
        builder: (_) => Container(
              color: Theme.of(context).primaryColorLight,
              child: AlertDialog(
                content: Container(width: 50, height: 50, child: spinkit),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    final pPlot = Provider.of<PPlot>(
      context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Add Plot Data'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 15, right: 15),
        child: SingleChildScrollView(
            child: Column(children: [
          Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Plot#' : null,
                  decoration: InputDecoration(
                      labelText: 'Plot #',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: plotNoController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Length' : null,
                  decoration: InputDecoration(
                      labelText: 'Length',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: lengthController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Width' : null,
                  decoration: InputDecoration(
                      labelText: 'Width',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: widthController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Marla' : null,
                  decoration: InputDecoration(
                      labelText: 'Marla',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: marlaController,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Enter Total Amount' : null,
                  decoration: InputDecoration(
                      labelText: 'Total Amount',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: totalAmountController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Discount' : null,
                  decoration: InputDecoration(
                      labelText: 'Discount',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: discountController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Net Amount' : null,
                  decoration: InputDecoration(
                      labelText: 'Net Amount',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: netAmountController,
                ),
                TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Enter Installments' : null,
                  decoration: InputDecoration(
                      labelText: 'Installments',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: installmentsController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Year' : null,
                  decoration: InputDecoration(
                      labelText: 'Year',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: yearController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'EnterMonth' : null,
                  decoration: InputDecoration(
                      labelText: 'Month',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: monthController,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialogBox();
                      await pPlot.wrapperPostPlot(
                        widget.buyerId,
                        plotNoController.text,
                        lengthController.text,
                        widthController.text,
                        marlaController.text,
                        totalAmountController.text,
                        discountController.text,
                        netAmountController.text,
                        installmentsController.text,
                        yearController.text,
                        monthController.text,
                      );
                      Navigator.pop(context);
                      Navigator.pop(context);

                      // widget.navigateToHomeBuyer();
                    }
                  },
                  child: Container(
                    height: 50.0,
                    child: Material(
                      borderRadius: BorderRadius.circular(20.0),
                      shadowColor: Colors.greenAccent,
                      color: Theme.of(context).primaryColorDark,
                      elevation: 7.0,
                      child: Center(
                        child: Text(
                          'Upload Plot',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Montserrat'),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ])),
      ),
    );
  }
}
