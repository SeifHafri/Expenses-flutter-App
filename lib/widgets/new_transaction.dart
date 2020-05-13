import 'package:flutter/material.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final itemController = TextEditingController();

  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = itemController.text;
    final enteredAmount = double.parse(amountController.text);
    if ((enteredTitle.isEmpty) || (enteredAmount <= 0)) {
      return;
    }

    widget.addTx(enteredTitle, enteredAmount);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              onSubmitted: (_) => submitData(),
              controller: itemController,
              decoration: InputDecoration(labelText: "Item"),
            ),
            TextField(
              onSubmitted: (_) => submitData(),
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: "Amount"),
              controller: amountController,
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Text('No date chosen'),
                  FlatButton(child: Text("Choose Date",style:  TextStyle(fontWeight:  FontWeight.bold),),textColor: Theme.of(context).primaryColor,onPressed: () {}),
                ],
              ),
            ),
            RaisedButton(
              shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(16.0)),
              onPressed: submitData,
              child: Text("Add transaction"),
              // textColor: Theme.of(context).textTheme.button.color,
              textColor: Colors.white,
              color: Colors.purple,
            )
          ],
        ),
      ),
    );
  }
}
