import 'dart:ui';

import 'package:expanses/widgets/new_transaction.dart';
import 'package:expanses/widgets/transaction_list.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:flutter/material.dart';


import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';

void main() {
  runApp(MyApp());
  //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      title: 'Personal Expeneses',
      theme: ThemeData(
        
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'Quicksand',
        appBarTheme: AppBarTheme(
             textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                button: TextStyle(color: Colors.white))),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  // String itemInput;
  // String amountInput;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(id: 't1', title: "new Shoes", amount: 70, date: DateTime.now()),
    // Transaction(id: 't2', title: "Groceries", amount: 170, date: DateTime.now())
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTx = Transaction(
      title: txTitle,
      amount: txAmount,
      date: chosenDate,
      id: DateTime.now().toString(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(18.0))),
        isScrollControlled: true,
        context: ctx,
        builder: (_) {
          return GestureDetector(
              onTap: () {},
              behavior: HitTestBehavior.opaque,
              child: NewTransaction(_addNewTransaction));
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) {
        return tx.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        (MediaQuery.of(context).orientation == Orientation.landscape);

    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text("Personnal expenses"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text('Personal Expenses'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () => _startAddNewTransaction(context))
            ],
          );

    final txListWidget = Container(
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context).padding.top) *
            0.7,
        child: TransactionList(_userTransactions, _deleteTransaction));
    final pageBody = SafeArea(
        child: SingleChildScrollView(
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Show Chart" ,style: Theme.of(context).textTheme.bodyText1,),
                Switch.adaptive(
                    activeColor: Theme.of(context).accentColor,
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    })
              ],
            ),
          if (!isLandscape)
            Container(height: 200, child: Chart(_recentTransactions)),
          if (!isLandscape) txListWidget,
          if (isLandscape)
            _showChart
                ? Container(
                    height: (MediaQuery.of(context).size.height -
                        45 -
                        appBar.preferredSize.height -
                        MediaQuery.of(context).padding.top),
                    child: Chart(_recentTransactions))
                : txListWidget
        ],
      ),
    ));

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar,
          )
        : Scaffold(
            appBar: appBar,
            body: SingleChildScrollView(
              child: Column(
                //mainAxisAlignment: MainAxisAlignment.spaceAround,
                //crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  if (isLandscape)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("show chart"),
                        Switch.adaptive(
                            activeColor: Theme.of(context).accentColor,
                            value: _showChart,
                            onChanged: (val) {
                              setState(() {
                                _showChart = val;
                              });
                            })
                      ],
                    ),
                  if (!isLandscape)
                    Container(height: 200, child: Chart(_recentTransactions)),
                  if (!isLandscape) txListWidget,
                  if (isLandscape)
                    _showChart
                        ? Container(
                            height: (MediaQuery.of(context).size.height -
                                45 -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top),
                            child: Chart(_recentTransactions))
                        : txListWidget
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    elevation: 20,
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ));
  }
}
