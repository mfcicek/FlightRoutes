import 'dart:convert';

import 'package:flight/models/plan.dart';
import 'package:flight/pages/listing_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

var link = "a";
Future<List<Plan>> fetchPlans(http.Client client) async {
  final response = await client.get(link);

  // Use the compute function to run parsePlans in a separate isolate.
  return compute(parsePlans, response.body);
}

List<Plan> parsePlans(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Plan>((json) => Plan.fromJson(json)).toList();
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var code1 = "", code2 = "";
  final TextEditingController t1 = new TextEditingController(text: "");
  final TextEditingController t2 = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        backgroundColor: Colors.blue[900],
        centerTitle: true,
        title: Text("UÇUŞ ROTASI BUL"),
      ),
      body: buildBody(),
    );
  }

  buildBody() {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            CircleAvatar(
                radius: 70, backgroundImage: AssetImage('images/pic.png')),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            buildFirstIcaoInputField(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            buildSecondIcaoInputField(),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
            ),
            buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget buildFirstIcaoInputField() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hoverColor: Colors.yellow,
        hintText: "Kalkış ICAO kodunu giriniz",
        border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: new BorderSide(color: Colors.blue, width: 2.5)),
      ),
      controller: t1,
    );
  }

  Widget buildSecondIcaoInputField() {
    return TextField(
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: "Varış ICAO kodunu giriniz",
        border: new OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
            borderSide: new BorderSide(color: Colors.blue, width: 2.5)),
      ),
      controller: t2,
    );
  }

  Widget buildSubmitButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(primary: Colors.blue[900]),
      child: Text(
        "BUL",
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        saveInput();
        setLink();
        print("kalkış: " + code1 + " " + "varış: " + code2);
        print(link);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListingScreen()));
      },
    );
  }

  void saveInput() {
    setState(() {
      code1 = t1.text;
      code2 = t2.text;
    });
  }

  void setLink() {
    setState(() {
      print(link);
      link =
          'https://api.flightplandatabase.com/search/plans?fromICAO=$code1&toICAO=$code2&limit=4';
    });
  }
}
