import 'package:flutter/material.dart';
import 'package:project_shoku/widgets/button.dart';

class FoodItemCard extends StatelessWidget {
  final String name;
  final String description;
  final String price;

  FoodItemCard(this.name, this.description, this.price);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      margin: EdgeInsets.symmetric(vertical: 10.0),
      width: MediaQuery.of(context).size.width,
      height: 130.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(right: 10.0),
            width: 100.0,
            height: 90.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/foods/ramen_misochasu.jpg"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "$name",
                style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10.0),
              Container(
                  width: 200.0,
                  child: Text("$description",
                      style: TextStyle(
                          fontSize: 13.0, fontWeight: FontWeight.w500))),
              SizedBox(height: 15.0),
              Container(
                width: 200.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "\$ $price",
                      style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor),
                    ),
                    SmallButton(
                      btnText: "Add to cart",
                      heigth: 25.0,
                      width: 95.0,
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
