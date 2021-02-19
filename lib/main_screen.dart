import 'package:flutter/material.dart';
import 'package:project_shoku/admin/update_add_food_page.dart';
import 'package:project_shoku/class/userinfo_class.dart';
import 'package:project_shoku/pages/signin.dart';
import 'package:project_shoku/model/main_model.dart';
import 'package:scoped_model/scoped_model.dart';

//pages
import 'pages/home.dart';
import 'pages/cart.dart';
import 'pages/menu.dart';
import 'pages/profile.dart';

//Main screen for all pages
class MainScreen extends StatefulWidget {
  final MainModel model;

  MainScreen({this.model});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

//pages
  HomePage homePage;
  CartPage cartPage;
  MenuPage menuPage;
  ProfilePage profilePage;

  List<Widget> pages;
  Widget currentPage;

  @override
  void initState() {
    //implement initState
    widget.model.fetchAll();
    homePage = HomePage();
    cartPage = CartPage();
    menuPage = MenuPage(model: widget.model);
    profilePage = ProfilePage();
    pages = [homePage, menuPage, cartPage, profilePage];

    currentPage = homePage;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          title: Text(
            currentTabIndex == 0
                ? "Home"
                : currentTabIndex == 1
                    ? "Menu's"
                    : currentTabIndex == 2
                        ? "Your Orders"
                        : "User Profile",
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: buildCart(),
              onPressed: () {},
            )
          ],
        ),
        drawer: Drawer(
          child: Column(
            children: <Widget>[
              ScopedModelDescendant(
                builder: (BuildContext context, Widget Child, MainModel model) {
                  UserInfo userInfo =
                      model.getUserDetails(model.authenticatedUser.id);
                  return ListTile(
                      onTap: () {
                        if ("${userInfo.userType}" != "customer") {
                          Navigator.of(context).pop();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AddorUpdateFoodItem()));
                        } else {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => SignInPage()));
                          model.logout();
                        }
                      },
                      leading: Icon(Icons.list),
                      title: userInfo.user == "Admin"
                          ? Text(
                              "Add Food",
                              style: TextStyle(fontSize: 16.0),
                            )
                          : Text("Logout"));
                },
              ),
            ],
          ),
        ),
        resizeToAvoidBottomPadding: false,
        //bottom navigations
        bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Theme.of(context).primaryColor,
            fixedColor: Colors.white,
            onTap: (int index) {
              setState(() {
                currentTabIndex = index;
                currentPage = pages[index];
              });
            },
            currentIndex: currentTabIndex,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.fastfood_sharp),
                label: "Menu",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_basket),
                label: "Cart",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ]),
        body: currentPage,
      ),
    );
  }

  Widget buildCart() {
    return Stack(
      children: <Widget>[
        Icon(
          Icons.shopping_cart_outlined,
          color: Theme.of(context).primaryColor,
          size: 40.0,
        ),
        Positioned(
          bottom: 0.0,
          left: 1.0,
          child: Container(
            height: 15.0,
            width: 15.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(7.0),
              color: Colors.pink[700],
            ),
            child: Center(
              child: Text(
                "2",
                style: TextStyle(fontSize: 10.0),
              ),
            ),
          ),
        )
      ],
    );
  }
}
