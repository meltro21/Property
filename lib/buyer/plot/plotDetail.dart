import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart ';
import 'package:property/buyer/plot/installment/seeDetail.dart';
import 'package:property/models/plot.dart';
import 'package:property/provider/PInstallment.dart';
import 'package:provider/provider.dart';

class PlotDetail extends StatefulWidget {
  Plot plot;
  PlotDetail(this.plot);

  @override
  _PlotDetailState createState() => _PlotDetailState();
}

class _PlotDetailState extends State<PlotDetail> {
  double leftWidth = 160;
  double rightWidth = 60;
  double leftFontSize = 24;
  double rightFontSize = 16;
  @override
  Widget build(BuildContext context) {
    final pInstallment = Provider.of<PInstallment>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorDark,
        title: Text('Plot Detail'),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: leftWidth,
                  child: Text(
                    "Plot #",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: leftFontSize),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.plot.plotNo},",
                  style: TextStyle(fontSize: rightFontSize),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: leftWidth,
                  child: Text(
                    "Length",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: leftFontSize),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.plot.length}",
                  style: TextStyle(fontSize: rightFontSize),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: leftWidth,
                  child: Text(
                    "Width",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: leftFontSize),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.plot.width}",
                  style: TextStyle(fontSize: rightFontSize),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: leftWidth,
                  child: Text(
                    "Marla",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: leftFontSize),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.plot.marla}",
                  style: TextStyle(fontSize: rightFontSize),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: leftWidth,
                  child: Text(
                    "Total Amount",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: leftFontSize),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.plot.totalAmount}",
                  style: TextStyle(fontSize: rightFontSize),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: leftWidth,
                  child: Text(
                    "Net Amount",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: leftFontSize),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.plot.netAmount}",
                  style: TextStyle(fontSize: rightFontSize),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: leftWidth,
                  child: Text(
                    "Installments",
                    style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: leftFontSize),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.plot.installments}",
                  style: TextStyle(fontSize: rightFontSize),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Container(
                  width: leftWidth,
                  child: Text("Duration",
                      style: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: leftFontSize,
                      )),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "${widget.plot.plotNo}",
                  style: TextStyle(fontSize: rightFontSize),
                )
              ],
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () async {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => MultiProvider(
                                providers: [
                                  ChangeNotifierProvider.value(
                                      value: pInstallment),
                                ],
                                child: SeeDetail(
                                    widget.plot.plotId,
                                    widget.plot.plotNo,
                                    widget.plot.receivedAmount,
                                    widget.plot.remainingAmount,
                                    widget.plot.totalAmount))));
              },
              child: Container(
                height: 40,
                child: Material(
                  borderRadius: BorderRadius.circular(20.0),
                  shadowColor: Colors.greenAccent,
                  color: Theme.of(context).primaryColorDark,
                  elevation: 7.0,
                  child: Center(
                    child: Text(
                      'See Details',
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
      ),
    );
  }
}
