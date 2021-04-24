import 'dart:ffi';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final List<MaterialColor> _colors = [Colors.blue, Colors.indigo, Colors.red];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: new Text("Crypto"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
      child: Column(
        children: [
          new Flexible(
            child: new ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];
                final MaterialColor color = _colors[index % _colors.length];
                return _getListItemUi(currency, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile _getListItemUi(Map currency, MaterialColor color) {
    final quotes = currency['quote'];
    final usdPrice = quotes['USD'];
    final price = usdPrice['price'];
    final percentageChange = usdPrice['percent_change_1h'];
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(
        currency['name'],
        style: new TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: _getSubtitleText(
          price, percentageChange),
          isThreeLine: true,
    );
  }

  Widget _getSubtitleText(double priceUSD, double percentageChange) {
    String percentChange = percentageChange.toStringAsFixed(2);
    String priceUsdAsString = priceUSD.toStringAsFixed(2);
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$priceUsdAsString\n", style: new TextStyle(color: Colors.black));
    
    String percentageChangeText = "1 hour: $percentChange%";
    TextSpan percentageChangeTextWidgte;

    if (percentageChange != null && percentageChange > 0) {
      percentageChangeTextWidgte = new TextSpan(
          text: percentageChangeText,
          style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidgte = new TextSpan(text:percentageChangeText,style: new TextStyle(color:Colors.red));
    }
    return new RichText(text: new TextSpan(children:[priceTextWidget,percentageChangeTextWidgte]));
  }
}
