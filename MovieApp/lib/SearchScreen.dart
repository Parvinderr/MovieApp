// import 'package:MovieApp/homepage.dart';
import 'package:MovieApp/personPage.dart';
import 'package:flutter/material.dart';
import 'details.dart';

class SearchScreen extends StatefulWidget {
  var details;
  SearchScreen({
    this.details,
  });

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  int total;
  var id;
  int clicked;
  var details;
  final String imageUrl = 'https://image.tmdb.org/t/p/w500/';

  @override
  void initState() {
    super.initState();

    if (widget.details != null) {
      setState(() {
        details = widget.details;
        total = details['total_results'];

        print(
          details['results'],
        );
      });
    }
  }

  // _onClick() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => Homepage(),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[700],
      appBar: AppBar(
        backgroundColor: Colors.orangeAccent,
        title: Text(
          'Movie App ',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            total == 0
                ? Container()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 40,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(
                            12,
                          ),
                        ),
                        border: Border.all(
                          color: Colors.white,
                          style: BorderStyle.solid,
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          left: 12.0,
                        ),
                        child: Text(
                          'Movies & Series',
                          style: TextStyle(
                            fontSize: 22,
                            fontStyle: FontStyle.italic,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
            total == 0 || total == null
                ? Container()
                : Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 8.0,
                      bottom: 3.0,
                      right: 8.0,
                    ),
                    child: Container(
                      height: 260,
                      decoration: BoxDecoration(),
                      child: ListView.builder(
                        itemBuilder: (context, item) {
                          return Padding(
                            padding: const EdgeInsets.only(
                              top: 5.0,
                              bottom: 8.0,
                              left: 4,
                              right: 4,
                            ),
                            child: GestureDetector(
                              onTap: () async {
                                setState(() {
                                  clicked = item;
                                  print("$clicked clicked.");
                                });

                                await Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) => details['results']
                                                [item]['media_type'] !=
                                            'person'
                                        ? Details(
                                            data: details,
                                            clicked: clicked,
                                          )
                                        : PersonPage(),
                                  ),
                                );
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 20,
                                      ),
                                      child: Text(
                                        details['results'][item]['media_type']
                                            .toString()
                                            .toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.lightGreenAccent,
                                          fontWeight: FontWeight.bold,
                                          fontStyle: FontStyle.italic,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 180,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          details['results'][item]
                                                      ['poster_path'] !=
                                                  null
                                              ? imageUrl +
                                                  details['results'][item]
                                                      ['poster_path']
                                              : details['results'][item]
                                                          ['backdrop_path'] !=
                                                      null
                                                  ? imageUrl +
                                                      details['results'][item]
                                                          ['backdrop_path']
                                                  : imageUrl +
                                                      details['results'][item]
                                                              ['known_for'][0]
                                                          ['poster_path'],
                                        ),
                                        fit: BoxFit.fill,
                                      ),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 1.2,
                                        style: BorderStyle.solid,
                                      ),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          16.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      top: 1.0,
                                      left: 2.0,
                                      bottom: 1.6,
                                    ),
                                    child: Container(
                                      width: 110,
                                      child: Column(
                                        children: [
                                          Text(
                                            details['results'][item]['title'] !=
                                                    null
                                                ? details['results'][item]
                                                        ['title']
                                                    .toString()
                                                : details['results'][item]
                                                            ['original_name'] !=
                                                        null
                                                    ? details['results'][item]
                                                            ['original_name']
                                                        .toString()
                                                    : details['results'][item]
                                                                ['name'] !=
                                                            null
                                                        ? details['results']
                                                                [item]['name']
                                                            .toString()
                                                        : details['results']
                                                                    [item]
                                                                ['original_title']
                                                            .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            details['results'][item]
                                                        ['release_date'] !=
                                                    null
                                                ? details['results'][item]
                                                        ['release_date']
                                                    .toString()
                                                : details['results'][item]['first_air_date'] != null
                                                    ? details['results'][item]
                                                            ['first_air_date']
                                                        .toString()
                                                    : details['results'][item][
                                                                'first_air_date'] ==
                                                            ''
                                                        ? details['results']
                                                                        [item]
                                                                    ['known_for'][0]
                                                                ['release_date']
                                                            .toString()
                                                        : '2020-10-9',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                            ),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        itemCount: total > 50 ? total = 19 : total,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
