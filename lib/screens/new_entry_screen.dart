import 'package:flutter/material.dart';
import 'package:wastagram/widgets/entry.dart';

class NewEntryScreen extends StatefulWidget {

  static const routeName = 'newentry';
  @override
  _NewEntryScreenState createState() => _NewEntryScreenState();
}

class _NewEntryScreenState extends State<NewEntryScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text("New Wastagram Entry"),
        ),
        body: WastagramEntry(),
      ),
    );
  }
}