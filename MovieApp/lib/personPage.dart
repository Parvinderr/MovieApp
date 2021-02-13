import 'package:flutter/material.dart';
import 'package:flutter_emoji/flutter_emoji.dart';

class PersonPage extends StatefulWidget {
  @override
  _PersonPageState createState() => _PersonPageState();
}

class _PersonPageState extends State<PersonPage> {
  var parser = EmojiParser();

  @override
  void initState() {
    super.initState();
    setState(() {
      print(parser.getEmoji('😔'));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
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
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: Text(
              parser.emojify(':pensive:'),
              style: TextStyle(fontSize: 50, color: Colors.grey),
            ),
          ),
          SizedBox(height: 4),
          Container(
            child: Text(
              parser.emojify('Sorry Can\'t find data :pensive:'),
              style: TextStyle(
                color: Colors.grey[100],
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
