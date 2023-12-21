// ignore_for_file: use_key_in_widget_constructors, sort_child_properties_last, avoid_print

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'coin_data.dart';
import 'dart:io' show Platform;

class PriceScreen extends StatefulWidget {
  const PriceScreen();

  @override
  State<PriceScreen> createState() => _PriceScreenState();
}

class _PriceScreenState extends State<PriceScreen> {
  String selectCurrency = 'USD';
  double? num;
  int? rate2;
// dropdown for andriod.
  DropdownButton<String> andriodDropdown() {
    //to do DropdownMenuItem for dropdownButton
    List<DropdownMenuItem<String>> dropdownItem = [];
    //for (int i = 0; i < currency.length; i++) {
    for (String currencyItem in currency) {
      //String currencyItem = currency[i];
      var newItem = DropdownMenuItem(
        //text -> string
        child: Text(currencyItem),
        value: currencyItem,
      );
      dropdownItem.add(newItem);
    }
    return DropdownButton<String>(
        //first item appear
        value: selectCurrency,
        items: dropdownItem,
        onChanged: (value) {
          setState(() {
            selectCurrency = value!;
            print(selectCurrency);
            getData();
          });
        });
  }

  //cupertiono for ios .
  CupertinoPicker iosPicker() {
    List<Text> picker = [];
    for (String currencyItem in currency) {
      picker.add(Text(currencyItem));
    }
    return CupertinoPicker(
      itemExtent: 40,
      onSelectedItemChanged: (selectedIndex) {
        print(selectedIndex);
        setState(() {
          selectCurrency = currency[selectedIndex];
        });
      },
      children: picker,
    );
  }

  // Widget? getDesign() {
  //   if (Platform.isIOS) {
  //     return iosPicker();
  //   } else if (Platform.isAndroid) {
  //     return andriodDropdown();
  //   }
  // }
  Map<String, String> coinType = {};
  String price = '?';
  late String sourceItem;
  bool wait = false;
  void getData() async {
    wait = true;
    for (sourceItem in source) {
      try {
        CoinData coinData = CoinData(
            'https://rest.coinapi.io/v1/exchangerate/$sourceItem/$selectCurrency?apikey=8CDAFBAF-0D4F-48EB-AAE9-6E6BA77F17A1');

        var coinPart = await coinData.getCoinData();
        var price1 = jsonDecode(coinPart)['rate'];
        wait = false;
        setState(() {
          coinType[sourceItem] = price1.toStringAsFixed(0);
        });
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          '🤑 Coin Ticker',
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(children: [
            Items(
              price: wait ? '?' : coinType['BTC'],
              selectCurrency: selectCurrency,
              sourceT: 'BTC',
            ),
            Items(
              price: wait ? '?' : coinType['ETH'],
              selectCurrency: selectCurrency,
              sourceT: 'ETH',
            ),
            Items(
              price: wait ? '?' : coinType['LTC'],
              selectCurrency: selectCurrency,
              sourceT: 'LTC',
            ),
          ]),
          Container(
              height: 150.0,
              alignment: Alignment.center,
              padding: const EdgeInsets.only(bottom: 30.0),
              color: Colors.lightBlue,
              child: Platform.isAndroid ? andriodDropdown() : iosPicker()),
        ],
      ),
    );
  }
}

class Items extends StatelessWidget {
  const Items({
    required this.sourceT,
    required this.price,
    required this.selectCurrency,
  });
  final String sourceT;
  final price;
  final String selectCurrency;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(20),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.blue,
      ),
      child: Text(
        '1$sourceT= $price $selectCurrency',
        style: const TextStyle(
            color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }
}
