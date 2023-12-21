// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:project12/price_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PriceScreen(),
    );
  }
}
