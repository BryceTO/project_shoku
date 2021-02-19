import 'package:flutter/material.dart';
import 'package:project_shoku/switch/switch_mode.dart';
import 'package:project_shoku/model/main_model.dart';
import 'package:project_shoku/widgets/show_dialog.dart';
import 'package:scoped_model/scoped_model.dart';

import 'signin.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool _toggleVisible = true;
  bool _toggleConfirmVisible = true;

  String _email;
  String _username;
  String _password;
  String _cpassword;

  GlobalKey<FormState> _formKey = GlobalKey();
  GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Email",
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
        if (email.isEmpty) {
          errorMessage = "Email is required";
        } else if (!email.contains('@')) {
          errorMessage = "Invalid email address";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildUsernameTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Username",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        ),
      ),
      onSaved: (String username) {
        _username = username.trim();
      },
      validator: (String username) {
        String errorMessage;
        if (username.isEmpty) {
          errorMessage = "username is required";
        } else if (username.length < 5) {
          errorMessage = "username must be 8 characters";
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
          errorMessage = " password is required";
        } else if (password.length < 6) {
          errorMessage = "Password must be 6 characters long";
        } else if (_password != _cpassword) {
          errorMessage = "Password and Confirm password is incorrect";
        }
        return errorMessage;
      },
    );
  }

  Widget _buildConfirmPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Confirm Password",
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 18.0,
        ),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _toggleConfirmVisible = !_toggleConfirmVisible;
            });
          },
          icon: _toggleConfirmVisible
              ? Icon(Icons.visibility_off)
              : Icon(Icons.visibility),
        ),
      ),
      obscureText: _toggleConfirmVisible,
      onSaved: (String cpassword) {
        _cpassword = cpassword;
      },
      validator: (String cpassword) {
        String errorMessage;
        if (cpassword.isEmpty) {
          errorMessage = "Confirm password is required";
        } else if (cpassword.length < 6) {
          errorMessage = "Password must be 6 characters long";
        } else if (_cpassword != _password) {
          errorMessage = "Password and Confirm password is incorrect";
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
        backgroundColor: Colors.grey.shade100,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "New User",
                  style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 50.0),
                Card(
                  elevation: 5.0,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Column(
                      children: <Widget>[
                        _buildEmailTextField(),
                        SizedBox(height: 20.0),
                        _buildUsernameTextField(),
                        SizedBox(height: 20.0),
                        _buildPasswordTextField(),
                        SizedBox(height: 20.0),
                        _buildConfirmPasswordTextField(),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                _buildSignUp(),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Already have an account?",
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
                                builder: (context) => SignInPage()));
                      },
                      child: Text(
                        "Sign In",
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

  Widget _buildSignUp() {
    return ScopedModelDescendant(
      builder: (BuildContext sctx, Widget child, MainModel model) {
        return GestureDetector(
          onTap: () {
            showLoadingIndicator(context, "Creating User...");
            onSubmit(model.authenticate);
          },
          child: Container(
            height: 50.0,
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Center(
              child: Text(
                "SIGN UP",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
            ),
          ),
        );
      },
    );
  }

  void onSubmit(Function authenticate) {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();

      Map<String, dynamic> userInfo = {
        "email": _email,
        "user": _username,
        "userType": "customer",
      };

      authenticate(_email, _password,
              authMode: AuthMode.SignUp, userInfo: userInfo)
          .then((final response) {
        Navigator.of(context).pop();
        if (!response['hasError']) {
          print(response['message']);
          //Navigate to Home Page
          Navigator.of(context).pop();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SignInPage()));
        } else {
          //Show Error message
          Navigator.of(context).pop();
          _scaffoldkey.currentState.showSnackBar(SnackBar(
              duration: Duration(seconds: 2),
              content: Text(response['message'])));
        }
      });
    }
  }
}
