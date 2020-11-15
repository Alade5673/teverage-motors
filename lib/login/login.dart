import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teverage_motors/components/landing.dart';
import 'package:teverage_motors/components/light.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/mainlightfleet.dart';
import 'package:teverage_motors/login/add.dart';
import 'package:teverage_motors/login/register.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
//import 'package:toast/toast.dart';

class Login extends StatefulWidget {

  final List list;
  final int index;
  Login({this.list,this.index});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {

  TextEditingController email = TextEditingController();
  TextEditingController passcode = TextEditingController();

  bool editMode = false;


  @override
  void initState() {
    super.initState();
//    if(widget.index != null){
//      editMode = true;
//      email.text = widget.list[widget.index]['email'];
//      passcode.text = widget.list[widget.index]['passcode'];
//    }

  }

  Future login()async{
    var response = await http.post('https://teverage.com/mobiledb/login.php',
        body: {
          "email":email.text,
          "passcode":passcode.text,
        }
    );
    var msg = json.decode(response.body);
    if(msg == "OKK"){
      Fluttertoast.showToast(msg: "Your Login is Succesful", toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
      Navigator.push(context, MaterialPageRoute(builder: (context)=>LightFleet(),),);
    }else{
      Fluttertoast.showToast(msg: "Email and password invalid!", toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER);
    }
    print(msg);
  }

//  Future login() async {
//    var url = 'https://teverage.com/mobiledb/login/login.php';
//    var response = await http.post(url,body:{
//      "email" : email.text,
//      "passcode": passcode.text
//    });
//    var data = json.decode(response.body);
//    if(data == "Success"){
//      Fluttertoast.showToast(msg: "Login Successful",
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.CENTER,
//      timeInSecForIosWeb: 1,
//      backgroundColor: Colors.green,
//      textColor: Colors.white,
//      fontSize: 16.0);
//
//      Navigator.push(context, MaterialPageRoute(builder: (context) => Light()));
//    }else{
//      Fluttertoast.showToast(msg: "Username and Password Incorrect!",
//      toastLength: Toast.LENGTH_SHORT,
//      gravity: ToastGravity.CENTER,
//      backgroundColor: Colors.red,
//      textColor: Colors.white,
//      fontSize: 16.0);
//    }
//  }
  

  @override
  Widget build(BuildContext context) {

    // this below line is used to make notification bar transparent
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));

    return Scaffold(
      resizeToAvoidBottomPadding: false,
      body: Stack(
        children: <Widget>[
          Image.asset(
            //TODO update this
            'assets/bkg.png',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(1.0),
                      Colors.white.withOpacity(.1),
                    ])),
          ),
          SingleChildScrollView(
              child: Padding(
              padding: EdgeInsets.only(bottom: 60),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/edited_logo2.png'),
                  Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 27.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text(
                    //TODO update this
                    'Login To Teverage Limited!',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.email,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: TextField(
                            // controller: email,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: 'Email',
                                focusedBorder: InputBorder.none,
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                    color: Colors.white70
                                )
                            ),
                            style: TextStyle(fontSize: 16,
                                color: Colors.white),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  Stack(
                    children: <Widget>[
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                          height: 50,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 20),
                                height: 22,
                                width: 22,
                                child: Icon(
                                  Icons.vpn_key,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          )),
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: TextField(
                            // controller: passcode,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.white70
                              ),
                            ),
                            style: TextStyle(fontSize: 16,
                                color: Colors.white),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  InkWell(
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => Register()),
//                      );
//                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      margin: EdgeInsets.fromLTRB(215, 0, 0, 0),
                      child: Center(
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  InkWell(
                    onTap: () {
//                      login();
                      // setState(() {
                      //   login();
                      // });
                      Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => AddEditPage()),
                        MaterialPageRoute(builder: (context) => mainLightFleet()),
                      );
                    },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.fromLTRB(40, 0, 40, 0),
                    child: Center(
                        child: Text(
                          'Login',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black),
                        )),
                  ),),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50)
                    ),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                          "Don't have an account?",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white),
                        )),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                    child: Container(
                      height: 30,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50)
                      ),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: Text(
                            "Register",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

//  void showToast(String msg, {int duration, int gravity}) {
//    Toast.show(msg, context, duration: duration, gravity: gravity);
//  }
}
