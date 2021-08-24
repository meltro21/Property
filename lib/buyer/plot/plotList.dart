import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:property/buyer/plot/addPlot.dart';
import 'package:property/buyer/plot/plotDetail.dart';
import 'package:property/models/plot.dart';
import 'package:http/http.dart' as http;
import 'package:property/provider/PInstallment.dart';
import 'package:property/provider/PPlot.dart';
import 'package:property/shared/loading.dart';
import 'package:provider/provider.dart';

class PlotList extends StatefulWidget {
  String buyerId;
  PlotList(this.buyerId);

  @override
  _PlotListState createState() => _PlotListState();
}

class _PlotListState extends State<PlotList> {
  List<Plot> parsePlot(String responseBody) {
    print('start parseBatch');
    final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
    print('parsed is $parsed');
    return parsed.map<Plot>((json) => Plot.fromJson(json)).toList();
  }

  Future<List<Plot>> getPlot(http.Client client) async {
    print('start FilterDailyWork get');
    var queryParameters = {'BuyerId': '${widget.buyerId}'};
    var uri =
        Uri.https('propertySabir.herokuapp.com', '/plot', queryParameters);
    print('Filter Variety uri is: $uri');
    final response = await http.get(uri);
    if (response.statusCode == 200) {}

    print(response);
    print('end filterVariety get');
    return parsePlot(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final pPlot = Provider.of<PPlot>(context, listen: false);
      pPlot.wrapperGetPlot(widget.buyerId);
    });
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text('Plots'),
          backgroundColor: Theme.of(context).primaryColorDark,
        ),
        floatingActionButton: FloatingActionButton.extended(
            backgroundColor: Theme.of(context).primaryColorDark,
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MultiProvider(providers: [
                        ChangeNotifierProvider.value(value: pPlot),
                      ], child: AddPlot(widget.buyerId))));
            },
            label: Text(
              'Add Plot',
            )),
        body: pPlot.loading
            ? Container(
                child: Loading(),
              )
            : ListView.builder(
                itemCount: pPlot.lPlot.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) =>
                              MultiProvider(providers: [
                                ChangeNotifierProvider.value(
                                    value: pInstallment),
                              ], child: PlotDetail(pPlot.lPlot[index]))));
                    },
                    child: Card(
                      elevation: .5,
                      child: ListTile(
                        tileColor: Colors.blue[50],
                        title: Text(
                          pPlot.lPlot[index].plotNo,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.purple[600]),
                        ),
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
                }));
  }
}
