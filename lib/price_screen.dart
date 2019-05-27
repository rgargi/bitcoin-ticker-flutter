import 'package:bitcoin_ticker/coin_data.dart';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform; //only show Platform class from the library

class PriceScreen extends StatefulWidget {
  @override
  _PriceScreenState createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectedCurrency = 'USD';
  String cryptoValue = '?';

  void getData(String currency) async {
    CoinData coinData = CoinData();
    try {
      double data = await coinData.getCoinData(currency);
      setState(() {
        cryptoValue = data.toStringAsFixed(0);
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getData('BTCUSD');
  }

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
          getData('BTC' + value);
        });
      },
    );
  }

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
        selectedCurrency = pickerItems[selectedIndex].data;
        getData('BTC' + selectedCurrency);
      },
    );
  }

  List<Text> getCupertinoPickerItems(List<String> list) {
    List<Text> pickerItems = [];
    for (String i in list) {
      pickerItems.add(Text(i));
    }
    return pickerItems;
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
          Padding(
            padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
            child: Card(
              color: Colors.lightBlueAccent,
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
                child: Text(
                  '1 BTC = $cryptoValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            child: Platform.isAndroid
                ? iOSPicker(currenciesList)
                : androidDropdown(currenciesList),
          ),
        ],
      ),
    );
  }
}
