import 'package:flutter/material.dart';
import 'package:todo/locator.dart';
import 'package:todo/router1.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData(
      //   fontFamily: 'Quicksand'
      //   // primarySwatch: Colors.blue,
      // ),
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily: 'Quicksand',

        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) => Router1.generateRoute(settings),
      initialRoute: "/",
    );
  }
}

