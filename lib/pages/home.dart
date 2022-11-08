import 'dart:convert';

import 'package:covid_19_flutter_project/models/Summary.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../widgets/card_item.dart';

class HomePage extends StatelessWidget {
  // HomePage({
  //   Key? key,
  // }) : super(key: key);

  late Summary dataSummary;

  Future getSummary() async {
    var response = await http.get(Uri.parse('https://covid19.mathdro.id/api'));
    // print(response.body); // Testing response get data

    var dataJson = jsonDecode(response.body) as Map<String, dynamic>;
    dataSummary = Summary.fromJson(dataJson);
    // print(dataSummary.confirmed.value); Testing data models
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Covid 19"),
        centerTitle: true,
      ),
      body: FutureBuilder(
          future: getSummary(),
          builder: (context, AsyncSnapshot) {
            if (AsyncSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Text("Loading Data..."),
              );
            }
            return Column(
              children: <Widget>[
                CardItem("CONFIRMED", "${dataSummary.confirmed.value}"),
                CardItem("DEATHS", "${dataSummary.deaths.value}"),
              ],
            );
          }),
    );
  }
}
