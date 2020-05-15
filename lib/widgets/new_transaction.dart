import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _itemController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if(_amountController.text.isEmpty){return ;}
    final enteredTitle = _itemController.text;
    final enteredAmount = double.parse(_amountController.text);
    


    if ((enteredTitle.isEmpty) || (enteredAmount <= 0) || _selectedDate==null) {

      return;
    }

    widget.addTx(enteredTitle, enteredAmount,_selectedDate);
    Navigator.of(context).pop();
  }

  void _presentDatePicker(){
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1970), lastDate: DateTime.now()).then((pickedDate){
      if(pickedDate == null){ return;}
      setState((){
      _selectedDate = pickedDate;
      });

     
      
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
          child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(top:10,left: 10,right: 10,bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                onSubmitted: (_) => _submitData(),
                controller: _itemController,
                decoration: InputDecoration(labelText: "Item"),
              ),
              TextField(
                onSubmitted: (_) => _submitData(),
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: "Amount"),
                controller: _amountController,
              ),
              Container(
                height: 70,
                
                child: Row(
                  children: <Widget>[
                    Expanded(child: Text(_selectedDate==null ? 'No date chosen' : "Date choisie: ${DateFormat.yMd().format(_selectedDate)}")),
                    FlatButton(child: Text("Choose Date",style:  TextStyle(fontWeight:  FontWeight.bold),),textColor: Theme.of(context).primaryColor,onPressed: _presentDatePicker,)
                  ],
                ),
              ),
              RaisedButton(
                shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(16.0)),
                onPressed: _submitData,
                child: Text("Add transaction"),
                // textColor: Theme.of(context).textTheme.button.color,
                textColor: Colors.white,
                color: Colors.purple,
              )
            ],
          ),
        ),
      ),
    );
  }
}
