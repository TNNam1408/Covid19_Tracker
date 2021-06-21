import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class World extends StatefulWidget {

  @override
  _WorldState createState() => _WorldState();
}

class _WorldState extends State<World> {
  final String url = "https://corona.lmao.ninja/v3/covid-19/countries";

  Future<List> datas;

  Future<List> getData() async{
    var response = await Dio().get(url);
    return response.data;

  }

  @override
  void initState() {
    super.initState();
    datas = getData();
  }

  Future showcard(String cases,tcases,death,tdeath,recover,trecover)async{
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color(0xFF363636),
          shape: RoundedRectangleBorder(),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Text("Covid-19",style: TextStyle(fontSize: 35,color: Colors.white70),),
                ),
                Text("Total Cases: $cases",style: TextStyle(fontSize: 30,color: Colors.orange),),
                Text("Total Today' Cases: $tcases",style: TextStyle(fontSize: 25,color: Colors.orangeAccent),),
                Text("Total Death: $death",style: TextStyle(fontSize: 25,color: Colors.red),),
                Text("Total Today'Death: $tdeath",style: TextStyle(fontSize: 25,color: Colors.red),),
                Text("Total Recovered: $recover",style: TextStyle(fontSize: 25,color: Colors.green),),
                Text("Total Today'Recovered: $trecover",style: TextStyle(fontSize: 25,color: Colors.green),),

              ],
            ),
          ),
        );
      }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Worldwide Statistics"),
        backgroundColor:  Color(0xFFfe9900),
      ),
      backgroundColor: Colors.black,
      body: Container(
        padding: EdgeInsets.all(10),
        child: FutureBuilder(
            // ignore: missing_return
            future: datas,
            builder: (BuildContext context, SnapShot){
              if(SnapShot.hasData){
                return GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10.0,
                      mainAxisSpacing: 10.0,
                      childAspectRatio: 1.3
                    ),
                    itemCount: 222,
                    itemBuilder: (BuildContext context, index)=>SizedBox(
                      height: 50,
                      width: 50,
                      child: GestureDetector(
                        onTap: ()=>showcard(
                          SnapShot.data[index]['cases'].toString(),
                          SnapShot.data[index]['todayCases'].toString(),
                          SnapShot.data[index]['deaths'].toString(),
                          SnapShot.data[index]['todayDeaths'].toString(),
                          SnapShot.data[index]['recovered'].toString(),
                          SnapShot.data[index]['todayRecovered'].toString(),
                        ),

                        child: Card(
                          child: Container(
                            color: Color(0xFF292929),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Total Cases:${SnapShot.data[index]['cases'].toString()}",
                                    style: TextStyle(fontSize: 20, color: Colors.orange, fontWeight: FontWeight.bold),
                                  ),
                                  Padding(padding: EdgeInsets.only(top: 5)),
                                  Image(image: AssetImage("assets/images/wdeath.png"),
                                    height: 90,
                                    width: 90,
                                  ),
                                  Text(SnapShot.data[index]['country'],
                                      style: TextStyle(
                                          fontSize: 14,
                                          color:Colors.white,
                                          fontWeight:FontWeight.bold
                                      )
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
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
