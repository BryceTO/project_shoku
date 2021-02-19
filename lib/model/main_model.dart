import 'package:project_shoku/model/food_model.dart';
import 'package:project_shoku/model/user_model.dart';
import 'package:scoped_model/scoped_model.dart';

class MainModel extends Model with FoodModel, UserModel {
  void fetchAll() {
    fetchUserInfos();
    fetchfoods();
  }
}
