import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List transcations;
  final Function deleteItems;
  TransactionList(this.transcations, this.deleteItems);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: transcations.isEmpty
          ? Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'No Transations Yet',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 200,
                    child: Image(
                      image: AssetImage('assets/images/waiting.png'),
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      child: Padding(
                        padding: EdgeInsets.all(6),
                        child: FittedBox(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Text(
                              '\$${transcations[index].price}',
                              style: Theme.of(context).textTheme.headline6,
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transcations[index].title,
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        transcations[index].date,
                      ),
                    ),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                      onPressed: () => deleteItems(
                        transcations[index].id,
                      ),
                    ),
                  ),
                );
              },
              itemCount: transcations.length,
            ),
    );
  }
}
