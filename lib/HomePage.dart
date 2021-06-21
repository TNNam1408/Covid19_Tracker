import 'dart:convert';
import 'package:covid_19_tracker/Hospital.dart';
import 'package:covid_19_tracker/Hstate.dart';
import 'package:covid_19_tracker/VietNam.dart';
import 'package:covid_19_tracker/modal/Tcases.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'India.dart';
import 'World.dart';
import 'modal/Tcases.dart';
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //World Statistis
  final String url = "https://corona.lmao.ninja/v3/covid-19/all";

  Future<Tcases> getJsonData()async{
    var response = await http.get(Uri.encodeFull(url));

    if(response.statusCode ==200){

      final convertDataJson= jsonDecode(response.body);

      return Tcases.fromJson(convertDataJson);
    }else{
      throw Exception('Try to Reload.');
    }
  }
  @override
  void initState() {
    super.initState();
    this.getJsonData();
  }
//--------------------------------------
  navigateToCountry()async{
    await  Navigator.push(context, MaterialPageRoute(
      builder: (context)=>World(),
    ));
  }
  navigateToVietNam()async{
    await  Navigator.push(context, MaterialPageRoute(
      builder: (context)=>VietNam(),
    ));
  }
  navigateToIndia()async{
    await  Navigator.push(context, MaterialPageRoute(
      builder: (context)=>India(),
    ));
  }
  navigateToHospital()async{
    await  Navigator.push(context, MaterialPageRoute(
      builder: (context)=>Hospital(),
    ));
  }

  navigateToHstate()async{
    await  Navigator.push(context, MaterialPageRoute(
      builder: (context)=>Hstate(),
    ));
  }

  navigateToWHO(url)async{
    if(await canLaunch(url)){
      await launch(url);
    }else{
      Text("Link is not working $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Covid-19 Tracker"),
        backgroundColor: Color(0xfffe8c00),
      ),
      backgroundColor: Colors.black87,

      body: Container(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Stay", style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                        ),
                        Card(
                          color: Color(0xFFfe9900),
                          child: Text("Home", style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 30),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("WorldWide Statistics",style: TextStyle(
                          color: Colors.white,
                          fontSize: 20),),
                      // ignore: deprecated_member_use
                      // RaisedButton(
                      //   onPressed: (){},
                      //   color: Colors.black87,
                      //   child: Container(
                      //     alignment: Alignment.center,
                      //     decoration: BoxDecoration(
                      //       // color: Colors.blue,
                      //       border: Border.all(color: Color(0xFFfe9900)),
                      //       borderRadius: BorderRadius.all(Radius.circular(5)),
                      //     ),
                      //     padding: EdgeInsets.only(left: 5, right: 5, top: 5, bottom: 5),
                      //     child: Center(
                      //         child: Text("India Statistics",style: TextStyle(
                      //             color: Color(0xFFfe9900),
                      //             fontWeight: FontWeight.bold,
                      //             fontSize: 20),)
                      //     ),
                      //   ),
                      // ),
                      // ignore: deprecated_member_use
                      OutlineButton(
                      color: Colors.blueAccent,
                      borderSide: BorderSide(color : Color(0xFFfe9900)),
                      onPressed: ()=>navigateToVietNam(),
                      child :  Text('VietNam statistics',style: TextStyle(color:Color(0xFFfe9900),fontSize :20,fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                ),
                // FutureBuilder<Tcases>(
                //   future: getJsonData(),
                //   // ignore: missing_return
                //   builder: (BuildContext context, SnapShot){
                //     if(SnapShot.hasData){
                //       final covid =  SnapShot.data;
                //       Column(
                //         children: [
                //           Card(
                //             color: Color(0xFF292929),
                //             child: ListTile(
                //               title: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                 children: [
                //                   Text("${covid.cases}",style: TextStyle(
                //                       color: Colors.blue,
                //                       fontWeight: FontWeight.bold,
                //                       fontSize: 25))
                //                 ],
                //               ),
                //             ),
                //           )
                //         ],
                //       );
                //     }else if(SnapShot.hasError){
                //       return Text(SnapShot.error.toString());
                //     }else{
                //       return CircularProgressIndicator();
                //     }
                //   },
                // ),
                FutureBuilder<Tcases>(
                    future: getJsonData(),
                    builder: (BuildContext context,SnapShot){
                      if(SnapShot.hasData)
                      {
                        final covid = SnapShot.data;
                        var f = NumberFormat('###,###.##', 'en_US');
                        return Column(
                            children : <Widget>[
                              Card(color: Color(0xFF292929),
                                  child : ListTile(
                                      title: Column(
                                        children: [
                                          Text("All over the world:",style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
                                          Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                              children : <Widget>[
                                                Text(f.format(covid.cases),style: TextStyle(color: Colors.blue, fontSize: 23, fontWeight: FontWeight.bold),),
                                                Text(f.format(covid.deaths),style: TextStyle(color: Colors.red, fontSize: 23, fontWeight: FontWeight.bold),),
                                                Text(f.format(covid.recovered),style: TextStyle(color: Colors.green, fontSize: 23, fontWeight: FontWeight.bold)),

                                              ]
                                          ),
                                        ],
                                      )
                                  )
                              ),
                              Card(color: Color(0xFF292929),
                                  child : ListTile(
                                      title: Column(
                                        children: [
                                          Text("Today:",style: TextStyle(color: Colors.white, fontSize: 23, fontWeight: FontWeight.bold)),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children : <Widget>[
                                          Text(f.format(covid.todayCases),style: TextStyle(color: Colors.blue, fontSize: 23, fontWeight: FontWeight.bold),),
                                          Text(f.format(covid.todayDeaths),style: TextStyle(color: Colors.red, fontSize: 23, fontWeight: FontWeight.bold),),
                                          Text(f.format(covid.todayRecovered),style: TextStyle(color: Colors.green, fontSize: 23, fontWeight: FontWeight.bold)),

                                        ],)
                                        ],
                                      )
                                  )
                              ),
                              Card(color: Color(0xFF292929),
                                  child : ListTile(
                                      title: Row( mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children : <Widget>[
                                            Text("Total Cases ",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                            Text("Deaths",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
                                            Text("Recoveries",style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                                          ]
                                      )
                                  )
                              ),
                              //demo
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
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                    child:Row( mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                              child :Container(color: Color(0xFF292929),
                                child : Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children : <Widget>[
                                          Padding(padding: EdgeInsets.only(top :20.0)),
                                          Image(image: AssetImage("assets/images/vietnam.png"),
                                            height: 100,
                                            width: 110,
                                          ),
                                          Padding(padding: EdgeInsets.all(5)),
                                          // ignore: deprecated_member_use
                                          OutlineButton(
                                            borderSide: BorderSide(color : Color(0xFFfe9900)),
                                            onPressed: ()=>navigateToIndia(),
                                            child : Text("           VietNam \n Statewise Statistics",style: TextStyle(fontSize: 15,color:Color(0xFFfe9900),fontWeight: FontWeight.bold),),
                                          ),
                                        ]
                                    )
                                ),
                              )
                          ),
                          Card(
                              child :Container(color: Color(0xFF292929),
                                child : Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children : <Widget>[
                                          Padding(padding: EdgeInsets.only(top :20.0)),
                                          Image(image: AssetImage("assets/images/world.png"),
                                            height: 100,
                                            width: 110,
                                          ),
                                          Padding(padding: EdgeInsets.all(5)),
                                          // ignore: deprecated_member_use
                                          OutlineButton(
                                            borderSide: BorderSide(color : Color(0xFFfe9900)),
                                             onPressed: ()=>navigateToCountry(),
                                            child : Text("Worldwide Statistics",style: TextStyle(fontSize: 15,color:Color(0xFFfe9900),fontWeight: FontWeight.bold),),
                                          ),
                                        ]
                                    )
                                ),
                              )
                          ),
                        ]
                    )
                ),
                Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                    child:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Card(
                              child :Container(color: Color(0xFF292929),
                                child : Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children : <Widget>[
                                          Padding(padding: EdgeInsets.only(top :20.0)),
                                          Image(image: AssetImage("assets/images/hospital.png"),
                                            height: 100,
                                            width: 110,
                                          ),
                                          Padding(padding: EdgeInsets.all(5)),
                                          // ignore: deprecated_member_use
                                          OutlineButton(
                                            borderSide: BorderSide(color : Color(0xFFfe9900)),
                                            onPressed: ()=>navigateToHospital(),
                                            child : Text("         VietNam \n  Hospital Statistics  ",style: TextStyle(fontSize: 15,color:Color(0xFFfe9900),fontWeight: FontWeight.bold),),
                                          ),
                                        ]
                                    )
                                ),
                              )
                          ),
                          Card(
                              child :Container(color: Color(0xFF292929),
                                child : Center(
                                    child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children : <Widget>[
                                          Padding(padding: EdgeInsets.only(top :20.0)),
                                          Image(image: AssetImage("assets/images/hs.png"),
                                            height: 100,
                                            width: 110,
                                          ),
                                          Padding(padding: EdgeInsets.all(5)),
                                          OutlineButton(
                                            borderSide: BorderSide(color : Color(0xFFfe9900)),

                                            onPressed: ()=>navigateToHstate(),
                                            child : Text("  VietNam Hospitals \n Statewise Statistics",style: TextStyle(fontSize: 15,color:Color(0xFFfe9900),fontWeight: FontWeight.bold),),
                                          ),
                                        ]
                                    )
                                ),
                              )
                          ),
                        ]
                    )
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Card(
                      child :Container(color: Color(0xFF292929),
                          child : Center(
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.stretch,
                                  children : <Widget>[

                                    Image(image: AssetImage("assets/images/myth.png"),
                                      height: 100,
                                      width: 110,
                                    ),
                                    Padding(padding: EdgeInsets.all(5)),
                                    // ignore: deprecated_member_use
                                    OutlineButton(
                                      borderSide: BorderSide(color : Color(0xFFfe9900)),
                                      onPressed: ()=> navigateToWHO("https://www.who.int/news-room/q-a-detail/q-a-coronaviruses"),
                                      child : Text("Myth Busters by WHO",style: TextStyle(fontSize: 15,color:Color(0xFFfe9900),fontWeight: FontWeight.bold),),
                                    ),
                                  ]
                              )
                          )
                      )
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
