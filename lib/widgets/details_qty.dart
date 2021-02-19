import 'package:flutter/material.dart';

class DetailQuantity extends StatefulWidget {
  @override
  _DetailQuantityState createState() => _DetailQuantityState();
}

class _DetailQuantityState extends State<DetailQuantity> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        IconButton(
            icon: Icon(Icons.remove),
            onPressed: () {
              setState(() {
                if (quantity <= 1) {
                  quantity == 1;
                } else {
                  --quantity;
                }
              });
            }),
        SizedBox(width: 20.0),
        Text("${quantity}",
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
        SizedBox(width: 20.0),
        IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              setState(() {
                ++quantity;
              });
            }),
      ],
    );
  }
}
