import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List transcations;
  TransactionList(this.transcations);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 600,
      child: transcations.isEmpty
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('No Transations Yet',
                    style: Theme.of(context).textTheme.headline6),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 100,
                  child: Image(
                    image: AssetImage('assets/images/waiting.png'),
                    fit: BoxFit.cover,
                  ),
                )
              ],
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
                          child: Text(
                            '\$${transcations[index].price}',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transcations[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(
                        transcations[index].date,
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
