import 'package:flutter/material.dart';
import 'package:project_shoku/widgets/total_card.dart';

//Widgets

import '../widgets/cart_card.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          CartCard(),
          CartCard(),
          CartCard(),
          CartCard(),
          CartCard(),
        ],
      ),
      bottomNavigationBar: TotalCard(),
    );
  }
}
