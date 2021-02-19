import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnText;

  Button({this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Center(
        child: Text(
          "$btnText",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15.0),
        ),
      ),
    );
  }
}

class SmallButton extends StatelessWidget {
  final String btnText;
  final double heigth;
  final double width;

  SmallButton({this.btnText, this.heigth, this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heigth,
      width: width,
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).primaryColor),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Center(
        child: Text(
          "$btnText",
          style:
              TextStyle(color: Theme.of(context).primaryColor, fontSize: 16.0),
        ),
      ),
    );
  }
}
