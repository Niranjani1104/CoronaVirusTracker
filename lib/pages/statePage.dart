import 'package:CovidTracker/pages/search1.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; 
import 'dart:convert';

class StatePage extends StatefulWidget {
  @override
  _StatePageState createState() => _StatePageState();
}

class _StatePageState extends State<StatePage> {
  List stateData;
  fetchStateData() async {
     
    http.Response response =
        await http.get('https://api.covidindiatracker.com/state_data.json');
    setState(() {
      stateData = json.decode(response.body);
      
    });
  }

  @override
  void initState() {
    fetchStateData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){
              showSearch(context: context, delegate: Search(stateData));
            },
            ),
        ],

 
        title: Text("State Stats"),
      ),
      body: stateData == null? Center(child: CircularProgressIndicator()): 
      ListView.builder(
      itemCount: stateData==null?0:stateData.length,
      itemBuilder: (context, index) {
        return Container(
            height: 140,
            margin: EdgeInsets.symmetric(horizontal:10,vertical: 10 ),
            child: Row(
            children: <Widget>[
            Container(
              width: 200,
              margin: EdgeInsets.symmetric(horizontal: 10,),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 7,),
                  Text(stateData[index]['state'],style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19),),
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                  Text('CONFIRMED: '+stateData[index]['confirmed'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 11,),),
                    Text('[+'+stateData[index]['cChanges'].toString()+"]",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 11,),),
                    Text('ACTIVE: '+stateData[index]['active'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 11,),),
                    Text('['+stateData[index]['aChanges'].toString()+']',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 11,),),
                    Text('RECOVERED: '+stateData[index]['recovered'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 11,),),
                    Text('[+'+stateData[index]['rChanges'].toString()+']',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 11,),),
                    Text('DEATHS: '+stateData[index]['deaths'].toString(),style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 11,),),
                    Text('[+'+stateData[index]['dChanges'].toString()+']',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.grey,fontSize: 11,),),
                  ],
                ),
              ),
            ),
                ],
              ),
           );
        },
      ),
    ); 
  }
}