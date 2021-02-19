import 'package:flutter/material.dart';

class BoughtFoods extends StatefulWidget {
  final String id;
  final String foodName;
  final String imagePath;
  final String category;
  final String description;
  final double price;
  final double discount;
  final int ratings;

  BoughtFoods(
      {this.id,
      this.foodName,
      this.imagePath,
      this.category,
      this.description,
      this.price,
      this.discount,
      this.ratings});

  @override
  _BoughtFoodsState createState() => _BoughtFoodsState();
}

class _BoughtFoodsState extends State<BoughtFoods> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Stack(
        children: <Widget>[
          Container(
            height: 250.0,
            width: 370.0,
            child: Image.asset(widget.imagePath, fit: BoxFit.cover),
          ),
          Positioned(
            left: 0.0,
            bottom: 0.0,
            child: Container(
              height: 60.0,
              width: 370.0,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.black, Colors.black38],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Positioned(
            // Name and ratings
            left: 10.0,
            bottom: 10.0,
            right: 10.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.foodName,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    Text("\$" + widget.price.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            color: Theme.of(context).primaryColor)),
                  ],
                ),
              ],
            ),
          ),
          Positioned(
            right: -10.0,
            child: Row(
              children: <Widget>[
                Container(
                  width: 140.0,
                  height: 35.0,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.black12],
                      begin: Alignment.topRight,
                      end: Alignment.center,
                    ),
                    borderRadius:
                        BorderRadius.only(bottomLeft: Radius.circular(5.0)),
                  ),
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.star_rate,
                        color: Colors.red[500],
                        size: 25.0,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: Colors.red[500],
                        size: 25.0,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: Colors.red[500],
                        size: 25.0,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: Colors.red[500],
                        size: 25.0,
                      ),
                      Icon(
                        Icons.star_rate,
                        color: Colors.grey,
                        size: 25.0,
                      ),
                      SizedBox(width: 10.0),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
