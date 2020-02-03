import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart' as SPF;
import 'package:rflutter_alert/rflutter_alert.dart' as Alert;

import 'model.dart' as Model;

class TransactionView extends StatefulWidget {
  final int guideid;
  final String startlocation;
  final Model.Place destlocation;

  TransactionView({this.guideid, this.startlocation, this.destlocation});
  @override
  _TransactionViewState createState() => _TransactionViewState();
}

class _TransactionViewState extends State<TransactionView> {
  TextEditingController touristNameController = TextEditingController();
  TextEditingController touristEmailController = TextEditingController();
  TextEditingController touristContactController = TextEditingController();
  TextEditingController touristCountryController = TextEditingController();
  DateTime startDate;
  DateTime endDate;
  bool takeLastDate = false;
  // final SnackBar snackBar = SnackBar(
  //     content: Text(
  //         "Successfully placed the request, please wait for futher notice."));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.guideid);
  }

  // void putHash(String hashcode) async {
  //   SPF.SharedPreferences preferences =
  //       await SPF.SharedPreferences.getInstance();
  //   preferences.setString("usercookie", hashcode);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Column(
                children: <Widget>[
                  Spacer(flex: 2),
                  Text("Start Location: ${widget.startlocation}"),
                  Text(
                      "End Location: ${widget.destlocation.name}, ${widget.destlocation.address}"),
                  Spacer(flex: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: () async {
                          startDate = await showDatePicker(
                            context: context,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2021),
                            initialDate: DateTime.now(),
                            builder: (context, child) => Theme(
                              data: ThemeData.light(),
                              child: child,
                            ),
                          );
                          setState(() {
                            takeLastDate = true;
                          });
                        },
                        child: Text("Select start date"),
                      ),
                      Text(
                        startDate == null
                            ? "Not set."
                            : "${startDate.year}/${startDate.month}/${startDate.day}",
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      RaisedButton(
                        onPressed: takeLastDate
                            ? () async {
                                endDate = await showDatePicker(
                                  context: context,
                                  firstDate: DateTime(2020),
                                  lastDate: DateTime(2021),
                                  initialDate: startDate,
                                  builder: (context, child) => Theme(
                                    data: ThemeData.light(),
                                    child: child,
                                  ),
                                );
                                setState(() {});
                              }
                            : null,
                        child: Text("Select end date"),
                      ),
                      Text(
                        endDate == null
                            ? "Not set."
                            : "${endDate.year}/${endDate.month}/${endDate.day}",
                      ),
                    ],
                  ),
                  TextField(
                    controller: touristNameController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Name"),
                  ),
                  TextField(
                    controller: touristEmailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(labelText: "Email"),
                  ),
                  TextField(
                    controller: touristContactController,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(labelText: "Phone Number"),
                  ),
                  TextField(
                    controller: touristCountryController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(labelText: "Country"),
                  ),
                  Spacer(flex: 2),
                  RaisedButton(
                    color: Theme.of(context).accentColor,
                    onPressed: () {
                      //post api
                      dynamic payload = {
                        "tourist_name": touristNameController.value.text,
                        "country": touristCountryController.value.text,
                        "email": touristEmailController.value.text,
                        "phone_number": touristContactController.value.text,
                        "travel_guide_id": widget.guideid,
                        "start_location": widget.startlocation,
                        "destination_location": widget.destlocation.id,
                        "start_day": startDate.toIso8601String(),
                        "end_day": endDate.toIso8601String(),
                      };
                      // payload = "[${jsonEncode(payload)}]";
                      payload = jsonEncode(payload);
                      print(payload);
                      http.post("${Model.apiBaseUrl}/bookings/store",
                          body: payload,
                          headers: {
                            "Content-type": "application/json"
                          }).then((response) {
                        // Scaffold.of(context).showSnackBar(snackBar);
                        // print(response.body);
                        Alert.Alert(
                                context: context,
                                title: "Booking info",
                                desc:
                                    "Your order has been taken. Plese wait for further information.")
                            .show()
                            .then((status) {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        });
                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Book this guide",
                        style: TextStyle(fontSize: 24.0, color: Colors.white),
                      ),
                    ),
                  ),
                  // Spacer(flex: 1),
                ],
              )),
        ),
      ),
    );
  }
}

// {
//   "tourist_name", string
//   "tourist_nationality", string
//   "travel_guide_id", int
//   "start_location", string
//   "destination_location", int
//   "start_day", string
//   "end_day", string
// }

// Map<String, dynamic> transactionDetails() {

// }
