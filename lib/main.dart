import 'package:flutter/material.dart';
import 'package:newsapp/providers/category.dart';
import 'package:newsapp/providers/news.dart';
import 'package:newsapp/screens/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
  return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>Categories(),),
        ChangeNotifierProvider(create: (_)=>NewsReports())
    ],
    child:MaterialApp(title: 'newsApp',
    theme: ThemeData(
                // fontFamily: 'Lato',
                primarySwatch: Colors.cyan,
                accentColor: Colors.amber),
    home: Home()
    ),
    );
  }
}