import 'package:project_shoku/class/user_class.dart';
import 'package:project_shoku/class/userinfo_class.dart';
import 'package:project_shoku/switch/switch_mode.dart';
import 'package:scoped_model/scoped_model.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class UserModel extends Model {
  User _authenticatedUser;
  UserInfo _authenticatedUserInfo;
  List<User> _users = [];
  List<UserInfo> _userinfos = [];
  bool _isloading = false;

  List<User> get users {
    return List.from(_users);
  }

  List<UserInfo> get userinfos {
    return List.from(_userinfos);
  }

  User get authenticatedUser {
    return _authenticatedUser;
  }

  UserInfo get authenticatedUserInfo {
    return _authenticatedUserInfo;
  }

  bool get isloading {
    return _isloading;
  }

  Future<bool> fetchUserInfos() async {
    _isloading = true;
    notifyListeners();
    try {
      final http.Response response = await http.get(
          "https://project-shoku-12c64-default-rtdb.firebaseio.com/users.json");

      final Map<String, dynamic> fetchedData = json.decode(response.body);

      final List<UserInfo> userInfos = [];

      fetchedData.forEach((String id, dynamic userInfoData) {
        UserInfo userInfo = UserInfo(
          id: id,
          email: userInfoData["email"],
          user: userInfoData["user"],
          uID: userInfoData["localId"],
          userType: userInfoData["userType"],
        );

        userInfos.add(userInfo);
      });
      _userinfos = userInfos;
      _isloading = false;
      notifyListeners();
      return true;
    } catch (error) {
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> addUser(Map<String, dynamic> userInfo) async {
    _isloading = true;

    notifyListeners();

    try {
      final http.Response response = await http.post(
          "https://project-shoku-12c64-default-rtdb.firebaseio.com/users.json",
          body: json.encode(userInfo));

      final Map<String, dynamic> responseData = json.decode(response.body);

      //Recreate Food with firebase ID
      UserInfo userinfoWithID = UserInfo(
        id: responseData['name'],
        email: userInfo['email'],
        user: userInfo['user'],
      );

      _userinfos.add(userinfoWithID);
      _isloading = false;
      notifyListeners();
      return true;
    } catch (e) {
      _isloading = false;
      notifyListeners();
      return false;
    }
  }

  Future<UserInfo> getUserInfo(String uID) async {
    final bool response = await fetchUserInfos();
    print(response);
    UserInfo foundUser;
    if (response) {
      for (int i = 0; i < _userinfos.length; i++) {
        if (_userinfos[i].uID == uID) {
          foundUser = _userinfos[i];
          print("The found User: $foundUser");
          break;
        }
      }
    }

    return Future.value(foundUser);
  }

  UserInfo getUserDetails(String uID) {
    fetchUserInfos();
    UserInfo foundUser;

    for (int i = 0; i < _userinfos.length; i++) {
      if (_userinfos[i].uID == uID) {
        foundUser = _userinfos[i];
        break;
      }
    }
    return foundUser;
  }

  Future<Map<String, dynamic>> authenticate(String email, String password,
      {AuthMode authMode = AuthMode.SignIn,
      Map<String, dynamic> userInfo}) async {
    _isloading = true;
    notifyListeners();

    Map<String, dynamic> authData = {
      "email": email,
      "password": password,
      "returnSecureToken": true,
    };

    String message;
    bool hasError = false;

    try {
      http.Response response;
      if (authMode == AuthMode.SignUp) {
        response = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyCsW2ZVPjx-2YlffsyHn8ukVJ1GJYEfjw0",
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'},
        );
      } else {
        response = await http.post(
          "https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=AIzaSyCsW2ZVPjx-2YlffsyHn8ukVJ1GJYEfjw0",
          body: json.encode(authData),
          headers: {'Content-Type': 'application/json'},
        );
      }

      Map<String, dynamic> responseBody = json.decode(response.body);

      if (responseBody.containsKey("idToken")) {
        _authenticatedUser = User(
          id: responseBody['localId'],
          email: responseBody['email'],
          token: responseBody['idToken'],
        );

        if (authMode == AuthMode.SignIn) {
          _authenticatedUserInfo = await getUserInfo(responseBody['localId']);

          print("User type is:  ${_authenticatedUserInfo.userType}");

          message = "Sign In Successfully";
        } else if (authMode == AuthMode.SignUp) {
          userInfo['localId'] = responseBody['localId'];
          addUser(userInfo);
          message = "Successfully created user";
        }
      } else {
        hasError = true;
        if (responseBody['error']['message'] == 'EMAIL_EXISTS') {
          message = "Email already exists";
        } else if (responseBody['error']['message'] == 'EMAIL_NOT_FOUND') {
          message = "Email not found";
        } else if (responseBody['error']['message'] == 'INVALID_PASSWORD') {
          message = "Password is incorrect";
        }
      }

      _isloading = false;
      notifyListeners();
      return {
        'message': message,
        'hasError': hasError,
      };
    } catch (error) {
      print("the error: $error");
      _isloading = false;
      notifyListeners();
      return {
        'message': 'failed to create user',
        'hasError': !hasError,
      };
    }
  }

  void logout() {
    _authenticatedUser = null;
    _authenticatedUserInfo = null;
  }
}
