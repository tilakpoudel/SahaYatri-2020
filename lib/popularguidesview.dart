import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'transactionview.dart' as TransactionView;
import 'package:geolocator/geolocator.dart' as GEO;

import 'model.dart' as Model;

class PopularGuidesView extends StatefulWidget {
  final Model.Place destination;
  final GEO.Placemark placemark;
  PopularGuidesView({this.destination, this.placemark});
  @override
  _PopularGuidesViewState createState() => _PopularGuidesViewState();
}

class _PopularGuidesViewState extends State<PopularGuidesView> {
  List<Model.Guide> guides = [];
  Future<bool> fetchStatusGuides;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchStatusGuides = getPopularGuides();
    // print("LOCATION:${widget.address}");
  }

  Future<bool> getPopularGuides() async {
    bool status = true;
    try {
      http.Response data = await http
          .get("${Model.apiBaseUrl}/guides/${widget.destination.address}");
      List<dynamic> items = jsonDecode(data.body);
      for (int i = 0; i < items.length; i++) {
        guides.add(Model.Guide.fromMap(items[i]));
      }
    } catch (_) {
      print("Error occured when fetching popular guides");
      status = false;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Book your guide"),
        ),
        body: Container(
          child: FutureBuilder(
            future: fetchStatusGuides,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data == true) {
                  print(guides[0].imagePath);
                  if (guides.length == 0) {
                    print("GUIDE LENGTH ZERO");
                    return Text("No guides yet added.");
                  } else
                    return ListView.builder(
                      itemCount: guides.length,
                      itemBuilder: (
                        BuildContext context,
                        int index,
                      ) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) {
                                  return TransactionView.TransactionView(
                                    guideid: guides[index].id,
                                    startlocation: widget.placemark.locality,
                                    destlocation: widget.destination,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            child: Card(
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: Image.network(
                                        "${Model.baseGuideImageUrl}/${guides[index].imagePath}"),
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    child: Text(guides[index].name),
                                  )
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                } else {
                  return Text("Connection error. try again later.");
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}
