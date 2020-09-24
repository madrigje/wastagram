import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wastagram/screens/detail_screen.dart';
import 'package:wastagram/screens/list_screen.dart';
import 'package:wastagram/screens/new_entry_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.portraitUp
  ]);
  runApp(MyApp());
} 

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  const MyApp({Key key}) : super(key: key);
  
  static final routes = {
    ListScreen.routeName : (context) => ListScreen(),
    DetailScreen.routeName : (context) =>  DetailScreen(),
    NewEntryScreen.routeName : (context) => NewEntryScreen()
  };

  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: 'Wastagram',
        routes: routes,
        theme: ThemeData(
        primarySwatch: Colors.blue,
         appBarTheme: AppBarTheme(
            color: Color.fromARGB(210, 153, 0, 0),
          ),
        ),
      );
  }
}
