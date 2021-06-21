import 'dart:convert';

import 'package:covid_19_tracker/modal/VNs.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class VietNam extends StatefulWidget {

  @override
  _VietNamState createState() => _VietNamState();
}

class _VietNamState extends State<VietNam> {
  //-------------------------
  final String url = "https://api.apify.com/v2/key-value-stores/EaCBL1JNntjR3EakU/records/LATEST?disableRedirect=true";
  Future<List> datas;
  Future<VNese> getData() async {
    var response = await http.get(Uri.encodeFull(url));

    if (response.statusCode == 200) {
      final convertDataJson = jsonDecode(response.body);

      return VNese.fromJson(convertDataJson);
    } else {
      throw Exception('Try to Reload.');
    }
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 Viet Nam"),
        backgroundColor: Color(0xfffe8c00),
      ),
      backgroundColor: Colors.black87,
      body: Container(
          child: FutureBuilder<VNese>(
              future: getData(),
              // ignore: missing_return
              builder: (BuildContext context, SnapShot) {
                if (SnapShot.hasData) {
                  final covid = SnapShot.data;
                  var f = NumberFormat('###,###.##', 'en_US');
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("All over the world:",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 30,
                                fontWeight: FontWeight
                                    .bold)),
                        Text(
                          "Last Updated At Source:\n${covid.lastUpdatedAtSource}",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 25,
                              fontWeight: FontWeight
                                  .bold),),
                        Text(
                          "Last Updated At Apify:\n${covid.lastUpdatedAtApify}",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 25,
                              fontWeight: FontWeight
                                  .bold),),
                        Text("Infected: ${covid.infected}",
                            style: TextStyle(
                                color: Colors.orange,
                                fontSize: 23,
                                fontWeight: FontWeight
                                    .bold)),
                        Text("Treated: ${covid.treated}",
                            style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 23,
                                fontWeight: FontWeight
                                    .bold)),
                        Text(
                            "Recovered: ${covid.recovered}",
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 23,
                                fontWeight: FontWeight
                                    .bold)),
                        Text("Deceased: ${covid.deceased}",
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 23,
                                fontWeight: FontWeight
                                    .bold)),
                      ],
                    ),
                  );
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
          ),
      ),
    );
  }
}