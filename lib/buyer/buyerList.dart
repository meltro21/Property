import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:property/buyer/addBuyer.dart';
import 'package:property/buyer/plot/plotList.dart';

import 'package:property/models/buyer.dart';
import 'package:property/provider/PBuyer.dart';
import 'package:property/provider/PInstallment.dart';
import 'package:property/provider/PPlot.dart';
import 'package:property/shared/loading.dart';
import 'package:provider/provider.dart';

class BuyerList extends StatefulWidget {
  @override
  _BuyerListState createState() => _BuyerListState();
}

class _BuyerListState extends State<BuyerList> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final pBuyer = Provider.of<PBuyer>(context, listen: false);
      pBuyer.wrapperGetBuyer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final pBuyer = Provider.of<PBuyer>(
      context,
    );
    final pPlot = Provider.of<PPlot>(
      context,
    );
    final pInstallment = Provider.of<PInstallment>(
      context,
    );
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        elevation: 0,
        title: Text('Buyers'),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Theme.of(context).primaryColorDark,
          icon: Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => MultiProvider(providers: [
                      ChangeNotifierProvider.value(value: pBuyer),
                    ], child: AddBuyer())));
          },
          label: Text(
            'Add Buyer',
          )),
      body: pBuyer.loading
          ? Container(
              child: Loading(),
            )
          : ListView.builder(
              itemCount: pBuyer.lBuyer.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            MultiProvider(providers: [
                              ChangeNotifierProvider.value(value: pPlot),
                              ChangeNotifierProvider.value(value: pInstallment),
                            ], child: PlotList(pBuyer.lBuyer[index].id))));
                  },
                  child: Card(
                    elevation: .5,
                    child: ListTile(
                      tileColor: Colors.blue[50],
                      title: Text(
                        pBuyer.lBuyer[index].name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.purple[600]),
                      ),
                      trailing: Text(pBuyer.lBuyer[index].phoneNo),
                      subtitle: Column(
                        children: [
                          Text(pBuyer.lBuyer[index].cnic),
                          SizedBox(
                            height: 5,
                          ),
                          Text(pBuyer.lBuyer[index].address)
                        ],
                      ),
                    ),
                  ),
                );
              }),
    );
  }
}
