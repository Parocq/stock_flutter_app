import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_flutter_app/entity/Account.dart';
import 'package:http/http.dart';

import 'package:stock_flutter_app/network/Networker.dart';
import 'package:stock_flutter_app/toast/ToastManager.dart';

class MyLoginPage extends StatefulWidget {
  MyLoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<MyLoginPage> {
  var _obscureTextPassword = true;

  void _passwordIconClick() {
    setState(() {
      _obscureTextPassword = !_obscureTextPassword;
    });
  }

  TextEditingController urlInputController = new TextEditingController();
  TextEditingController loginInputController = new TextEditingController();
  String loginValue;
  TextEditingController passwordInputController = new TextEditingController();
  String passwordValue;

  void updateValues() {
    loginValue = loginInputController.text;
    passwordValue = passwordInputController.text;
  }

  Future<void> sendLoginRequest(String login, String password) async {
    Account account = new Account(0, login, password, "operator");
    /*
    account.toJson(account)

    map = jsonDecode(JSON)

    var account = Account.fromJson(map)
     */

    print(account.toJson(account));
    if (login.isEmpty || password.isEmpty) return;

    Response response =
        await Networker.instance.loginRequest(account.toJson(account));

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("statusCode = $statusCode; response = $responseBody");
    if (statusCode == 200) {
      //if OK - log in
      /**----------------------------mapping to app---------------------------**/
      ToastManager().showSuccessDialog("Logged IN!");
      Navigator.pushNamed(context, '/drivers');
    } else {
      ToastManager().showErrorDialog("Error while logging in");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(30.0, 150.0, 30.0, 20.0),
          child: Column(
            children: [
              TextField(
                controller: urlInputController,
                decoration: InputDecoration(
                    labelText: "URL",
                    hintText: "without http://",
                    border: OutlineInputBorder()),
              ),
              RaisedButton(
                elevation: 5.0,
                splashColor: Colors.white12,
                child: Text("change URL"),
                onPressed: () {
                  ToastManager().showSuccessDialog("changed from ${Networker.instance.baseUrl} to ${urlInputController.text}");
                  Networker.instance.baseUrl = 'http://${urlInputController.text}:8080';
                },
              ),
              TextField(
                controller: loginInputController,
                decoration: InputDecoration(
                    labelText: "Login",
                    hintText: "Input your login",
                    border: OutlineInputBorder()),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(
                height: 16,
              ),
              Form(
                child: TextFormField(
                  controller: passwordInputController,
                  validator: (String value) {
                    if (value.length < 4) {
                      return "Password is too short";
                    } else
                      return null;
                  },
                  decoration: InputDecoration(
                      labelText: "Password",
                      hintText: "Input your password",
                      border: OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(_obscureTextPassword
                            ? Icons.remove_red_eye
                            : Icons.security),
                        onPressed: () {
                          _passwordIconClick();
                        },
                      )),
                  obscureText: _obscureTextPassword,
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(70.0, 16.0, 70.0, 16.0),
                  elevation: 5.0,
                  child: Text("Login"),
                  splashColor: Colors.white12,
                  //цвет отпускания клавиши
                  onPressed: () async {
                    /**-----------Запрос на вход на сервер ---------**/
                    // Navigator.pushNamed(context, '/operators');
                    updateValues();
                    sendLoginRequest(loginValue, passwordValue);
                  },
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(40.0, 16.0, 40.0, 16.0),
                  elevation: 5.0,
                  splashColor: Colors.white12,
                  child: Text("Registration"),
                  onPressed: () {
                    Navigator.pushNamed(context, '/registration');
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
