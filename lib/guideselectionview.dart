import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as GEO;

import 'model.dart' as Model;
import 'popularguidesview.dart' as PopularGuideView;

class GuideSelectionView extends StatefulWidget {
  final Model.Place destination;

  GuideSelectionView({this.destination});
  @override
  _GuideSelectionViewState createState() => _GuideSelectionViewState();
}

class _GuideSelectionViewState extends State<GuideSelectionView> {
  Future<bool> addressStatus;
  List<GEO.Placemark> allPlacemarks;
  GEO.Position currentPosition;
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
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Guide Selection"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          child: Column(
            children: <Widget>[
              Spacer(flex: 1),
              FutureBuilder(
                future: addressStatus,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return Text(
                      "Your current location:\n${getAddressLine(allPlacemarks[0])}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    );
                  } else {
                    return CircularProgressIndicator();
                  }
                },
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                  "Your destination location:\n${widget.destination.name}, ${widget.destination.address}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                  )),
              Spacer(
                flex: 5,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return PopularGuideView.PopularGuidesView(
                          destination: widget.destination,
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
                color: Theme.of(context).accentColor,
              ),
              Spacer(
                flex: 1,
              )
            ],
          ),
        ),
      ),
    );
  }
}

String getAddressLine(GEO.Placemark placemark) {
  return "${placemark.locality}, ${placemark.thoroughfare}, ${placemark.administrativeArea}";
}
