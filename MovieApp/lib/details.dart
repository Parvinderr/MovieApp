import 'dart:convert';
import 'package:MovieApp/similar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Details extends StatefulWidget {
  var data;
  int clicked;
  Details({
    this.data,
    this.clicked,
  });
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  final String imageUrl = 'https://image.tmdb.org/t/p/w500';
  var castData;
  var searchData;
  int click;
  var data;
  var similarData;

  var id;
  String apiKey = '?api_key=a7bcf108bb5f8d638ffb151cc30e1127';
  String movieUrl = "https://api.themoviedb.org/3/movie/";
  String seriesUrl = "https://api.themoviedb.org/3/tv/";

  Future<String> moviesimilarJson() async {
    var movieUrlNew = movieUrl + id + '/similar' + apiKey;
    print(movieUrlNew);
    var resp = await http.get(movieUrlNew);
    print(resp.statusCode);
    setState(() {
      var json = jsonDecode(resp.body);
      similarData = json;
      print(similarData);
    });
    return 'Sucess';
  }

  Future<String> movieJson() async {
    var movieUrlNew = movieUrl + id + '/credits' + apiKey;
    print(movieUrlNew);
    var resp = await http.get(movieUrlNew);
    setState(() {
      var json = jsonDecode(resp.body);
      castData = json;
    });
    return 'Sucess';
  }

  Future<String> seriesJson() async {
    var seriesUrlNew = seriesUrl + id + '/credits' + apiKey;
    print(seriesUrlNew);
    var resp = await http.get(seriesUrlNew);

    setState(() {
      var json = jsonDecode(resp.body);
      castData = json;
    });
    return 'Sucess';
  }

  Future<String> searchMovieJson() async {
    var movieUrlNew = movieUrl + id + apiKey;
    var resp = await http.get(movieUrlNew);

    setState(() {
      var json = jsonDecode(resp.body);
      searchData = json;
    });
    return 'Sucess';
  }

  Future<String> searchSeriesJson() async {
    var movieUrlNew = seriesUrl + id + apiKey;
    var resp = await http.get(movieUrlNew);
    setState(() {
      var json = jsonDecode(resp.body);
      searchData = json;
    });
    return 'Sucess';
  }

  @override
  void initState() {
    super.initState();
    if (widget.data != null) {
      setState(() {
        data = widget.data;
        click = widget.clicked;
        id = data['results'][click]['id'].toString();
        if (data['results'][click]['media_type'] == 'movie') {
          castData = this.movieJson();
          searchData = this.searchMovieJson();
        } else if (data['results'][click]['media_type'] == 'tv') {
          castData = this.seriesJson();
          searchData = this.searchSeriesJson();
        }
        // print(castData);
        // print(searchData);
        this.moviesimilarJson();
        print(similarData);
        // print(widget.data);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      backgroundColor: Colors.grey[700],
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(1.0),
                child: Stack(
                  overflow: Overflow.visible,
                  fit: StackFit.loose,
                  children: [
                    Container(
                      width: double.infinity,
                      height: 180,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        image: DecorationImage(
                          image: searchData != null
                              ? NetworkImage(
                                  imageUrl + searchData['backdrop_path'],
                                )
                              : null,
                          fit: BoxFit.fill,
                        ),
                        border: Border.all(
                          width: 2.0,
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 125,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 1.0,
                              left: 3.0,
                            ),
                            child: Container(
                              height: 180,
                              width: 140,
                              decoration: BoxDecoration(
                                  color: Colors.grey[100],
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        imageUrl + searchData['poster_path'],
                                      ),
                                      fit: BoxFit.fill),
                                  border: Border.all(
                                      color: Colors.white,
                                      style: BorderStyle.solid,
                                      width: 2.4)),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(top: 8.0, left: 12.0),
                            child: Container(
                              child: Column(
                                children: [
                                  Text(
                                    searchData['title'] == null
                                        ? searchData['original_title']
                                        : searchData['title'],
                                    softWrap: true,
                                    textWidthBasis: TextWidthBasis.longestLine,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                          blurRadius: 3.0,
                                          color: Colors.grey[800],
                                          offset: Offset(
                                            -1,
                                            1,
                                          ),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.visible,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: 3,
                                    ),
                                    child: Container(
                                      height: 24,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.white,
                                          width: 1,
                                          style: BorderStyle.solid,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          searchData['release_date'],
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 130),
                child: Container(
                  height: 90,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.white)),
                  child: ListView.builder(
                    itemCount: 8,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, i) {
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 2.0,
                          right: 3.0,
                        ),
                        child: Container(
                          width: 80,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.white,
                            ),
                            color: Colors.grey[600],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            // crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                foregroundColor: Colors.pink,
                                backgroundImage: NetworkImage(
                                  castData['cast'][i]['profile_path'] == Null ||
                                          castData['cast'][i]['profile_path'] ==
                                              null
                                      ? 'https://www.pngkit.com/png/detail/281-2812821_user-account-management-logo-user-icon-png.png'
                                      : imageUrl +
                                          castData['cast'][i]['profile_path'],
                                ),
                                radius: 30,
                              ),
                              Text(
                                castData['cast'][i]['name'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 4.0,
                  top: 8.0,
                  right: 4.0,
                ),
                child: Container(
                  decoration: BoxDecoration(),
                  child: Padding(
                    padding: EdgeInsets.all(9.0),
                    child: Text(
                      searchData['overview'],
                      style: TextStyle(
                        color: Colors.grey[50],
                        fontSize: 17,
                        fontStyle: FontStyle.italic,
                        wordSpacing: 1.4,
                        letterSpacing: 1.2,
                        // decoration: TextDecoration.overline,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Similiar Movies',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ),
              ),
              CustomListView(
                details: similarData,
                total: 15,
              )
            ],
          ),
        ),
      ),
    );
  }
}
