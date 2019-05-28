import 'package:bitcoin_ticker/coin_data.dart';
import 'package:bitcoin_ticker/currency_card.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform; //only show Platform class from the library

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  Map<String, String> coinValues = {};
  bool isWaiting = true;

//for getting price from coin_data.dart (only passing the fiatcurrency name)
  void getData(String currency) async {
    isWaiting = true;
    CoinData coinData = CoinData();
    try {
      var data = await coinData.getCoinData(currency);
      isWaiting = false;
      setState(() {
        coinValues = data;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData(selectedCurrency);
  }

//populating dropdown menu from a list
  DropdownButton<String> androidDropdown(List<String> list) {
    List<DropdownMenuItem<String>> dropDownMenuItems = [];
    for (String i in list) {
      var newItem = DropdownMenuItem(
        child: Text(i),
        value: i,
      );
      dropDownMenuItems.add(newItem);
    }
    return DropdownButton<String>(
      value: selectedCurrency,
      items: dropDownMenuItems,
      onChanged: (value) {
        setState(() {
          selectedCurrency = value;
          getData(selectedCurrency);
        });
      },
    );
  }

  //populating Picker from a list
  Widget iOSPicker(List<String> list) {
    List<Text> pickerItems = [];
    for (String i in list) {
      pickerItems.add(Text(i));
    }
    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      children: pickerItems,
      itemExtent: 32.0,
      useMagnifier: true,
      magnification: 1.3,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = pickerItems[selectedIndex].data;
          getData(selectedCurrency);
        });
      },
    );
  }

//function which returns a column using a custom class CurrencyCard
  Column makeCards() {
    List<Widget> currencyCards = [];
    for (String crypto in cryptoList) {
      currencyCards.add(CurrencyCard(
        crypto: crypto,
        selectedCurrency: selectedCurrency,
        cryptoValue: isWaiting ? '?' : coinValues[crypto],
      ));
    }
    return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: currencyCards);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('🤑 Coin Ticker'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          makeCards(),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isIOS
                ? iOSPicker(currenciesList)
                : androidDropdown(currenciesList),
          ),
        ],
      ),
    );
  }
}
