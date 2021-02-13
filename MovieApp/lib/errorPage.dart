import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class ErrorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var parser = EmojiParser();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Movie App',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              parser.emojify(':pensive:'),
              style: TextStyle(
                fontSize: 28,
                color: Colors.grey[50],
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              parser.emojify(
                  'Couldn\'t Find Anything!:pensive: Please Search Again.'),
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey[100],
                  wordSpacing: 1.4),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[600],
    );
  }
}
