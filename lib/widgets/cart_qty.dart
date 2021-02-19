import 'package:flutter/material.dart';

class CartQuantity extends StatefulWidget {
  @override
  _CartQuantityState createState() => _CartQuantityState();
}

class _CartQuantityState extends State<CartQuantity> {
  int quantity = 1;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            border:
                Border.all(width: 2.0, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5.0),
                bottomLeft: Radius.circular(5.0)),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                if (quantity <= 1) {
                  quantity == 1;
                } else {
                  --quantity;
                }
              });
            },
            child: Icon(Icons.remove, color: Theme.of(context).primaryColor),
          ),
        ),
        Container(
          height: 30.0,
          width: 55.0,
          decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 2.0, color: Theme.of(context).primaryColor),
                bottom: BorderSide(
                    width: 2.0, color: Theme.of(context).primaryColor)),
          ),
          child: Text('Qty: ${quantity}',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 14.0, color: Theme.of(context).primaryColor)),
          alignment: Alignment(0.0, 0.0),
        ),
        Container(
          height: 30.0,
          width: 30.0,
          decoration: BoxDecoration(
            border:
                Border.all(width: 2.0, color: Theme.of(context).primaryColor),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0)),
          ),
          child: InkWell(
            onTap: () {
              setState(() {
                ++quantity;
              });
            },
            child: Icon(Icons.add, color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
