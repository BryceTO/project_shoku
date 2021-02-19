import 'package:flutter/material.dart';
import 'package:project_shoku/class/userinfo_class.dart';
import 'package:project_shoku/pages/aboutus.dart';
import 'package:project_shoku/pages/signin.dart';
import 'package:project_shoku/model/main_model.dart';
import 'package:project_shoku/widgets/profile_list_tile.dart';
import 'package:project_shoku/widgets/button.dart';
import 'package:scoped_model/scoped_model.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool turnOnNotifications = false;

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant(
        builder: (BuildContext context, Widget child, MainModel model) {
      UserInfo userInfo = model.getUserDetails(model.authenticatedUser.id);
      return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              //Image
              //Name
              //Number
              //Edit button
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(
                  child: Column(
                    children: [
                      Text(
                        "PROFILE",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        height: 120.0,
                        width: 120.0,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(50.0),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 5.0,
                                offset: Offset(0, 4.0),
                                color: Colors.black38,
                              ),
                            ],
                            image: DecorationImage(
                              image: AssetImage("images/user.jpg"),
                              fit: BoxFit.cover,
                            )),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 20.0,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${userInfo.user}",
                          style: TextStyle(fontSize: 16.0),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          "${userInfo.email}",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(height: 20.0),
                      ],
                    ),
                    SmallButton(btnText: "Edit", heigth: 25.0, width: 60.0),
                  ],
                ),
                SizedBox(height: 30.0),

                // Account options
                Text(
                  "Account",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Column(
                      children: <Widget>[
                        ScopedModelDescendant<MainModel>(
                          builder: (BuildContext sctx, Widget child,
                              MainModel model) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) => SignInPage()));
                              },
                              child: ProfileListTile(
                                icon: Icons.logout,
                                text: "Log Out",
                              ),
                            );
                          },
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        ProfileListTile(
                          icon: Icons.visibility,
                          text: "Change Password",
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        ProfileListTile(
                          icon: Icons.credit_card,
                          text: "Payment",
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //Notifications
                Text(
                  "Nofications",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "App Notification",
                              style: TextStyle(fontSize: 16.0),
                            ),
                            Switch(
                              value: turnOnNotifications,
                              onChanged: (bool value) {
                                setState(() {
                                  turnOnNotifications = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [],
                        ),
                        Divider(
                          height: 10.0,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                //Notifications
                Text(
                  "Other",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => AboutPage()));
                            },
                            child: ProfileListTile(
                              icon: Icons.info,
                              text: "About Us",
                            ),
                          ),
                          Divider(
                            height: 30.0,
                            color: Colors.grey,
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
