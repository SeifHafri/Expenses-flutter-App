import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _userTransactions;
  final Function deleteTx;
  TransactionList(this._userTransactions,this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: _userTransactions.isEmpty
            ? Column(
                children: <Widget>[
                  Text(
                    "No transactions added yet",
                    style: Theme.of(context).textTheme.body1,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      height: 200,
                      child: Image.asset(
                        'assets/image/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                    elevation: 5,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                    child: ListTile(
                      trailing: IconButton(icon: Icon(Icons.delete,color: Theme.of(context).errorColor,), onPressed:() => deleteTx(_userTransactions[index].id)),
                      leading: CircleAvatar(
                        radius: 30,
                        child: Padding(
                            padding: EdgeInsets.all(6),
                            child: FittedBox(
                                child: Text(_userTransactions[index]
                                    .amount
                                    .toString()))),
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
              ));
  }
}
