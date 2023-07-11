import 'package:flutter/material.dart';
import 'package:front/routes.dart';

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
        primaryColor: Color(0xFFeea734),
        scaffoldBackgroundColor: Color(0xFFDFD4B4)
      ),
      routes: routes,
    );
  }
}