import 'package:flutter/material.dart';
import 'package:project_shoku/pages/signup.dart';
import 'package:project_shoku/model/main_model.dart';
import 'package:project_shoku/widgets/button.dart';
import 'package:project_shoku/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  bool _toggleVisible = true;

  GlobalKey<FormState> _formkey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  String _email;
  String _password;

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Your email address",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        ),
      ),
      onSaved: (String email) {
        _email = email.trim();
      },
      validator: (String email) {
        String errorMessage;
        if (!email.contains("@")) {
          errorMessage = "Invalid email";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Password",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleVisible = !_toggleVisible;
            });
          },
          icon: _toggleVisible
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleVisible,
      onSaved: (String password) {
        _password = password;
      },
      validator: (String password) {
        String errorMessage;
        if (password.isEmpty) {
          errorMessage = "Password field is empty";
        }
        return errorMessage;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldkey,
        resizeToAvoidBottomPadding: false,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Sign In",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "Forgotten Password? ",
                      style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.blueAccent,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(height: 10.0),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _buildEmailTextField(),
                        SizedBox(height: 20.0),
                        _buildPasswordTextField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildSignIn(),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Dont have an account?",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey,
                          fontSize: 15.0),
                    ),
                    SizedBox(width: 10.0),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPage()));
                      },
                      child: Text(
                        "Sign Up ",
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSignIn() {
    return ScopedModelDescendant(
        builder: (BuildContext sctx, Widget child, MainModel model) {
      return GestureDetector(
        onTap: () {
          showLoadingIndicator(context, "Signing in");
          onSubmit(model.authenticate);
        },
        child: Button(btnText: "Sign In"),
      );
    });
  }

  void onSubmit(Function authenticate) {
    if (_formkey.currentState.validate()) {
      _formkey.currentState.save();

      authenticate(_email, _password).then((final response) {
        if (!response['hasError']) {
          Navigator.of(context).pop();
          Navigator.of(context).pushReplacementNamed("/mainscreen");
        } else {
          Navigator.of(context).pop();
          _scaffoldkey.currentState.showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
              content: Text(response['message'])));
        }
      });
    }
  }
}
