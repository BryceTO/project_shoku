import 'package:flutter/material.dart';
import 'package:project_shoku/pages/details.dart';
import 'package:project_shoku/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/food_category.dart';
import '../widgets/food_frequent.dart';

//class
import '../class/food_class.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width,
                height: 200.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("images/banner.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "WELCOME T0",
                      style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(offset: Offset(3, 3), color: Colors.black)
                          ]),
                    ),
                    Text(
                      "SHOKU",
                      style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                          shadows: [
                            Shadow(offset: Offset(3, 3), color: Colors.black)
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Divider(
            height: 20.0,
            color: Colors.black,
          ),
          FoodCategory(),
          SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Frequently Bought Foods",
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          ScopedModelDescendant<MainModel>(
            builder: (BuildContext context, Widget child, MainModel model) {
              return Column(
                children: model.foods.map(_buildfoodItems).toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildfoodItems(Food food) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) => FoodDetailsPage(
            food: food,
          ),
        ));
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 20.0),
        child: BoughtFoods(
          id: food.id,
          foodName: food.foodName,
          imagePath: "images/foods/bento_chickenkatsu.jpg",
          category: food.category,
          description: food.description,
          price: food.price,
          discount: food.discount,
          ratings: food.ratings,
        ),
      ),
    );
  }
}
