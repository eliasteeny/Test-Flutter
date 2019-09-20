import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';
import 'package:task_job/services/request_hotels_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: scafold(),
    );
  }
}

Widget scafold() {
  return Scaffold(
    appBar: AppBar(
      title: Text('Booking App'),
    ),
    body: ListViewApp(),
  );
}

// Widget test() {
//   return FutureBuilder(
//     future: request_hotels(),
//     builder: (BuildContext context, AsyncSnapshot snapshot) {
//       if (snapshot.connectionState == ConnectionState.done) {
//         print(snapshot.data.body);
//         Map<String, dynamic> data = jsonDecode(snapshot.data.body);
//         return ListViewApp();
//       } else {
//         return Text("wating");
//       }
//     },
//   );
// }

// Widget buildApp(Map<String, dynamic> data) extends StatefulWidget{}

class ListViewApp extends StatefulWidget {
  @override
  _ListViewState createState() => new _ListViewState();
}

class _ListViewState extends State<ListViewApp> {
  Map<String, dynamic> items = new Map();
  bool is_data_loaded = false;

  @override
  void initState() {
    super.initState();
    request_hotels().then((response) {
      setState(() {
        is_data_loaded = true;
        items = jsonDecode(response.body);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsetsDirectional.only(top: 10, start: 10, end: 10),
      color: Colors.green[100],
      child: ListView.builder(
        itemCount: is_data_loaded ? items["hotels"].length : 0,
        itemBuilder: (context, position) {
          List<dynamic> data = items["hotels"];
          return Column(
            children: <Widget>[
              buildHeader(data, position),
              buildCardImage(data, position),
              book_now_button(screenWidth),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: position == items["hotels"].length - 1 ? 0 : 20),
              )
            ],
          );
        },
      ),
    );
  }

  Container buildHeader(List data, int position) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 10.0),
      child: Card(
        color: Colors.green,
        child: Container(
          padding:
              EdgeInsetsDirectional.only(top: 5, bottom: 5, start: 5, end: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Row(
                  children: <Widget>[
                    Icon(Icons.cake),
                    Column(
                      children: <Widget>[
                        Text(
                          data[position]["location"]["city"],
                          style: TextStyle(
                              color: Colors.yellow,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        ),
                        Text(data[position]["location"]["country"])
                      ],
                    )
                  ],
                ),
              ),
              Container(
                child: Row(
                  children: <Widget>[
                    Text(data[position]["rooms"]),
                    Icon(Icons.camera)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Card buildCardImage(List data, int position) {
    return Card(
      child: Column(
        children: <Widget>[
          Container(
            // image replacement
            height: 300,
            color: Colors.black,
          ),
          Column(
            children: <Widget>[
              Row(
                children: <Widget>[
                  Text(
                    data[position]["name"],
                    style: TextStyle(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                        fontSize: 26),
                  ),
                  SmoothStarRating(
                      allowHalfRating: false,
                      onRatingChanged: (v) {},
                      starCount: 5,
                      rating: double.parse(data[position]["rate"]),
                      size: 30.0,
                      color: Colors.green,
                      borderColor: Colors.green,
                      spacing: 0.0)
                ],
              ),
              Text(
                data[position]["description"],
                style: TextStyle(color: Colors.green),
              ),
              ButtonBar(
                alignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    color: Colors.green,
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[Icon(Icons.share), Text("Share")],
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    color: Colors.green,
                    onPressed: () {
                      print(data[position]["geo_location"]["longitude"] +
                          "  " +
                          data[position]["geo_location"]["latitude"]);
                    },
                    child: Column(
                      children: <Widget>[Icon(Icons.share), Text("Locate")],
                    ),
                  ),
                  FlatButton(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    color: Colors.green,
                    onPressed: () {},
                    child: Column(
                      children: <Widget>[Icon(Icons.share), Text("Call")],
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }

  Container book_now_button(double screenWidth) {
    return Container(
      color: Colors.green,
      width: screenWidth - 30,
      child: FlatButton(
        onPressed: () {},
        child: Text("Book Now"),
      ),
    );
  }
}
