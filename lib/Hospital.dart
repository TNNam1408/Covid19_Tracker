import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart'as http;
import 'Hbeds.dart';
import 'dart:convert';


class Hospital extends StatefulWidget {
  @override
  _HospitalState createState() => _HospitalState();
}
class _HospitalState extends State<Hospital> {
  // noSuchMethod(Invocation i) => super.noSuchMethod(i);
  final String url = "https://api.rootnet.in/covid19-in/stats/hospitals";
  @override
  void initState() {
    super.initState();
    this.getJsonData();

  }
  Future <Hbeds> getJsonData() async
  {
    var response = await http.get(
      Uri.encodeFull(url),
    );

    if (response.statusCode==200)
    {
      final convertDataJson = jsonDecode(response.body)['data']['summary'];

      return Hbeds.fromJson(convertDataJson);
    }
    else{
      throw Exception('Try to  Reload Page');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        appBar: AppBar(
          title: Text('Indian Hospitals statistics'),
          backgroundColor: Color(0xFF00A86B),

        ),
        backgroundColor: Colors.black,
        body: SingleChildScrollView(

            child : Container(
                child : Center(
                  child :Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                        Image(image: AssetImage("assets/images/h2.png"),
                          height: 300,
                          width: 300,),

                        Padding(padding: EdgeInsets.only(top : 20.0)),

                        Card(color: Color(0xFF292929),
                            child : ListTile(
                                title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children : <Widget>[
                                      Text("Total Hospitals ",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                      Text("Total Beds",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                      // Text("Recoveries",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),

                                    ])
                            )
                        ),

                        FutureBuilder<Hbeds>(

                            future: getJsonData(),
                            builder: (BuildContext context,SnapShot){

                              if(SnapShot.hasData)
                              {
                                final covid = SnapShot.data;
                                return Column(
                                    children : <Widget>[
                                      Card(color: Color(0xFF292929),
                                          child : ListTile(

                                              title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children : <Widget>[

                                                    Text("   ${covid.totalHospitals} ",style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),),
                                                    Text("     ${ covid.totalBeds}",style: TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.bold),),
                                                    //Text("${covid.discharged}",style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold)),
                                                  ]
                                              )
                                          )
                                      ),
                                      Padding(padding: EdgeInsets.only(top:10.0)),

                                      Card(color: Color(0xFF292929),
                                          child : ListTile(

                                              title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children : <Widget>[

                                                    Text("Urban Hospitals ",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                                    Text("Total Beds",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                                    //Text("${covid.discharged}",style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold)),

                                                  ]
                                              )
                                          )
                                      ),
                                      Card(color: Color(0xFF292929),
                                          child : ListTile(

                                              title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children : <Widget>[

                                                    Text("   ${covid.urbanHospitals} ",style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),),
                                                    Text("      ${covid.urbanBeds}",style: TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.bold),),
                                                    //Text("${covid.discharged}",style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold)),

                                                  ]
                                              )
                                          )
                                      ),
                                      Padding(padding: EdgeInsets.only(top:10.0)),

                                      Card(color: Color(0xFF292929),
                                          child : ListTile(

                                              title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children : <Widget>[

                                                    Text("Rural Hospitals ",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                                    Text("Total Beds",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                                    // Text("Recoveries",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),

                                                  ]
                                              )
                                          )
                                      ),

                                      Card(color: Color(0xFF292929),
                                          child : ListTile(

                                              title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                  children : <Widget>[

                                                    Text("   ${covid.ruralHospitals} ",style: TextStyle(color: Colors.blue, fontSize: 30, fontWeight: FontWeight.bold),),
                                                    Text("      ${covid.ruralBeds}",style: TextStyle(color: Colors.greenAccent, fontSize: 30, fontWeight: FontWeight.bold),),
                                                    //Text("${covid.discharged}",style: TextStyle(color: Colors.green, fontSize: 30, fontWeight: FontWeight.bold)),

                                                  ]
                                              )
                                          )
                                      ),
                                    ]
                                );
                              }
                              else if(SnapShot.hasError)
                              {
                                return Text(SnapShot.error.toString());
                              }
                              return CircularProgressIndicator();
                            }
                        ),
                      ]
                  ),
                )
            )
        )
    );
  }
}