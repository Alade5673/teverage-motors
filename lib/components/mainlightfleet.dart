import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:teverage_motors/components/account.dart';
import 'package:teverage_motors/components/coupon.dart';
import 'package:teverage_motors/components/partner.dart';
import 'package:teverage_motors/components/vehicle_reg.dart';
import 'package:teverage_motors/login/register.dart';
import 'package:http/http.dart' as http;
import 'package:teverage_motors/payment/button_widget.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'about_us.dart';
import 'gps.dart';
import 'heavy_fleet_booking.dart';

void main() => runApp(mainLightFleet());

class mainLightFleet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.green,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[50]
              : null,
        ),
        home: new MyHomePage(),
        routes: <String, WidgetBuilder>{
          "/a": (BuildContext context) => mainLightFleet(),
          "/b": (BuildContext context) => HeavyFleet(),
          "/c": (BuildContext context) => Partner(),
          "/d": (BuildContext context) => Coupon(),
          "/e": (BuildContext context) => GPS(),
          "/f": (BuildContext context) => AboutUs(),
          // "/g": (BuildContext context) => new FAQ("FAQ"),
        },

        debugShowCheckedModeBanner: false

    );

  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final Completer<WebViewController> _controller = Completer<WebViewController>();

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 2));
  }

  _launchURL() async {
    const url = 'https://www.google.ng/maps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _website() async {
    const url = 'https://web.teverage.com';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  num position = 1 ;

  final key = UniqueKey();

  doneLoading(String A) {
    setState(() {
      position = 0;
    });
  }

  startLoading(String A) {
    setState(() {
      position = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
          title: Text('LIGHT FLEET BOOKING'),
          actions: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Account()),
                );
              }
            )
          ],
          elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
        ),
        drawer: MultiLevelDrawer(
            backgroundColor: Colors.white,
            rippleColor: Colors.white,
            subMenuBackgroundColor: Colors.grey.shade100,
            header: Container(
              height: 200,
              child: Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  SizedBox(
                    height: 10,
                  ),
                  Image.asset("assets/edited_logo.png",width: 150,height: 100,),
                ],
              ),
              ),
            ),

            children: [           // Child Elements for Each Drawer Item
              MLMenuItem(
                  leading: Icon(Icons.directions_car),
                  content: Text(
                    "Light Fleet Booking",
                  ),
                  onClick: () {
//                  Navigator.of(context).pop();
                    Navigator.of(context).pushNamed("/a");
                  }),
              MLMenuItem(
                leading: Icon(Icons.airport_shuttle),
                content: Text("Book Haulage"),
                onClick: () {
                  Navigator.of(context).pushNamed("/b");
                },
              ),
              MLMenuItem(
                leading: Icon(Icons.assignment),
                content: Text("Vehicle Registration"),
                onClick: () {
                  Navigator.of(context).pushNamed("/c");
                },
              ),
              MLMenuItem(
                  leading: Icon(Icons.location_on),
                  trailing: Icon(Icons.arrow_right),
                  content: Text(
                    "GPS Tracking",
                  ),
                  subMenuItems: [
                    MLSubmenu(onClick: () {
                      Navigator.of(context).pushNamed("/e");
                    }, submenuContent: Text("Know Where You Are")),
                    MLSubmenu(onClick: () {
                      _launchURL();
                    }, submenuContent: Text("Share Location")),
                  ],
                  onClick: () {}),
              MLMenuItem(
                leading: Icon(Icons.info),
                content: Text("About"),
                onClick: () {
                  Navigator.of(context).pushNamed("/f");
                },
              ),
              MLMenuItem(
                content: RaisedButton(
                  onPressed: () {
                    _website();
                  },
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0.0),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.green,
                    ),
                    padding: const EdgeInsets.all(20.0),
                    child:
                    const Text('Visit Our Website', style: TextStyle(fontSize: 16)),
                  ),
                ),
              ),
            ],
          ),


        resizeToAvoidBottomPadding: false,
        body: RefreshIndicator(
          onRefresh: refreshList,
          backgroundColor: Colors.white,
          color: Colors.white,
          child: IndexedStack(
            index: position,
            children: <Widget>[

          WebView(
            initialUrl: "https://web.teverage.com/light-fleet-mobile-app",
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: doneLoading,
            onPageStarted: startLoading,
            onWebViewCreated: (WebViewController webViewController){
              _controller.complete(webViewController);
            },
          ),
              Container(
                color: Colors.white,
                child: Center(
                    child: CircularProgressIndicator()),
              ),

      ],
          ),
        )

    );
  }
}