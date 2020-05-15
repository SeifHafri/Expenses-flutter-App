import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;
  TransactionList(this._userTransactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return _userTransactions.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
          return Column(
            children: <Widget>[
              Text(
                "No transactions added yet",
                textScaleFactor: 1.4,
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                  height: constraints.maxHeight*0.6 ,
                  child: Image.asset(
                    'assets/image/waiting.png',
                    fit: BoxFit.cover,
                  )),
            ],
          );
          
        },) 
        : ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  trailing: IconButton(
                      icon: Icon(
                        Icons.delete_sweep,
                        color: Theme.of(context).errorColor,
                      ),
                      onPressed: () => deleteTx(_userTransactions[index].id)),
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                            child: Text(
                                _userTransactions[index].amount.toString()))),
                  ),
                  title: Text(
                    _userTransactions[index].title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(DateFormat.yMMMd()
                      .format((_userTransactions[index].date))),
                ),
              );
            },
            itemCount: _userTransactions.length,
          );
  }
}
