import 'package:flutter/material.dart';
import 'package:wastagram/screens/detail_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class ListScreen extends StatefulWidget {
  static const routeName = '/';

  @override
  _ListScreenState createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var waste;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
            child: Center(
                child: StreamBuilder(
                    stream: Firestore.instance.collection('list').snapshots(),
                    builder: (content, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data.documents != null &&
                          snapshot.data.documents.length > 0) {
                        waste = 0;
                        for (var i = 0;
                            i < snapshot.data.documents.length;
                            i++) {
                          waste += snapshot.data.documents[i]['Total'];
                          if (waste == null) {
                            waste = 0;
                          }
                        }
                        return scaffold(context, waste, _scaffoldKey, snapshot);
                      } else {
                        return emptyScaffold(context, _scaffoldKey);
                      }
                    }))));
  }
}

Widget scaffold(BuildContext context, int waste,
    GlobalKey<ScaffoldState> _scaffoldKey, AsyncSnapshot<dynamic> snapshot) {
  return Scaffold(
    key: _scaffoldKey,
    appBar: AppBar(
      title: Text('Wastagram - $waste'),
    ),
    bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: Container(
        height: 50.0,
      ),
    ),
    floatingActionButton: Semantics(
      child: newEntryButton(context),
      button: true,
      enabled: true,
      onTapHint: 'Select an image',
      label: 'This button is used to send you to new entry screen',
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    body: ListView.builder(
      itemExtent: 80.0,
      itemCount: snapshot.data.documents.length,
      itemBuilder: (context, index) =>
          _buildListItem(context, snapshot.data.documents[index]),
    ),
  );
}

Widget emptyScaffold(
    BuildContext context, GlobalKey<ScaffoldState> _scaffoldKey) {
  return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Wastagram - 0'),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        child: Container(
          height: 50.0,
        ),
      ),
      floatingActionButton: Semantics(
        child: newEntryButton(context),
        button: true,
        enabled: true,
        onTapHint: 'Select an image',
        label: 'This button is used to send you to new entry screen',
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Center(child: CircularProgressIndicator()));
}

Widget _buildListItem(BuildContext context, DocumentSnapshot document) {
  return Semantics(
    selected: true,
    enabled: true,
    onTapHint: 'List details for entry.',
    child: ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              //https://stackoverflow.com/questions/56627888/how-to-print-firestore-timestamp-as-formatted-date-and-time-in-flutter
              DateFormat.yMMMd()
                  .add_jm()
                  .format(DateTime.parse(document['Date'].toDate().toString())),
              style: Theme.of(context).textTheme.headline5,
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xffddddff),
            ),
            padding: const EdgeInsets.all(10.0),
            child: Text(
              document['Total'].toString(),
              style: Theme.of(context).textTheme.headline4,
            ),
          ),
        ],
      ),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(document: document),
          ),
        );
      }),
  );
}

Widget newEntryButton(BuildContext context) {
  return FloatingActionButton(
    tooltip: 'New Entry',
    child: Icon(Icons.add),
    onPressed: () {
      Navigator.pushNamed(context, 'newentry');
    },
  );
}
