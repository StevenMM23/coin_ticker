import 'package:flutter/material.dart';
import 'coin_data.dart';

class CryptoCardScreen extends StatefulWidget {
  const CryptoCardScreen({super.key});

  @override
  CryptoCardScreenState createState() => CryptoCardScreenState();
}

class CryptoCardScreenState extends State<CryptoCardScreen> {
  String selectedCurrency = 'USD';
  Map<String, double> exchangeRates = {};

  @override
  void initState() {
    super.initState();
    updateExchangeRates();
  }

  void updateExchangeRates() async {
    try {
      final data = await CoinData().getExchangeRates(selectedCurrency);
      setState(() {
        exchangeRates = data;
      });
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🤑 Coin Ticker'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          const SizedBox(height: 40),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                children: [
                  for (String crypto in cryptoList)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: CryptoCard(
                        crypto: crypto,
                        selectedCurrency: selectedCurrency,
                        rate: exchangeRates[crypto] ?? 0,
                      ),
                    ),
                ],
              ),
            ),
          ),
          Container(
            color: Colors.blue,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 100),
            child: Center(
              child: DropdownButton<String>(
                value: selectedCurrency,
                items: currenciesList.map((String currency) {
                  return DropdownMenuItem<String>(
                    value: currency,
                    child: Text(
                      currency,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 18.0,
                      ),
                    ),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    selectedCurrency = newValue!;
                    updateExchangeRates();
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CryptoCard extends StatelessWidget {
  final String crypto;
  final String selectedCurrency;
  final double rate;

  const CryptoCard({
    super.key,
    required this.crypto,
    required this.selectedCurrency,
    required this.rate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      color: Colors.blue,
      child: ListTile(
        title: Text(
          '1 $crypto = ${rate.toInt()} $selectedCurrency',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
      ), //
    );
  }
}
