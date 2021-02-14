import 'package:flutter/material.dart';
import 'homepage.dart';

void main() {
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String title = 'Movie App';
    return MaterialApp(
      title: title,
      home: Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
