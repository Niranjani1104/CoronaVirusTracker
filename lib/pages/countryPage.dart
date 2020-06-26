import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CountryPage extends StatefulWidget {
  @override
  _CountryPageState createState() => _CountryPageState();
}

class _CountryPageState extends State<CountryPage> {

  List countryData;
  fetchCountryData()async{
  http.Response response = await http.get('https://corona.lmao.ninja/v2/countries');
  setState(() {
    countryData = json.decode(response.body);
  });
}

  @override
  Widget build(BuildContext context) {
    return ListView(
      
    );
  }
}