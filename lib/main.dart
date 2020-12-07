import 'package:flight/plan.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flight/my_home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

var link = 'a';
Future<List<Plan>> fetchPlans(http.Client client) async {
  final response = await client.get(link);

  // Use the compute function to run parsePlans in a separate isolate.
  return compute(parsePlans, response.body);
}

// A function that converts a response body into a List<Plan>.
List<Plan> parsePlans(String responseBody) {
  final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();

  return parsed.map<Plan>((json) => Plan.fromJson(json)).toList();
}

void main() => runApp(MaterialApp(home: MyApp()));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var code1 = "", code2 = "";

  final TextEditingController t1 = new TextEditingController(text: "");
  final TextEditingController t2 = new TextEditingController(text: "");

  void saveInput() {
    setState(() {
      code1 = t1.text;
      code2 = t2.text;
    });
  }

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

  void setLink() {
    setState(() {
      link =
          'https://api.flightplandatabase.com/search/plans?fromICAO=$code1&toICAO=$code2&limit=4';
    });
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
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => MyHomePage()));
      },
    );
  }
}
