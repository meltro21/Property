import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart' as http;
import 'package:property/provider/PBuyer.dart';
import 'package:provider/provider.dart';

class AddBuyer extends StatefulWidget {
  @override
  _AddBuyerState createState() => _AddBuyerState();
}

class _AddBuyerState extends State<AddBuyer> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController cnicController = TextEditingController();
  TextEditingController phoneNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  final spinkit = SpinKitChasingDots(
    color: Colors.purple[300],
    size: 50.0,
  );

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
    final pBuyer = Provider.of<PBuyer>(
      context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Add Buyer Data'),
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
                  validator: (val) => val!.isEmpty ? 'Enter Name' : null,
                  decoration: InputDecoration(
                      labelText: 'Name',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: nameController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter CNIC' : null,
                  decoration: InputDecoration(
                      labelText: 'CNIC',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: cnicController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Phone #' : null,
                  decoration: InputDecoration(
                      labelText: 'Phone #',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: phoneNoController,
                ),
                TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter Address' : null,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(
                          fontFamily: 'Montserrat',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green))),
                  controller: addressController,
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      showDialogBox();
                      await pBuyer.wrapperPostBuyer(
                          nameController.text,
                          cnicController.text,
                          phoneNoController.text,
                          addressController.text);
                      Navigator.pop(context);
                      Navigator.pop(context);
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
                          'Upload Buyer',
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
