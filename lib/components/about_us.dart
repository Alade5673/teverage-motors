import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:teverage_motors/components/about_us.dart';
import 'package:teverage_motors/components/account.dart';
import 'package:teverage_motors/components/coupon.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/heavy_fleet_booking.dart';
import 'package:teverage_motors/components/gps.dart';
import 'package:teverage_motors/components/partner.dart';
import 'package:teverage_motors/components/vehicle_reg.dart';
import 'package:http/http.dart' as http;
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mainlightfleet.dart';


void main() => runApp( new AboutUs());

class AboutUs extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(      theme: new ThemeData(
          primarySwatch: Colors.green,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
            ? Colors.grey[50]
              : null,
      ),
      home: new HomePage(),
        routes: <String, WidgetBuilder>{
        "/a": (BuildContext context) => mainLightFleet(),
          "/b": (BuildContext context) => HeavyFleet(),
          "/c": (BuildContext context) => Partner(),
          "/d": (BuildContext context) => Coupon(),
          "/e": (BuildContext context) => GPS(),
          "/f": (BuildContext context) => AboutUs(),
//           "/g": (BuildContext context) => FAQ("FAQ"),
        },
        debugShowCheckedModeBanner: false
    );
  }
}

class HomePage extends StatelessWidget {

  _launchURL() async {
    const url = 'https://www.google.ng/maps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _about() async {
    const url = "http://web.teverage.com/about/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _services() async {
    const url = "http://web.teverage.com/our-services/";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  _contact() async {
    const url = "http://web.teverage.com/contact/";
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

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ABOUT TEVERAGE MOTORS"),
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
//            width: 700,// Header for Drawer
//            height: size.height * 0.25,
          child: Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              Image.asset("assets/edited_logo.png",width: 150,height: 100,),
//                SizedBox(height: 10,),
//                Text("RetroPortal Studio")
            ],
          )),
        ),

        children: [           // Child Elements for Each Drawer Item
          MLMenuItem(
              leading: Icon(Icons.directions_car),
              content: Text("Light Fleet Booking",
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

      body: Stack(
        children: <Widget>[
          Image.asset(
            //TODO update this
            'assets/haulage.jpg',
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
                      Colors.black.withOpacity(.1),
                    ])),
          ),
          SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.only(bottom: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
//                  Image.asset(
//                    'assets/edited_logo2.png',
//                    ),

                  SizedBox(
                    height: 200,
                  ),
                  InkWell(
                    onTap: () {
                      _about();
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => mainHeavyFleet()),
//                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: Text(
                            'About Us',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black),
                          )),
                    ),),

                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      _services();
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => mainHeavyFleet()),
//                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: Text(
                            'Our Services',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black),
                          )),
                    ),),

                  SizedBox(
                    height: 50,
                  ),
                  InkWell(
                    onTap: () {
                      _contact();

//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => mainHeavyFleet()),
//                      );
                    },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                      child: Center(
                          child: Text(
                            'Contact',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black),
                          )),
                    ),),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
