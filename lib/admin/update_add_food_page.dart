import 'package:flutter/material.dart';
import 'package:project_shoku/class/food_class.dart';
import 'package:project_shoku/model/main_model.dart';
import 'package:project_shoku/widgets/button.dart';
import 'package:project_shoku/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class AddorUpdateFoodItem extends StatefulWidget {
  final Food food;
  AddorUpdateFoodItem({this.food});

  @override
  _AddorUpdateFoodItemState createState() => _AddorUpdateFoodItemState();
}

class _AddorUpdateFoodItemState extends State<AddorUpdateFoodItem> {
  String name;
  String category;
  String description;
  String price;
  String discount;

  GlobalKey<FormState> _foodItemFormKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldStateKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () {
          Navigator.of(context).pop(false);
          return Future.value(false);
        },
        child: Scaffold(
          key: _scaffoldStateKey,
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white,
            title: Text(
              widget.food != null ? "Update Food item" : "Add Food item",
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.close, color: Colors.black),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Form(
                key: _foodItemFormKey,
                child: Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(bottom: 15.0),
                      width: MediaQuery.of(context).size.width,
                      height: 170.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: AssetImage("images/noimage.png")),
                      ),
                    ),
                    _buildTextFormField("Food Name"),
                    _buildTextFormField("Category"),
                    _buildTextFormField("Description", maxline: 5),
                    _buildTextFormField("Price"),
                    _buildTextFormField("Discount"),
                    SizedBox(height: 30.0),
                    ScopedModelDescendant(
                      builder: (BuildContext context, Widget child,
                          MainModel model) {
                        return GestureDetector(
                          onTap: () {
                            onSubmit(model.addFood, model.updateFood);
                            if (model.isloading) {
                              //show loading progress
                              showLoadingIndicator(
                                  context,
                                  widget.food != null
                                      ? "Updating Food..."
                                      : "Adding Item...");
                            }
                          },
                          child: Button(
                              btnText: widget.food != null ? "Update" : "Add"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSubmit(Function addFood, Function updateFood) async {
    if (_foodItemFormKey.currentState.validate()) {
      _foodItemFormKey.currentState.save();

      if (widget.food != null) {
        // Edit the food item
        Map<String, dynamic> updatedFoodItem = {
          "name": name,
          "category": category,
          "description": description,
          "price": double.parse(price),
          "discount": discount != null ? double.parse(discount) : 0.0,
        };

        final bool response = await updateFood(updatedFoodItem, widget.food.id);
        if (response) {
          Navigator.of(context).pop(); // remove alert dialog
          Navigator.of(context).pop(response); // bring back to menu page

        } else if (!response) {
          Navigator.of(context).pop();
          SnackBar snackBar = SnackBar(
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
            content: Text(
              "Failed to update food. ",
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          );
          _scaffoldStateKey.currentState.showSnackBar(snackBar);
        }
      } else if (widget.food == null) {
        //i want to add new item
        final Food food = Food(
          foodName: name,
          category: category,
          description: description,
          price: double.parse(price),
          discount: double.parse(discount),
        );

        var value = await addFood(food);
        if (value) {
          Navigator.of(context).pop();
        }
      }
    }
  }

  Widget _buildTextFormField(String hint, {int maxline = 1}) {
    return TextFormField(
      initialValue: widget.food != null && hint == "Food Name"
          ? widget.food.foodName
          : widget.food != null && hint == "Category"
              ? widget.food.category
              : widget.food != null && hint == "Description"
                  ? widget.food.description
                  : widget.food != null && hint == "Price"
                      ? widget.food.price.toString()
                      : widget.food != null && hint == "Discount"
                          ? widget.food.discount.toString()
                          : "",
      decoration: InputDecoration(hintText: "$hint"),
      maxLines: maxline,
      keyboardType: hint == "Price" || hint == "Discount"
          ? TextInputType.number
          : TextInputType.text,
      validator: (String value) {
        if (value.isEmpty && hint == "Food Name") {
          return "Food Name is required";
        }

        if (value.isEmpty && hint == "Category") {
          return "Category is required";
        }

        if (value.isEmpty && hint == "Description") {
          return "Description is required";
        }

        if (value.isEmpty && hint == "Discount") {
          return "Discount is required";
        }

        if (value.isEmpty && hint == "Price") {
          return "Price is required";
        }
      },
      onSaved: (String value) {
        if (hint == "Food Name") {
          name = value;
        }
        if (hint == "Category") {
          category = value;
        }
        if (hint == "Description") {
          description = value;
        }
        if (hint == "Price") {
          price = value;
        }
        if (hint == "Discount") {
          discount = value;
        }
      },
    );
  }
}
