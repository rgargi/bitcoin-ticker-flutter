import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

const List<String> currenciesList = [
  'AUD',
  'BRL',
  'CAD',
  'CNY',
  'EUR',
  'GBP',
  'HKD',
  'IDR',
  'ILS',
  'INR',
  'JPY',
  'MXN',
  'NOK',
  'NZD',
  'PLN',
  'RON',
  'RUB',
  'SEK',
  'SGD',
  'USD',
  'ZAR'
];

const List<String> cryptoList = [
  'BTC',
  'ETH',
  'LTC',
];

const baseURL = 'https://apiv2.bitcoinaverage.com/indices/global/ticker/';

//using a for loop to get price for all currencies in a list - fiat currency is passed from price_screen as selected by the user
class CoinData {
  // Map<String, String> cryptoPrices = {};
  Map cryptoPrices = {};
  Future getCoinData(String currency) async {
    for (String crypto in cryptoList) {
      http.Response response = await http.get(baseURL + crypto + currency);
      if (response.statusCode == 200) {
        // double lastPrice = jsonDecode(response.body)['last'];
        // cryptoPrices[crypto] = lastPrice.toStringAsFixed(0);
        var data = jsonDecode(response.body);
        // print(data['changes']);
        cryptoPrices[crypto] = [
          {
            'lastPrice': data['last'].toStringAsFixed(0),
            'changes': data['changes']['price']['day']
          }
        ];
      } else {
        throw 'Request failed with status ${response.statusCode}';
      }
    }
    return cryptoPrices;
  }
}
