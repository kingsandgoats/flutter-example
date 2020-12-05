import 'package:flutter/foundation.dart';

class Transcations {
  // final is a runtime constantant
  final String id;
  final String title;
  final double price;
  final DateTime date;

  Transcations({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.date,
  });
}
