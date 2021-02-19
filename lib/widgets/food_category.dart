import 'package:flutter/material.dart';
import '../widgets/food_card.dart';
import '../icons/category_data.dart';
import '../class/category_class.dart';

class FoodCategory extends StatelessWidget {
  final List<Category> _categories = categories;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.0,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: _categories.length, //get no of item from categories
          itemBuilder: (BuildContext context, int index) {
            return FoodCard(
              categoryName: _categories[index].categoryName,
              imagePath: _categories[index].imagePath,
              noOfItems: _categories[index].noOfItems,
            );
          }),
    );
  }
}
