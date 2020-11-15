import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:math';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:teverage_motors/components/about_us.dart';
import 'package:teverage_motors/components/account.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/heavy_fleet_booking.dart';
import 'package:teverage_motors/components/partner.dart';
import 'package:teverage_motors/components/vehicle_reg.dart';
import 'package:location/location.dart';

import 'mainlightfleet.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: GPS(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        "/a": (BuildContext context) => mainLightFleet(),
          "/b": (BuildContext context) => HeavyFleet(),
          "/c": (BuildContext context) => Partner(),
          // "/d": (BuildContext context) => Promotion("Promotion / Coupon"),
          "/e": (BuildContext context) => GPS(),
          "/f": (BuildContext context) => AboutUs(),
          // "/g": (BuildContext context) => FAQ("FAQ"),
        },
        debugShowCheckedModeBanner: false
    );
  }
}

class GPS extends StatefulWidget {
  GPS({Key key, this.title}) : super(key: key);


  final String title;

  @override
  _GPSState createState() => _GPSState();
}

class _GPSState extends State<GPS> {

  LatLng _initialPosition = LatLng(9.077751, 8.6774567);
  GoogleMapController _controller;
  Location _location = Location();

  void _onMapCreated(GoogleMapController _cntrl) async {
    _controller = await _cntrl;

    _location.onLocationChanged.listen((l){
      _controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(l.latitude,l.longitude), zoom: 20)
      ));
    });
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => mainLightFleet(),),),
        ),
        title: Text("YOUR LOCATION"),
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
      ),
      body: Stack(
          children: <Widget>[
            GoogleMap(initialCameraPosition: CameraPosition(target: _initialPosition, zoom: 10),
            mapType: MapType.normal,
            onMapCreated: _onMapCreated,
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            zoomControlsEnabled: false,
            )
          ],
      ),

      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: new Text("Falana Oluwaseun"),
              accountEmail: new Text("alade5673@gmail.com"),
              currentAccountPicture: new CircleAvatar(
                backgroundColor:
                  Theme.of(context).platform == TargetPlatform.iOS
                      ? Colors.deepPurple
                      : Colors.black,
                child: new Text("F"),
              )
            ),
            Divider(),
            new ListTile(
              title: new Text("Light Fleet Booking"),
              trailing: new Icon(Icons.directions_car),
              onTap: () {
                 Navigator.of(context).pushNamed("/a");
               }
            ),
            new ListTile(
              title: new Text("Book Haulage"),
              trailing: new Icon(Icons.directions_bus),
               onTap: () {
                 Navigator.of(context).pop();
                 Navigator.of(context).pushNamed("/b");
               }
            ),
            new ListTile(
              title: new Text("Vehicle Registration"),
              trailing: new Icon(Icons.airport_shuttle),
               onTap: () {
                 Navigator.of(context).pop();
                 Navigator.of(context).pushNamed("/c");
               }
            ),
            new ListTile(
              title: new Text("GPS Tracking"),
              trailing: new Icon(Icons.location_on),
               onTap: () {
                 Navigator.of(context).pop();
                 Navigator.of(context).pushNamed("/e");
               }
            ),
            new ListTile(
              title: new Text("About"),
              onTap: () {
                 Navigator.of(context).pushNamed("/f");
               }
            ),
//            new ListTile(
//              title: new Text("Reviews & Feedback"),
//              // trailing: new Icon(Icons.bookmark),
//            ),
          //   Divider(),
          //   new ListTile(
          //     title: new Text("Close"),
          //     // trailing: new Icon(Icons.close,),
          //     onTap: () => Navigator.of(context).pop(),
          // ),
        ],
      ),
      ),
    );
  }
}
