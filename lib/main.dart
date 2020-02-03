import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

import 'homeview.dart' as HomeView;

void main() {
  runApp(TourismApp());
}

class TourismApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeView.HomeScreen(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.green,
        accentColor: Colors.green[300],
        // fontFamily: '',
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 64.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(
              // color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'Roboto'),
          bodyText1: TextStyle(fontSize: 24.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          // headline1: TextStyle(fontSize: 24.0),
        ),
      ),
    );
  }
}
