import 'package:flutter/material.dart';

class NewTranscation extends StatefulWidget {
  final Function addTx;

  NewTranscation(this.addTx);

  @override
  _NewTranscationState createState() => _NewTranscationState();
}

class _NewTranscationState extends State<NewTranscation> {
  final titleHandler = TextEditingController();

  final amountHandler = TextEditingController();

  void submitData() {
    final titleinput = titleHandler.text;
    final amoutinput = double.parse(amountHandler.text);
    if (titleinput.isEmpty || amoutinput < 0) {
      return;
    }

    widget.addTx(
      titleinput,
      amoutinput,
    );
    Navigator.of(context).pop();
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
                onSubmitted: (_) => submitData()),
            RaisedButton(
              child: Text(
                'Add',
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
