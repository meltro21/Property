import 'package:flutter/material.dart';
import 'package:property/buyer/buyerList.dart';
import 'package:property/models/buyer.dart';
import 'package:property/provider/PBuyer.dart';
import 'package:property/provider/PInstallment.dart';
import 'package:property/provider/PPlot.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => PBuyer(),
    ),
    ChangeNotifierProvider(
      create: (context) => PPlot(),
    ),
    ChangeNotifierProvider(
      create: (context) => PInstallment(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColorDark: Color(0xFF3E4685),
        primaryColorLight: Color(0xFFF1F6FE),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final pBuyer = Provider.of<PBuyer>(context);
    final pPlot = Provider.of<PPlot>(context);
    final pInstallment = Provider.of<PInstallment>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      backgroundColor: Theme.of(context).primaryColorLight,
      body: Center(
        child: Container(
          color: Theme.of(context).primaryColorLight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  color: Theme.of(context).primaryColorDark,
                  elevation: 5,
                  child: Container(
                    height: 150,
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (BuildContext context) =>
                                MultiProvider(providers: [
                                  ChangeNotifierProvider.value(value: pBuyer),
                                  ChangeNotifierProvider.value(value: pPlot),
                                  ChangeNotifierProvider.value(
                                      value: pInstallment),
                                ], child: BuyerList())));
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Buyer',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
                Card(
                  color: Theme.of(context).primaryColorDark,
                  elevation: 5,
                  child: Container(
                    height: 150,
                    width: 150,
                    child: FlatButton(
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) =>
                        //             HomeDailyWorkEntry(widget.uid,
                        //                 navigateToHomeDailyWorkEntry)));
                      },
                      child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Stats',
                            style: TextStyle(color: Colors.white),
                          )),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
