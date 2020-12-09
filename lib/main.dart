import 'package:expense_app/widgets/new_transcation.dart';
import 'package:flutter/material.dart';
import './widgets/transcation_list.dart';
import './models/transcations.dart';
import './widgets/chart.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Expense App',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: 'QuickSand',
        textTheme: ThemeData.light().textTheme.copyWith(
              title: TextStyle(
                fontFamily: 'OpenSans',
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
        appBarTheme: AppBarTheme(
          textTheme: ThemeData.light().textTheme.copyWith(
                title: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transcations> _transcations = [
    Transcations(
      id: 't1',
      title: 'Shoes',
      price: 70.01,
      date: DateTime.now(),
    ),
    Transcations(
      id: 't2',
      title: 'Dress',
      price: 80.25,
      date: DateTime.now(),
    )
  ];

  void _addtranscation(String title, double price, DateTime cuDate) {
    final newTx = Transcations(
      title: title,
      price: price,
      date: cuDate,
      id: DateTime.now().toString(),
    );
    setState(() {
      _transcations.add(newTx);
    });
  }

  void _addNew(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return NewTranscation(_addtranscation);
        });
  }

  List<Transcations> get _recentTransations {
    return _transcations.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void deleteItem(id) {
    setState(() {
      _transcations.removeWhere((tx) => tx.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text('Transcation App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _addNew(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Chart(_recentTransations),
            TransactionList(_transcations, deleteItem),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).accentColor,
        child: Icon(Icons.add),
        onPressed: () => _addNew(context),
      ),
    );
  }
}
