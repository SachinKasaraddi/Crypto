import 'package:flutter/material.dart';
import 'package:flutter_crypto/home_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() async {
  List currencies = await getCurrencies();
  runApp(new MyApp(currencies));
}

class MyApp extends StatelessWidget {
  final List _currencies;
  MyApp(this._currencies);

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.pink),
      home: new HomePage(_currencies),
    );
  }
}
 
 Future<List> getCurrencies() async {
    var headers = {
      'X-CMC_PRO_API_KEY': '86f13433-f5e2-4893-986e-2e35c90397bc',
      'Accept': 'application/json',
      'Content-Type': 'application/x-www-form-urlencoded',
      'Cookie': '__cfduid=d30f322262ee6398a57946c59e563acc71619294665'
    };
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest?limit=500'));
    request.bodyFields = {'start': '1', 'limit': '5000', 'convert': 'USD'};
    request.headers.addAll(headers);

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return jsonDecode(response.body)["data"];
  }
