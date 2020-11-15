import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teverage_motors/components/mainlightfleet.dart';
import 'package:teverage_motors/login/register.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Landing extends StatefulWidget {

  @override
  _LandingState createState() => _LandingState();
}

class _LandingState extends State<Landing> {

  @override
  void initState() {
    super.initState();

  }

//  _launchURL() async {
//    const url = "https://web.teverage.com/light-fleet-mobile-app";
//    if (await canLaunch(url)) {
//      await launch(url,forceWebView: true); //forceWebView
//    } else {
//      throw 'Could not launch $url';
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
//          Image.asset(
//            //TODO update this
//            'assets/bkg.png',
//            fit: BoxFit.fill,
//            height: double.infinity,
//            width: double.infinity,
//          ),
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
                    'Book A Trip',
                    style: TextStyle(
                      fontSize: 27.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),



                  InkWell(
                    onTap: () {
//                      _launchURL();
                      Navigator.push(
                        context,
                        // MaterialPageRoute(builder: (context) => AddEditPage()),
                        MaterialPageRoute(builder: (context) => mainLightFleet()),
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
                            "BOOK TRIP",
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
