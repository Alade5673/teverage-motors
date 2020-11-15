import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/heavy_fleet_booking.dart';
import 'package:teverage_motors/components/gps.dart';
import 'package:teverage_motors/components/about_us.dart';
import 'package:teverage_motors/components/vehicle_reg.dart';
import 'package:teverage_motors/components/fresh_haulage_booking.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mainlightfleet.dart';

void main() => runApp(Upload());

class Upload extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        theme: new ThemeData(
          primarySwatch: Colors.green,
          primaryColor: defaultTargetPlatform == TargetPlatform.iOS
              ? Colors.grey[50]
              : null,
        ),
        home: new Upload(),
        routes: <String, WidgetBuilder>{
          "/a": (BuildContext context) => mainLightFleet(),
          "/b": (BuildContext context) => HeavyFleet(),
          "/c": (BuildContext context) => VehicleReg(),
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

  final String phpEndPoint = 'http://192.168.43.171/phpAPI/image.php';
  File file;

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.camera);
// file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _upload() {
    if (file == null) return;
    String base64Image = base64Encode(file.readAsBytesSync());
    String fileName = file.path.split("/").last;

    http.post(phpEndPoint, body: {
      "image": base64Image,
      "name": fileName,
    }).then((res) {
      print(res.statusCode);
    }).catchError((err) {
      print(err);
    });
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
            mainAxisAlignment: MainAxisAlignment.center,
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
            content: Text("About Us"),
            onClick: () {
              Navigator.of(context).pushNamed("/f");
            },
          ),
          MLMenuItem(
            leading: Icon(Icons.forum),
            content: Text("FAQ"),
            onClick: () {
              Navigator.of(context).pushNamed("/g");
            },
          ),
        ],
      ),

      body: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: _choose,
                child: Text('Choose Image'),
              ),
              SizedBox(width: 10.0),
              RaisedButton(
                onPressed: _upload,
                child: Text('Upload Image'),
              )
            ],
          ),
          file == null
              ? Text('No Image Selected')
              : Image.file(file)
        ],
      ),
    );
  }

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

  }

