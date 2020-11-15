import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:teverage_motors/components/haulage_document.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/heavy_fleet_booking.dart';
import 'package:teverage_motors/components/gps.dart';
import 'package:teverage_motors/components/about_us.dart';
import 'package:teverage_motors/components/mainheavyfleet.dart';
import 'package:teverage_motors/components/partner.dart';
import 'package:teverage_motors/components/vehicle_reg.dart';
import 'package:teverage_motors/components/fresh_haulage_booking.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mainlightfleet.dart';


// import 'package:file_picker/file_picker.dart';

void main() => runApp(mainAbout());

class mainAbout extends StatelessWidget {


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
          // "/d": (BuildContext context) => new Promotion("Promotion / Coupon"),
          "/e": (BuildContext context) => new GPS(),
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

  Future<File> imageFile;

  //Open gallery
  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  _launchURL() async {
    const url = 'https://www.google.ng/maps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HEAVY FLEET BOOKING'),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),

      drawer: MultiLevelDrawer(
        backgroundColor: Colors.white,
        rippleColor: Colors.white,
        subMenuBackgroundColor: Colors.grey.shade100,
        header: Container(
          height: 150,
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
              content: Text(
                "Light Fleet Booking",
              ),
              onClick: () {
//                  Navigator.of(context).pop();
                Navigator.of(context).pushNamed("/a");
              }),
          MLMenuItem(
            leading: Icon(Icons.airport_shuttle),
            content: Text("Heavy Fleet Booking"),
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
            leading: Icon(Icons.redeem),
            content: Text("Promotion/Coupons"),
            onClick: () {
              Navigator.of(context).pushNamed("/d");
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
            content: Text(""),
          ),
          MLMenuItem(
            content: Text(""),
          ),
          MLMenuItem(
            content: Text("    www.teverage.com"),
          ),
//          MLMenuItem(
//            leading: Icon(Icons.forum),
//            content: Text("Reviews & Feedback"),
//            onClick: () {
//              Navigator.of(context).pushNamed("/g");
//            },
//          ),
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
                    height: 300,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => mainHeavyFleet()),
                      );
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
                            'Start Fresh Haulage Booking',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black),
                          )),
                    ),),
//                  SizedBox(
//                    height: 50,
//                  ),
//                  InkWell(
//                    onTap: () {
//                      Navigator.push(
//                        context,
//                        MaterialPageRoute(builder: (context) => Upload()),
//                      );
////                      pickImageFromGallery(ImageSource.gallery);
//                    },
//
//                  child: Container(
//                    height: 50,
//                    decoration: BoxDecoration(
//                        color: Colors.red,
//                        borderRadius: BorderRadius.circular(10)
//                    ),
//                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//                    child: Center(
//                        child: Text(
//                          'Upload Haulage Document',
//                          style: TextStyle(
//                              fontSize: 16,
//                              color: Colors.white),
//                        )),
//                  ),),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


