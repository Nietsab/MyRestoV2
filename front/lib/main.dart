import 'package:flutter/material.dart';
import 'package:front/app/app.dart';
// import 'package:front/app/tabs/home/details/details.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "My Resto",
      theme: ThemeData(
        fontFamily: "Cera Pro",
        primaryColor: Color(0xFFE85852),
      ),
      routes: {
        // 'details': (context) => Details(),
      },
      home: App(),
    );
  }
}