import 'dart:async';
import 'dart:convert';

import 'package:flight/models/plan.dart';
import 'package:flight/pages/home_screen.dart';
import 'package:flight/widget/plan_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ListingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Listeleme"),
      ),
      body: futureBuilder(),
    );
  }
}

Widget futureBuilder() {
  return FutureBuilder<List<Plan>>(
    future: fetchPlans(http.Client()),
    builder: (context, snapshot) {
      if (snapshot.hasError) print(snapshot.error);

      if (snapshot.hasData) {
        return PlansList(plans: snapshot.data);
      } else {
        return Center(child: CircularProgressIndicator());
      }
    },
  );
}
