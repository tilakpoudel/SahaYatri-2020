import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'placeview.dart' as PlaceView;
import 'categorizedview.dart' as CategoryView;

// import 'dart:math';
import 'package:tourismapp/model.dart' as Model;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Model.Place> popularPlaces = [];
  List<Model.Category> categories = [];
  Future<bool> fetchStatusPlace;
  Future<bool> fetchStatusCategory;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //fetch places data from api and store in the list
    fetchStatusPlace = getPopularPlaces();
    // fetchStatusPlace.then((status) {
    fetchStatusCategory = getAllCategories();
    // });
  }

  Future<bool> getAllCategories() async {
    bool status = true;
    try {
      http.Response data = await http.get("${Model.apiBaseUrl}/categories");
      List<dynamic> items = jsonDecode(data.body);
      print(items);
      for (int i = 0; i < items.length; i++) {
        categories.add(Model.Category.fromMap(items[i]));
      }
      print("DEBUG:categories:length");
      print(categories);
      print(categories.length);
    } catch (_) {
      print("ERROR OCCURED while fetching categories");
      status = false;
    }
    return status;
  }

  Future<bool> getPopularPlaces() async {
    bool status = true;
    try {
      http.Response data = await http.get("${Model.apiBaseUrl}/places/popular");
      List<dynamic> places = jsonDecode(data.body);
      print(places);
      for (int i = 0; i < places.length; i++) {
        popularPlaces.add(Model.Place.fromMap(places[i]));
      }
      // fetchStatusCategory = getAllCategories();
    } catch (_) {
      print("ERROR OCCURED");
      status = false;
    }
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Spacer(flex: 2),
              Container(
                width: MediaQuery.of(context).size.width,
                // color: Colors.green,
                child: Text(
                  "Popular places",
                  style: Theme.of(context).textTheme.headline6,
                ),
              ),
              Spacer(flex: 1),
              Container(
                height: 200.0,
                child: FutureBuilder(
                  future: fetchStatusPlace,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<dynamic> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == true) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            // print("IMG PATHS:>>>>>>>>>>>>>>>");
                            // print(popularPlaces[index]);
                            // print(popularPlaces[index].imagePath.runtimeType);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return PlaceView.PlaceView(
                                          place: popularPlaces[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Material(
                                  elevation: 4.0,
                                  child: Container(
                                    width: 200.0,
                                    // color: Colors.lightGreen,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child:
                                              (popularPlaces[index].imagePath ==
                                                      "")
                                                  ? Text("Image")
                                                  : Image.network(
                                                      "${Model.basePlaceImageUrl}/${popularPlaces[index].imagePath}",
                                                      fit: BoxFit.cover,
                                                    ),
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          child: Container(
                                            alignment: Alignment.center,
                                            width: 200.0,
                                            color: Colors.lightGreen,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8.0,
                                                      vertical: 4.0),
                                              child: Text(
                                                popularPlaces[index].name,
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                    color: Colors.white),
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
                          itemCount: popularPlaces.length,
                        );
                      } else {
                        return Text("Connection Error. try again later.");
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Spacer(
                flex: 2,
              ),
              Text(
                "Places category",
                style: Theme.of(context).textTheme.headline6,
              ),
              Spacer(
                flex: 1,
              ),
              Container(
                height: 200.0,
                child: FutureBuilder(
                  future: fetchStatusCategory,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot<dynamic> snapshot,
                  ) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == true) {
                        return ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (
                            BuildContext context,
                            int index,
                          ) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return CategoryView
                                            .CategorizedPlacesView(
                                          category: categories[index],
                                        );
                                      },
                                    ),
                                  );
                                },
                                child: Material(
                                  elevation: 4.0,
                                  child: Container(
                                    width: 200.0,
                                    // color: Colors.lightGreen,
                                    child: Stack(
                                      children: <Widget>[
                                        Positioned.fill(
                                          child: (categories[index].imagePath ==
                                                  "")
                                              ? Text("Image")
                                              : Image.network(
                                                  "${Model.baseCategoryImageUrl}/${categories[index].imagePath}",
                                                  fit: BoxFit.cover,
                                                ),
                                        ),
                                        Positioned(
                                          bottom: 0.0,
                                          child: Container(
                                              alignment: Alignment.center,
                                              width: 200.0,
                                              color: Colors.lightGreen,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0,
                                                        vertical: 4.0),
                                                child: Text(
                                                  categories[index].type,
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 20.0),
                                                ),
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: categories.length,
                        );
                      } else {
                        return Text("Connection Error. try again later.");
                      }
                    } else {
                      return Center(child: CircularProgressIndicator());
                    }
                  },
                ),
              ),
              Spacer(
                flex: 5,
              ),
              Align(
                alignment: Alignment.center,
                child: Text("Visit Nepal 2020 with Sahayatri App"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// visiting sites updating mechanism
