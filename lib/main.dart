import 'package:flutter/material.dart';
import '../screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
        dividerColor: Colors.grey[800],
        accentColor: Colors.cyanAccent,
        backgroundColor: Colors.grey[300],
        focusColor: Colors.cyanAccent,
        fontFamily: 'MyFont',
      ),
      routes: {
        '/': (ctx) => MainScreen(),
      },
    );
  }
}
