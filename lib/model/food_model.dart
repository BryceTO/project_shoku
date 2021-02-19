import 'dart:convert';

import 'package:project_shoku/class/food_class.dart';
import 'package:scoped_model/scoped_model.dart';

import 'package:http/http.dart' as http;

class FoodModel extends Model {
  List<Food> _foods = [];
  bool _isloading = false;

  bool get isloading {
    return _isloading;
  }

  List<Food> get foods {
    return List.from(_foods);
  }

  int get foodlength {
    return _foods.length;
  }

  Future<bool> addFood(Food food) async {
    _isloading = true;

    notifyListeners();

    try {
      final Map<String, dynamic> foodData = {
        "name": food.foodName,
        "description": food.description,
        "category": food.category,
        "price": food.price,
        "discount": food.discount,
      };
      final http.Response response = await http.post(
          "https://project-shoku-12c64-default-rtdb.firebaseio.com/foods.json",
          body: json.encode(foodData));

      final Map<String, dynamic> responseData = json.decode(response.body);
      //Recreate Food with firebase ID
      Food foodWithID = Food(
        id: responseData["name"],
        foodName: food.foodName,
        description: food.description,
        category: food.category,
        price: food.price,
        discount: food.discount,
      );

      _foods.add(foodWithID);
      _isloading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> fetchfoods() async {
    _isloading = true;
    notifyListeners();
    try {
      final http.Response response = await http.get(
          "https://project-shoku-12c64-default-rtdb.firebaseio.com/foods.json");

      final Map<String, dynamic> fetchedData = json.decode(response.body);

      print(fetchedData);
      final List<Food> foodItems = [];

      fetchedData.forEach((String id, dynamic foodData) {
        Food foodItem = Food(
          id: id,
          foodName: foodData["name"],
          description: foodData["description"],
          category: foodData["category"],
          price: double.parse(foodData["price"].toString()),
          discount: double.parse(foodData["discount"].toString()),
        );

        foodItems.add(foodItem);
      });
      _foods = foodItems;
      _isloading = false;
      notifyListeners();
      return true;
    } catch (error) {
      print("the error: $error");
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> updateFood(Map<String, dynamic> foodData, String foodID) async {
    _isloading = true;
    notifyListeners();

    //get the food by id
    Food theFood = getFoodItemByID(foodID);

    //get the index of the food
    int foodIndex = _foods.indexOf(theFood);

    try {
      await http.put(
        "https://project-shoku-12c64-default-rtdb.firebaseio.com/foods/${foodID}.json",
        body: json.encode(foodData),
      );
      Food updateFoodItem = Food(
        id: foodID,
        foodName: foodData["name"],
        category: foodData["category"],
        description: foodData["description"],
        price: foodData["price"],
        discount: foodData["discount"],
      );

      _foods[foodIndex] = updateFoodItem;
      _isloading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> deleteFood(String foodID) async {
    _isloading = true;
    notifyListeners();
    try {
      await http.delete(
          "https://project-shoku-12c64-default-rtdb.firebaseio.com/foods/${foodID}.json");

      //delete item from the list of food item
      _foods.removeWhere((Food food) => food.id == food.id);

      _isloading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  Food getFoodItemByID(String foodID) {
    Food food;
    for (int i = 0; i < _foods.length; i++) {
      if (_foods[i].id == foodID) {
        food = _foods[i];
        break;
      }
    }
    return food;
  }
}
