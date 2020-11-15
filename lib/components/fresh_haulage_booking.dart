import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/heavy_fleet_booking.dart';
import 'package:teverage_motors/components/gps.dart';
import 'package:teverage_motors/components/about_us.dart';
import 'package:teverage_motors/components/vehicle_reg.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'mainlightfleet.dart';

void main() => runApp(FreshHaulageReg());

class FreshHaulageReg extends StatelessWidget {


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
          "/c": (BuildContext context) => VehicleReg(),
          // "/d": (BuildContext context) => new Promotion("Promotion / Coupon"),
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

  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController contact = TextEditingController();
//  TextEditingController time_frame = TextEditingController();
  TextEditingController departure_address= TextEditingController();
  TextEditingController destination_address= TextEditingController();
//  TextEditingController dispatch_date = TextEditingController();
  TextEditingController goods_qualification = TextEditingController();
  TextEditingController gross_weight= TextEditingController();
  TextEditingController place_use= TextEditingController();
  TextEditingController aggregrate_rate= TextEditingController();
  TextEditingController demurrage_charge= TextEditingController();
  TextEditingController specifies= TextEditingController();
//  TextEditingController fleet = TextEditingController();
//  TextEditingController terminal = TextEditingController();



  addUpdateData(){
    var url = 'https://teverage.com/mobiledb/book_haulage.php';
    http.post(url,body: {
      'name' : name.text,
      'email' : email.text,
      'phone' : phone.text,
      'address' : address.text,
      'contact' : contact.text,
//      'time_frame': time_frame.text,
      'departure_address' : departure_address.text,
      'destination_address' : destination_address.text,
//      'dispatch_date' : dispatch_date.text,
      'goods_qualification' : goods_qualification.text,
      'gross_weight' : gross_weight.text,
      'place_use' : place_use.text,
      'agreed_rate' : aggregrate_rate.text,
      'demurrage_charge' : demurrage_charge.text,
      'specifies' : specifies.text,
//      'fleet': fleet.text,
//      'terminal': terminal.fleet,

    });

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

  DateTime date = DateTime.now();

  var myFormat = DateFormat('d-MM-yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: date,
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    setState(() {
      date = picked ?? date;
    });
  }

  String _myActivity;
  String _myActivityResult;

  String _myActivity1;
  String _myActivityResult1;

  String _myActivity2;
  String _myActivityResult2;

  final formKey = new GlobalKey<FormState>();

  _launchURL() async {
    const url = 'https://www.google.ng/maps';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> OpenAlert() async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return AlertDialog(
            title: Text("Registration Succesful",style: TextStyle(color: Colors.green),),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text("We will send the document to your email soon.", style: TextStyle(fontSize: 12),)
                ],
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("CONTINUE", style: TextStyle(color: Colors.green),),
                onPressed: (){
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    var white = Colors.white;
    return Scaffold(
      appBar: AppBar(
        title: Text('FRESH HAULAGE BOOKING'),
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

      body: Stack(
        children: <Widget>[
          Image.asset(
            //TODO update this
            'assets/haulage1.jpg',
            fit: BoxFit.fill,
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
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
                  // Image.asset(
                  //   'assets/edited_logo1.png',
                  //   ),
                  // Text(
                  //   'Contact Details',
                  //   style: TextStyle(
                  //     fontSize: 27.0,
                  //     color: Colors.red,
                  //   ),
                  // ),
                  SizedBox(
                    height: 10,
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
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Customer's Name",
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
                    height: 16,
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
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "Customer's Email Address",
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
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "Customer's Phone Number",
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
                                  Icons.location_on,
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
                          controller: address,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Address",
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
                                  Icons.contacts,
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
                            controller: contact,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: "Customer's Contact",
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
                    height: 20
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    // padding: EdgeInsets.only(left: 125),
                    decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                              ),
                    child: DropDownFormField(
                        titleText: 'Time Frame',
                        hintText: 'Select Your Time Frame',
                        value: _myActivity,
                        onSaved: (value) {
                          setState(() {
                            _myActivity = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Short",
                            "value": "short",
                          },
                          {
                            "display": "Medium",
                            "value": "Medium",
                          },
                          {
                            "display": "Long",
                            "value": "Long",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
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
                                  Icons.location_on,
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
                          controller: departure_address,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Departure Address",
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
                                  Icons.location_on,
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
                          controller: destination_address,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Destination Address",
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
                    height: 16,
                  ),

                  Container(
                    width: 500,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Text("Dispatch Date", style: TextStyle(color: Colors.white54)),
                  ),
                  Container(
                    width: 400,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
//                    height: 50,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: InkWell(
                        onTap: () => _selectDate(context),
                        child: IgnorePointer(
                          child: TextField(
//                            controller: dispatch_date,
                            decoration: InputDecoration(
                              labelText: ('${myFormat.format(date)}'),
                              labelStyle: TextStyle(
                                color: Colors.white70
                              ),
                            ),
                          ),
                        ),
                      ),
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
                                  Icons.high_quality,
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
                          controller: goods_qualification,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Good(s) Qualification",
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
                                  Icons.line_weight,
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
                          controller: gross_weight,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Gross Weight",
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
                                  Icons.location_on,
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
                          controller: place_use,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Place of Use",
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
                                  Icons.rate_review,
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
                          controller: aggregrate_rate,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Aggregate Rate",
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
                                  Icons.euro_symbol,
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
                          controller: demurrage_charge,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Demurrage Charge",
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
                                  Icons.developer_board,
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
                          controller: specifies,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: "Specifies",
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
                    height: 20
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                              ),
                    child: DropDownFormField(
                        titleText: 'Choose Fleet',
                        hintText: 'Select Your Desired Fleet',
                        value: _myActivity1,
                        onSaved: (value) {
                          setState(() {
                            _myActivity1 = value;
                          });
                        },
                        onChanged: (value) {
                          setState(() {
                            _myActivity1 = value;
                          });
                        },
                        dataSource: [
                          {
                            "display": "Mack",
                            "value": "Mack",
                          },
                          {
                            "display": "Toyota",
                            "value": "Toyota",
                          },
                          {
                            "display": "Seinna",
                            "value": "Seinna",
                          },
                        ],
                        textField: 'display',
                        valueField: 'value',
                    ),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                              ),
                  child: DropDownFormField(
                    titleText: 'Choose Terminal',
                    hintText: 'Departure Terminal',
                    value: _myActivity2,
                    onSaved: (value) {
                      setState(() {
                        _myActivity2 = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity2 = value;
                      });
                    },
                    dataSource: [
                      {
                        "display": "Abia",
                        "value": "Abia",
                      },
                      {
                        "display": "Adamawa",
                        "value": "Adamawa",
                      },
                      {
                        "display": "Akwa Ibom",
                        "value": "Akwa Ibom",
                      },
                      {
                        "display": "Anambra",
                        "value": "Anambra",
                      },
                      {
                        "display": "Bauchi",
                        "value": "Bauchi",
                      },
                      {
                        "display": "Bayelsa",
                        "value": "Bayelsa",
                      },
                      {
                        "display": "Benue",
                        "value": "Benue",
                      },
                      {
                        "display": "Borno",
                        "value": "Borno",
                      },
                      {
                        "display": "Cross River",
                        "value": "Cross River",
                      },
                      {
                        "display": "Delta",
                        "value": "Delta",
                      },
                      {
                        "display": "Ebonyi",
                        "value": "Ebonyi",
                      },
                      {
                        "display": "Edo",
                        "value": "Edo",
                      },
                      {
                        "display": "Ekiti",
                        "value": "Ekiti",
                      },
                      {
                        "display": "Enugu",
                        "value": "Enugu",
                      },
                      {
                        "display": "Gombe",
                        "value": "Gombe",
                      },
                      {
                        "display": "Imo",
                        "value": "Imo",
                      },
                      {
                        "display": "Jigawa",
                        "value": "Jigawa",
                      },
                      {
                        "display": "Kaduna",
                        "value": "Kaduna",
                      },
                      {
                        "display": "Kano",
                        "value": "Kano",
                      },
                      {
                        "display": "Katsina",
                        "value": "Katsina",
                      },
                      {
                        "display": "Kebbi",
                        "value": "Kebbi",
                      },
                      {
                        "display": "Kogi",
                        "value": "Kogi",
                      },
                      {
                        "display": "Kwara",
                        "value": "Kwara",
                      },
                      {
                        "display": "Lagos",
                        "value": "Lagos",
                      },
                      {
                        "display": "Nasarawa",
                        "value": "Nasarawa",
                      },
                      {
                        "display": "Niger",
                        "value": "Niger",
                      },
                      {
                        "display": "Ogun",
                        "value": "Ogun",
                      },
                      {
                        "display": "Ondo",
                        "value": "Ondo",
                      },
                      {
                        "display": "Osun",
                        "value": "Osun",
                      },
                      {
                        "display": "Oyo",
                        "value": "Oyo",
                      },
                      {
                        "display": "Plateau",
                        "value": "Plateau",
                      },
                      {
                        "display": "Rivers",
                        "value": "Rivers",
                      },
                      {
                        "display": "Sokoto",
                        "value": "Sokoto",
                      },
                      {
                        "display": "Taraba",
                        "value": "Taraba",
                      },
                      {
                        "display": "Yobe",
                        "value": "Yobe",
                      },
                      {
                        "display": "Zamfara",
                        "value": "Zamfara",
                      },
                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),

                SizedBox(
                    height: 20,
                  ),
                  InkWell(
                     onTap: () {
                      setState(() {
                        OpenAlert();
                      addUpdateData();
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => FreshHaulageReg(),),);
                     },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                          'PROCEED TO DOCUMENT',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black),
                        )),
                  ),),
              ],
              ),

              
          ),


          ),
        ],
    ));
  }
}
//           );
//   },
//   }
// }