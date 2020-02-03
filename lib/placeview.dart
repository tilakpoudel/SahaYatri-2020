import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tourismapp/guideselectionview.dart' as GuideSelectionView;
import 'model.dart' as Model;
import 'package:geolocator/geolocator.dart' as GEO;
import 'popularguidesview.dart' as PopularGuideView;

class PlaceView extends StatefulWidget {
  final Model.Place place;

  PlaceView({this.place});
  @override
  _PlaceViewState createState() => _PlaceViewState();
}

class _PlaceViewState extends State<PlaceView> {
  Future<bool> addressStatus;
  List<GEO.Placemark> allPlacemarks;
  GEO.Position currentPosition;
  bool enableButton = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addressStatus = getCurrentAddress();
  }

  Future<bool> getCurrentAddress() async {
    bool status = true;
    print((await GEO.Geolocator().checkGeolocationPermissionStatus()));
    currentPosition = await GEO.Geolocator().getCurrentPosition(
      desiredAccuracy: GEO.LocationAccuracy.high,
    );
    allPlacemarks = await GEO.Geolocator().placemarkFromCoordinates(
        currentPosition.latitude, currentPosition.longitude,
        localeIdentifier: "en");
    setState(() {
      enableButton = true;
    });
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Place Details"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        // color: Colors.lightGreen[300],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Stack(
              children: <Widget>[
                Positioned(
                  child: Image.network(
                      "${Model.basePlaceImageUrl}/${widget.place.imagePath}"),
                ),
                // Positioned(
                //   bottom: 0.0,
                //   child: Container(
                //     // color: Colors.red,
                //     height: 24.0,
                //     width: double.infinity,
                //     child: Text(
                //       widget.place.name,
                //       style: Theme.of(context).textTheme.bodyText2,
                //     ),
                //   ),
                // ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(widget.place.address,
                  style: TextStyle(
                    fontSize: 24.0,
                  )),
            ),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(widget.place.description,
                  style: TextStyle(
                    fontSize: 18.0,
                  )),
            ),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: FutureBuilder(
                future: addressStatus,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    // return Text(
                    //   "Your current location:\n${getAddressLine(allPlacemarks[0])}",
                    //   textAlign: TextAlign.left,
                    //   style: TextStyle(
                    //     fontSize: 20.0,
                    //   ),
                    // );
                    return RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Your current location:\n",
                          style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black)),
                      TextSpan(
                          text: "${getAddressLine(allPlacemarks[0])}",
                          style: TextStyle(
                              fontSize: 20.0,
                              fontStyle: FontStyle.italic,
                              color: Colors.black)),
                    ]));
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Spacer(flex: 1),
            Padding(
              padding: const EdgeInsets.all(16.0),
              // child: RichText(
              //     text: TextSpan(children: )
              //     "Your destination location:\n${widget.place.name}, ${widget.place.address}",
              //     textAlign: TextAlign.left,
              //     style: TextStyle(
              //       fontSize: 20.0,
              //     )),
              child: RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: "Your destination location:\n",
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.black)),
                  TextSpan(
                      text: "${widget.place.name}, ${widget.place.address}",
                      style: TextStyle(
                          fontSize: 20.0,
                          fontStyle: FontStyle.italic,
                          color: Colors.black)),
                ]),
              ),
            ),
            Spacer(
              flex: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: enableButton
                  ? RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return PopularGuideView.PopularGuidesView(
                                destination: widget.place,
                                placemark: allPlacemarks[0],
                              );
                            },
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Choose your guide",
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                      color: Theme.of(context).primaryColor,
                    )
                  : null,
            ),
            Spacer(flex: 1),
          ],
        ),
      ),
    );
  }
}

String getAddressLine(GEO.Placemark placemark) {
  return "${placemark.locality}, ${placemark.thoroughfare}, ${placemark.administrativeArea}";
}
