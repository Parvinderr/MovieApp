import 'package:flutter/material.dart';

import 'details.dart';

class CustomListView extends StatefulWidget {
  int total;
  var details;
  var data;

  CustomListView({this.details, this.data, this.total});
  @override
  _CustomListViewState createState() => _CustomListViewState();
}

class _CustomListViewState extends State<CustomListView> {
  int clicked;
  var id;
  var details;
  String imageUrl = 'https://image.tmdb.org/t/p/w500/';
  @override
  void initState() {
    super.initState();
    if (widget.details != null) {
      setState(() {
        details = widget.details;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 240,
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.white,
          style: BorderStyle.solid,
        ),
      ),
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
              onTap: () {
                setState(() {
                  clicked = item;
                  print("$clicked clicked.");
                  if (details != null) {
                    id = details['results'][clicked]['id'].toString();
                  }
                  print(id);
                });

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Details(
                      data: {
                        'results': [
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                          {'media_type': 'movie', 'id': id},
                        ],
                      },
                      clicked: clicked,
                    ),
                  ),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 180,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                            details['results'][item]['poster_path'] == null
                                ? imageUrl +
                                    details['results'][item]['backdrop_path']
                                : imageUrl +
                                    details['results'][item]['poster_path']),
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
                            details['results'][item]['title'] != null
                                ? details['results'][item]['title'].toString()
                                : details['results'][item]['original_name'] !=
                                        null
                                    ? details['results'][item]['original_name']
                                        .toString()
                                    : details['results'][item]['name'] != null
                                        ? details['results'][item]['name']
                                            .toString()
                                        : details['results'][item]
                                                ['original_title']
                                            .toString(),
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
        itemCount: widget.total > 50 ? widget.total = 19 : widget.total,
        scrollDirection: Axis.horizontal,
      ),
    );
  }
}
