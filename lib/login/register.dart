import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:teverage_motors/login/login.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:convert';
import 'credential.dart';

class Register extends StatefulWidget {
  final List list;
  final int index;
  Register({this.list,this.index});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController passcode = TextEditingController();

  bool editMode = false;


//  addUpdateData(){
//    var url = 'https://teverage.com/mobiledb/register.php';
//    http.post(url,body: {
//        'name' : name.text,
//        'phone' : phone.text,
//        'email' : email.text,
//        'passcode' : passcode.text,
//      });
//
//  }
  bool verifyButton = false;
  String verifyLink;

  Future Register() async {
    if (email.text.isNotEmpty) {
      var response = await http.post(
          'https://teverage.com/mobiledb/register.php',
          body: {
            'name': name.text,
            'phone': phone.text,
            'email': email.text,
            'passcode': passcode.text,
          });
      var link = json.decode(response.body);
      sendMail();

      setState(() {
        verifyLink = link;
        verifyButton = true;


        Fluttertoast.showToast(msg:
        "Your Registration to Teverage Motors is Successful. You can now login.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER);
      });



//      Fluttertoast.showToast(msg:
//      "Your Registration to Teverage Motors is Successful. A link has been sent to your mail for verification.",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.CENTER);
//    } else {
//      Fluttertoast.showToast(msg: "Enter Username and password first",
//          toastLength: Toast.LENGTH_LONG,
//          gravity: ToastGravity.TOP);
//    }
    }
  }

  Future verify() async {
    var response = await http.post(verifyLink);
    var link = json.decode(response.body);
    setState(() {
//      verifyLink = link;
      verifyButton = false;
    });
    print(link);
//    Fluttertoast.showToast(msg: "Thanks for verifying! you can log in now",
//        toastLength: Toast.LENGTH_LONG,
//        gravity: ToastGravity.CENTER);
  }

  sendMail() async {
    String email = EMAIL;
    String passcode = PASS;

    final smtpServer = gmail(email, passcode);
    // Creating the Gmail server

    // Create our email message.
    final message = Message()
      ..from = Address(email)
      ..recipients.add('alade5673@gmail.com') //recipent email
    //..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com']) //cc Recipents emails
    //..bccRecipients.add(Address('bccAddress@example.com')) //bcc Recipents emails
      ..subject =
          'SignUp verification link from Teverage Motors : ${DateTime
          .now()}' //subject of the email
    //..text =
    //'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h3>Thanks for registering with Teverage Motors. Please click this link to complete your registration</h3>\n<p> <a href='$verifyLink'>Click me to Verify</a></p>"; //body of the email

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' +
          sendReport.toString()); //print if the email is sent
    } on MailerException catch (e) {
      print('Message not sent. \n' +
          e.toString()); //print if the email is not sent
      // e.toString() will show why the email is not sending
    }
  }


  @override
  void initState() {
    super.initState();
//    if(widget.index != null){
//      editMode = true;
//      name.text = widget.list[widget.index]['name'];
//      phone.text = widget.list[widget.index]['phone'];
//      email.text = widget.list[widget.index]['email'];
//      passcode.text = widget.list[widget.index]['passcode'];
//    }

  }


  Future<void> OpenAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Registration Succesfull",
              style: TextStyle(color: Colors.green),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("A link has been sent to your email for verification.",
                    style: TextStyle(fontSize: 12),)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("CONTINUE", style: TextStyle(color: Colors.green),),
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Login(),),);
                },
              )
            ],
          );
        }
    );
  }


  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return Scaffold(
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
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(.9),
                      Colors.white.withOpacity(.1),
                    ])),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    'assets/edited_logo1.png',
                  ),
                  // SizedBox(
                  //   height: 50,
                  // ),
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
                    'Join Teverage Limited',
                    style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 16,
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
                                  Icons.person,
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
                          controller: name,
                          autocorrect: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Full Name',
                              focusedBorder: InputBorder.none,
                              border: InputBorder.none,
                              hintStyle: TextStyle(
                                  color: Colors.white70
                              )
                          ),
                          style: TextStyle(fontSize: 16,
                              color: Colors.white),
                        ),),
                    ],
                  ),

                  //phonenumber
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
                                  Icons.phone,
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
                            controller: phone,
                            autocorrect: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: 'Phone Number',
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

                  //Email
                  SizedBox(
                    height: 25,
                  ),
                  //TODO remove unwanted containers
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
                            controller: email,
                            autocorrect: true,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: 'Email Address',
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
                            controller: passcode,
                            autocorrect: true,
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
                    height: 25,
                  ),

                  //   Padding(padding: EdgeInsets.all(8),
                  //   child: RaisedButton(
                  //     onPressed: (){
                  //       setState(() {
                  //         addUpdateData();
                  //       });
                  //       Navigator.push(context, MaterialPageRoute(builder: (context) => Login(),),);
                  //       debugPrint('Clicked RaisedButton Button');
                  //     },
//                     color: Colors.white,
//                     child: Text(editMode ? 'Update' :'Save',style: TextStyle(color: Colors.black),),
                  //   ),
                  // ),


                  InkWell(
                    onTap: () {
                      setState(() {
//                        OpenAlert();
                        Register();
//                          verify();
//                        addUpdateData();
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>Login(),),);
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
                            'Register',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black),
                          )),
                    ),
                  ),
//                  verifyButton ? MaterialButton(
//                    color: Colors.red[400],
//                    child: Text('Verify',
//                      style: TextStyle(color: Colors.white),),
//                    onPressed: (){
//                      verify();
////                      setState(() {
////                        verifyButton = false;
////                        verify(verifylink);
////
////                      });
//                    },): Container(),

//                  SizedBox(
//                    height: 10,
//                  ),
//                  Container(
//                    height: 50,
//                    decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(50)
//                    ),
//                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                    child: Center(
//                        child: Text(
//                          "Already have an account",
//                          style: TextStyle(
//                              fontSize: 16,
//                              color: Colors.white),
//                        )),
//                  ),
//
//              InkWell(
//                onTap: () {
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => Login()),
//                  );
//                },
//                child: Container(
//                  height: 30,
//                  decoration: BoxDecoration(
//                      borderRadius: BorderRadius.circular(50)
//                  ),
//                  margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                  child: Center(
//                      child: Text(
//                        "Login",
//                        style: TextStyle(
//                            fontSize: 16,
//                            color: Colors.white,
//                            fontWeight: FontWeight.bold),
//                      )),
//                ),),


//                  SizedBox(height: 40,),
//                  newPass == 0 ? Container() : Text('Your New Password: $newPass',style: TextStyle(fontSize: 20,color: Colors.green),),
                ],),
                  ),
                  ),
                ],
                ),
              );

  }

  void showToast(String msg, {int duration, int gravity}) {
    Fluttertoast.showToast(msg: msg,);

//    Toast.show(msg, context, duration: duration, gravity: gravity);
  }
}

