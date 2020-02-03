import 'dart:convert';

import 'package:flutter/material.dart';
import 'model.dart' as Model;
import 'package:http/http.dart' as http;

import 'placeview.dart' as PlaceView;

class CategorizedPlacesView extends StatefulWidget {
  final Model.Category category;
  CategorizedPlacesView({this.category});

  @override
  _CategorizedPlacesViewState createState() => _CategorizedPlacesViewState();
}

class _CategorizedPlacesViewState extends State<CategorizedPlacesView> {
  List<Model.Place> categorizedPlaces = [];
  Future<bool> fetchedStatusCategorizedPlaces;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchedStatusCategorizedPlaces = getCategorizedPlaces();
  }

  Future<bool> getCategorizedPlaces() async {
    bool status = true;
    try {
      http.Response data =
          await http.get("${Model.apiBaseUrl}/places/${widget.category.id}");
      List<dynamic> items = jsonDecode(data.body);
      print("debug items data");
      print(items);
      for (int i = 0; i < items.length; i++) {
        categorizedPlaces.add(Model.Place.fromMap(items[i]));
      }
    } catch (_) {
      print("Error occured when fetching categorized places");
      status = false;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Popular ${widget.category.type} sites"),
      ),
      body: Container(
        // color: Colors.red,
        child: FutureBuilder(
          future: fetchedStatusCategorizedPlaces,
          builder: (
            BuildContext context,
            AsyncSnapshot<dynamic> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.done) {
              // if fetching the data is successful, display the data in list
              if (snapshot.data == true) {
                if (categorizedPlaces.length == 0)
                  return Text("No places yet added.");
                else
                  return ListView.builder(
                    itemCount: categorizedPlaces.length,
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
                                return PlaceView.PlaceView(
                                  place: categorizedPlaces[index],
                                );
                              },
                            ),
                          );
                        },
                        child: Material(
                          elevation: 4.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              color: Colors.lightGreenAccent,
                              child: Stack(
                                children: <Widget>[
                                  Positioned(
                                    child: Image.network(
                                        "${Model.basePlaceImageUrl}/${categorizedPlaces[index].imagePath}"),
                                  ),
                                  Positioned(
                                    bottom: 0.0,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      color: Colors.green[700],
                                      child: Padding(
                                        padding: const EdgeInsets.all(12.0),
                                        child: Text(
                                          categorizedPlaces[index].name,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  );
              } else {
                //fetching data unsuccessful, requires upgrade
                return Text("Connection error. try again later.");
              }
            } else {
              //fetching the data
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
