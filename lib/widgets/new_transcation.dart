import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTranscation extends StatefulWidget {
  final Function addTx;

  NewTranscation(this.addTx);

  @override
  _NewTranscationState createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final titleHandler = TextEditingController();

  final amountHandler = TextEditingController();
  DateTime selectedDate;
  void submitData() {
    final titleinput = titleHandler.text;
    final amoutinput = double.parse(amountHandler.text);
    if (titleinput.isEmpty || amoutinput < 0 || selectedDate == null) {
      return;
    }

    widget.addTx(
      titleinput,
      amoutinput,
      selectedDate,
    );
    Navigator.of(context).pop();
  }

  void pickDate() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickDate) {
      if (pickDate == null) {
        return;
      }
      setState(() {
        selectedDate = pickDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleHandler,
              onSubmitted: (_) => submitData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountHandler,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      selectedDate == null
                          ? 'Please Pick Date'
                          : 'Picked Date: ${DateFormat.yMd().format(selectedDate)}',
                    ),
                  ),
                  FlatButton(
                    onPressed: pickDate,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                'Transcation Add',
                style: TextStyle(color: Colors.white),
              ),
              color: Colors.purple,
              onPressed: submitData,
            )
          ],
        ),
      ),
    );
  }
}
