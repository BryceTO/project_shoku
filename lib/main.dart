import 'package:flutter/material.dart';
import 'package:project_shoku/pages/signin.dart';
import 'package:project_shoku/model/main_model.dart';
import 'package:project_shoku/main_screen.dart';
import 'package:scoped_model/scoped_model.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MainModel>(
      model: mainModel,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "SHOKU",
        theme: ThemeData(primaryColor: Colors.redAccent),
        routes: {
          "/": (BuildContext context) => SignInPage(),
          "/mainscreen": (BuildContext context) => MainScreen(
                model: mainModel,
              ),
        },
      ),
    );
  }
}
