import 'dart:convert';
import 'package:MovieApp/errorPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'SearchScreen.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    bool isDark = true;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: isDark ? Colors.grey[100] : Colors.grey[700],
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
        body: AppBody(),
      ),
    );
  }
}

class AppBody extends StatefulWidget {
  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  var data;
  String title;

  TextEditingController _controller = new TextEditingController();
  String query;
  bool click = false;
  bool dataCheck = false;
  String url =
      'https://api.themoviedb.org/3/search/multi?api_key=a7bcf108bb5f8d638ffb151cc30e1127&query=';

  Future<String> getJson() async {
    query = _controller.text;
    String urlNew = url + query;
    var resp = await http.get(urlNew);
    print(resp.statusCode);

    setState(() {
      var jsonData = jsonDecode(resp.body);
      print(jsonData);
      data = jsonData;
      title = data['results'][0]['title'];
    });
    return 'Sucess';
  }

  _onclick() {
    if (data != null) {
      dataCheck = true;
    }
    setState(() {
      click = true;
      this.getJson();
    });

    if (dataCheck == true) {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => data['total_results'] == 0
                ? ErrorPage()
                : SearchScreen(
                    details: data,
                  )),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    setState(() {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Divider(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              showCursor: true,
              controller: _controller,
              scrollPhysics: BouncingScrollPhysics(),
              cursorColor: Colors.grey[600],
              maxLength: 70,
              decoration: InputDecoration(
                hoverColor: Colors.pink[100],
                fillColor: Colors.orangeAccent,
                labelText: 'Search',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      22.0,
                    ),
                  ),
                ),
                focusColor: Colors.orange,
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.search,
                  ),
                  onPressed: _controller.text == null ? () {} : _onclick,
                ),
              ),
            ),
          ),
          Container(
            child:
                data == null ? Text('Enter Text For Searching..') : Text(title),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              child: click == false || dataCheck == true
                  ? null
                  : CircularProgressIndicator(
                      backgroundColor: Colors.orangeAccent,
                    ))
        ],
      ),
    );
  }
}
