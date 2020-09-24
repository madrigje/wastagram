import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';


class DetailScreen extends StatefulWidget {
  final DocumentSnapshot document;
  static const routeName = 'detail';
  DetailScreen({Key key, @required this.document}) : super(key: key);
  @override
  _DetailScreenState createState() => _DetailScreenState(document);
}

class _DetailScreenState extends State<DetailScreen> {
  DocumentSnapshot document;

  _DetailScreenState(this.document);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wastagram'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: [
              //https://stackoverflow.com/questions/56627888/how-to-print-firestore-timestamp-as-formatted-date-and-time-in-flutter
              Text(DateFormat.yMMMd().add_jm().format(DateTime.parse(document.get(['Date']).toDate().toString())),
                style: Theme.of(context).textTheme.headline4),
              Semantics(
                label: 'A picture of food waste.',
                child: Image(image: NetworkImage('${document.get(['Picture'])}'))
                ),
              //SizedBox(height: 5.0),
              Text('Number of Items: ${document.get(['Total'])}'.toString(),
                style: Theme.of(context).textTheme.headline5),
              Text('Location: (${document.get(['longitude'])}, ${document.get(['latitude'])})',
                style: Theme.of(context).textTheme.headline5,),
            ],
          )
          ),
      ),
    );
  }
}