import 'package:flutter/material.dart';

class CurrencyCard extends StatelessWidget {
  const CurrencyCard({
    @required this.crypto,
    @required this.cryptoValue,
    @required this.selectedCurrency,
    this.changes,
  });

  final String crypto;
  final String cryptoValue;
  final String selectedCurrency;
  final double changes;

  Icon changesIcon() {
    Icon trending;
    if (changes < 0) {
      print('negative');
      trending = Icon(
        Icons.trending_down,
        color: Colors.red,
      );
    } else if (changes > 0) {
      print('positive');
      trending = Icon(
        Icons.trending_up,
        color: Colors.green,
      );
    } else if (changes == 0) {
      print('no change');
      trending = Icon(
        Icons.trending_flat,
        color: Colors.yellow,
      );
    }
    return trending;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18.0, 18.0, 18.0, 0),
      child: Card(
        color: Color(0xFF485376),
        elevation: 5.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 28.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Text(
                  '1 $crypto = $cryptoValue $selectedCurrency',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              changesIcon(),
              Text(
                changes.toStringAsFixed(2),
                style: TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w100,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
