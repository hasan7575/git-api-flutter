import 'package:flutter/material.dart';
import 'package:flutterprojectgitapi/view/enterUserName.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter project git API',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: "IranSans",

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: EnterUserName(),
    );
  }
}

