import 'package:flutter/material.dart';
import 'package:project_shoku/class/food_class.dart';
import 'package:project_shoku/widgets/button.dart';
import 'package:project_shoku/widgets/details_qty.dart';

class FoodDetailsPage extends StatelessWidget {
  final Food food;

  FoodDetailsPage({
    this.food,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          title: Text("Details",
              style: TextStyle(fontSize: 20.0, color: Colors.black)),
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Theme.of(context).primaryColor),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 200.0,
                width: MediaQuery.of(context).size.width,
                child: Image.asset(
                  "images/foods/ramen_misochasu.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    food.foodName,
                    style: TextStyle(fontSize: 18.0, color: Colors.black),
                  ),
                  Text(
                    "\$ " + food.price.toString(),
                    style: TextStyle(
                        fontSize: 18.0, color: Theme.of(context).primaryColor),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Text(
                "Description",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              ),
              SizedBox(height: 20.0),
              Text(
                food.description,
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 15.0, color: Colors.black),
              ),
              DetailQuantity(),
              SizedBox(height: 20.0),
              Button(
                btnText: "Add to Cart",
              )
            ],
          ),
        ),
      ),
    );
  }
}
