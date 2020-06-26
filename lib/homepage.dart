import 'dart:convert';
import 'package:CovidTracker/datasource.dart';
import 'package:CovidTracker/panels/infoPanel.dart';
import 'package:CovidTracker/panels/mostaffectedcountries.dart';
import 'package:CovidTracker/panels/worldwidepanel.dart';
import 'package:flutter/material.dart';
import 'datasource.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

Map worldData;
fetchWorldWideData()async{
  http.Response response = await http.get('https://corona.lmao.ninja/v2/all');
  setState(() {
    worldData = json.decode(response.body);
  });
}

List countryData;
fetchCountryData()async{
  http.Response response = await http.get('https://corona.lmao.ninja/v2/countries');
  setState(() {
    countryData = json.decode(response.body);
  });
}

@override
void initState(){
  fetchWorldWideData();
  fetchCountryData();
  super.initState();
}


  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('COVID-19 TRACKER',),
      ),
      body: SingleChildScrollView(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            color: Colors.orange[100],
            child: Text(
                  DataSource.quote,
                  style: TextStyle(
                    color: Colors.orange[800],
                    fontWeight: FontWeight.bold,
                    fontSize: 16,),
                    ),
          ),
          Padding(
          padding: const EdgeInsets.symmetric(vertical:10,horizontal: 10),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: <Widget>[
              Text('Worldwide',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
              Container(
                decoration: BoxDecoration(
                  color: primaryBlack,
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.all(10),
                child:Text('Regional',style: TextStyle(fontSize: 16,color:Colors.white,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
          worldData==null?CircularProgressIndicator():WorldwidePanel(worldData: worldData,),
          Padding(
          padding: const EdgeInsets.symmetric(vertical: 5,horizontal:10),
          child: Text('Most affected Countries',style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
          ),
          SizedBox(height: 10,),
          countryData==null?Container():MostAffectedPanel(countryData: countryData,),
          InfoPanel(),
          SizedBox(height: 20,),
          Center(child: Text('We ARE TOGETHER IN THE FIGHT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
          SizedBox(height: 50,)

        ],
      )),
    );

  }
}