import 'package:flutter/material.dart';

class FoodCard extends StatelessWidget {
  final String categoryName;
  final String imagePath;
  final int noOfItems;

  FoodCard({this.categoryName, this.imagePath, this.noOfItems});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Card(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          children: <Widget>[
            Image(
              image: AssetImage(imagePath),
              width: 70.0,
              height: 70.0,
            ),
            SizedBox(
              width: 15.0,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  categoryName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Text(noOfItems.toString() + " items"),
              ],
            ),
          ],
        ),
      )),
    );
  }
}
