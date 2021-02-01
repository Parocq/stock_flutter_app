import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:stock_flutter_app/toast/ToastManager.dart';

import 'network/Networker.dart';

class MyRegistrationPage extends StatefulWidget {
  MyRegistrationPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<MyRegistrationPage> {
  TextEditingController loginInputController = new TextEditingController();
  String loginValue;
  TextEditingController passwordInputController = new TextEditingController();
  String passwordValue;
  TextEditingController passwordConfirmInputController =
      new TextEditingController();
  String passwordConfirmValue;

  Future<void> sendRegistrationRequest(
      String login, String password, String passwordConfirm) async {
    if (!inputsAreEqual()){
      ToastManager().showErrorDialog("Passwords are not the same.");
      return;
    }

    final body = '{\"login\":\"$login\",\"password\":\"$password\"}';

    Response response = await Networker.instance.registrationRequest(body);

    int statusCode = response.statusCode;
    String responseBody = response.body;
    print("statusCode = $statusCode; response = $responseBody");
    if (statusCode == 200) {
      //if OK - log in
      /**----------------------------mapping to app---------------------------**/
      ToastManager().showSuccessDialog("registration good :)");
    } else {
      ToastManager().showErrorDialog("registration bad :(");
    }
  }

  void updateValues() {
    loginValue = loginInputController.text;
    passwordValue = passwordInputController.text;
    passwordConfirmValue = passwordConfirmInputController.text;
  }

  bool inputsAreEqual() {
    return passwordValue == passwordConfirmValue;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Registration"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(30.0, 100.0, 30.0, 20.0),
        child: Column(
          children: [
            Text(
              "Registration",
              style: TextStyle(fontSize: 25),
            ),
            SizedBox(
              height: 32,
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
                ),
                obscureText: true,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            Form(
              child: TextFormField(
                controller: passwordConfirmInputController,
                decoration: InputDecoration(
                  labelText: "Password",
                  hintText: "Repeat your password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
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
                child: Text("Register"),
                splashColor: Colors.white12,
                //цвет отпускания клавиши
                onPressed: () {
                  /**-----------Запрос на регситрация на сервер ---------**/
                  updateValues();
                  sendRegistrationRequest(loginValue, passwordValue, passwordConfirmValue);
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
                  child: Text("Back to login"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }
}
