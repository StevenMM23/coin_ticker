

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'coin_data.dart';

class CryptoCardScreen extends StatefulWidget {
  @override
  _CryptoCardScreenState createState() => _CryptoCardScreenState();
}

class _CryptoCardScreenState extends State<CryptoCardScreen> {
  String selectedCurrency = 'USD'; // Valor inicial del dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Crypto Cards'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<String>(
              value: selectedCurrency,
              items: currenciesList.map((String currency) {
                return DropdownMenuItem<String>(
                  value: currency,
                  child: Text(currency),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedCurrency = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            for (String crypto in cryptoList)
              Card(
                color: Colors.blue,
                child: ListTile(
                  title: Text('1 $crypto: $selectedCurrency'),
                  subtitle: Text('Crypto card content goes here'),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
