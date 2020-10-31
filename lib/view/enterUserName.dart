import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutterprojectgitapi/view/showUserInformation.dart';
import 'package:flutterprojectgitapi/viewModel/getUserInformation.dart';
import 'package:progress_indicator_button/progress_button.dart';

class EnterUserName extends StatefulWidget {
  @override
  _EnterUserNameState createState() => _EnterUserNameState();
}

class _EnterUserNameState extends State<EnterUserName> {
  var userName;
  final _formKey = GlobalKey<FormState>();
  int timer = 60;
  TextEditingController _textEditingControllerCode =
      new TextEditingController(text: '');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        key: _scaffoldKey,
        resizeToAvoidBottomPadding: true,
        body: new MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
          child: new SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.symmetric(horizontal: 40),
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _inputCode(),
                  new SizedBox(height: 30),
                  _submitButton(),
                  new Container(
                    height: 30,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _inputCode() {
    return new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Container(
            child: new Form(
          key: _formKey,
          child: new TextFormField(
            keyboardType: TextInputType.number,
            controller: _textEditingControllerCode,
            onSaved: (username) {
              userName = username;
            },
            validator: (String value) {
              if (value.length == 0) {
                return "نام‌کاربری را وارد کنید";
              } else {
                return null;
              }
            },
            decoration: new InputDecoration(
              hintText: "  نام‌کاربری‌را وارد کنید",
              labelText: 'نام‌کاربری',
              hintStyle: new TextStyle(fontSize: 13),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Colors.blueGrey,
                ),
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _submitButton() {
    return new Container(
      width: 190,
      height: 50,
      child: new ProgressButton(
        borderRadius: BorderRadius.circular(15),
        child: new Text(
          'ادامه',
          style: new TextStyle(color: Colors.white),
        ),
        onPressed: (AnimationController controller) async {
          if (_formKey.currentState.validate()) {
            _formKey.currentState.save();
            controller.forward();
            try {
              var userInformation = await new GetUserInformation()
                  .getUserPersonalInformation(userName: userName);
              controller.reset();
              Navigator.push(context,
                  MaterialPageRoute(builder: (BuildContext context) {
                return new ShowUserInformation(
                    userInformation: userInformation);
              }));
            } catch (e) {
              controller.reverse();
              _scaffoldKey.currentState.showSnackBar(
                new SnackBar(
                  content: new Text(
                    'مشکلی در دریافت داده ها وجود دارد اتصال خودرا بررسی کنید',
                    style: new TextStyle(fontFamily: 'IranSans'),
                  ),
                ),
              );
            }
          }
        },
        color: Color(0xff3F31A5),
      ),
    );
  }

  Widget ifHaveAccount() {
    return new Container(
        child: new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(' حساب کاربری دارید ؟  '),
        new GestureDetector(
          child: new Text(
            'وارد شوید',
            style: new TextStyle(color: Colors.green, fontSize: 18),
          ),
        )
      ],
    ));
  }

  showSnackBar({text, seconds = 1}) {
    _scaffoldKey.currentState.hideCurrentSnackBar();
    _scaffoldKey.currentState.showSnackBar(new SnackBar(
      content: new Text('$text'),
      duration: new Duration(seconds: seconds),
    ));
  }
}
