import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutPage extends StatefulWidget {
  @override
  _AboutPageState createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        title: Text("About Us"),
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
                    child: Container(
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
                            "ABOUT SHOKU",
                            style: TextStyle(
                                fontSize: 40.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                      offset: Offset(3, 3), color: Colors.black)
                                ]),
                          ),
                          Text(
                            "Making Delicious food since 2020",
                            style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                      offset: Offset(3, 3), color: Colors.black)
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "OUR PURPOSE",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Shoku delivers 100% authenthic japanese food. Using high-quality ingredients, genuine cooking techniques, we brought features from the realm of fine dining to the world of quick service restaurants.",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              ),
              SizedBox(height: 40.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "OUR GOALS",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      "Shoku aims to deliver food to the end of the Earth. Allow users to conveniently discover japanese cuisine directly order their favourite meals online ",
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }
}
