import 'package:flutter/material.dart';
import 'package:project_shoku/admin/update_add_food_page.dart';

import 'package:project_shoku/class/userinfo_class.dart';

import 'package:project_shoku/model/main_model.dart';
import 'package:project_shoku/widgets/menu_item_card.dart';
import 'package:project_shoku/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

import 'details.dart';

class MenuPage extends StatefulWidget {
  final MainModel model;

  MenuPage({this.model});
  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  GlobalKey<ScaffoldState> _menuPageScaffoldKey = GlobalKey();
  @override
  void initState() {
    super.initState();
    widget.model.fetchfoods();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _menuPageScaffoldKey,
        backgroundColor: Colors.white,
        body: ScopedModelDescendant<MainModel>(
          builder: (BuildContext sctx, Widget child, MainModel model) {
            UserInfo userInfo =
                model.getUserDetails(model.authenticatedUser.id);
            return Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: RefreshIndicator(
                onRefresh: model.fetchfoods,
                child: ListView.builder(
                  itemCount: model.foods.length,
                  itemBuilder: (BuildContext lctx, int index) {
                    return GestureDetector(
                      onTap: () async {
                        if ("${userInfo.userType}" != "customer") {
                          final bool response = await Navigator.of(context)
                              .push(MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      AddorUpdateFoodItem(
                                        food: model.foods[index],
                                      )));
                          if (response) {
                            SnackBar snackBar = SnackBar(
                              duration: Duration(seconds: 2),
                              backgroundColor: Colors.blue,
                              content: Text(
                                "Food item updated successfully. ",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16.0),
                              ),
                            );
                            _menuPageScaffoldKey.currentState
                                .showSnackBar(snackBar);
                          }
                        } else {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  FoodDetailsPage(
                                    food: model.foods[index],
                                  )));
                        }
                      },
                      onDoubleTap: () {
                        //delete food item
                        if ("${userInfo.userType}" != "customer") {
                          showLoadingIndicator(
                              context, "deleting food item...");
                          model
                              .deleteFood(model.foods[index].id)
                              .then((bool response) {
                            Navigator.of(context).pop();
                          });
                        }
                      },
                      child: FoodItemCard(
                        model.foods[index].foodName,
                        model.foods[index].description,
                        model.foods[index].price.toString(),
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ));
  }
}
