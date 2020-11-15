import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/heavy_fleet_booking.dart';
import 'package:teverage_motors/components/gps.dart';
import 'package:teverage_motors/components/about_us.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

import 'datePicker.dart';
import 'mainlightfleet.dart';
// import 'package:file_picker/file_picker.dart';


void main() => runApp(VehicleReg());

class VehicleReg extends StatelessWidget {


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

  String dropdownValue = 'Owner';
  String staff_type = '';

  List <String> staffType = [
    'Owner',
  ] ;

  String dropdownValue1 = 'Voter Card';
  String id_type = '';

  List <String> idType = [
    'Voter Card',
    'Driver License',
    'National ID Card',
    'International Passport',
  ] ;

  void getDropDownItem(){

    setState(() {
      staff_type = dropdownValue;
      id_type = dropdownValue1;
      Terminal = getTerminal;
    });
  }

  TextEditingController fname = TextEditingController();
  TextEditingController lname = TextEditingController();
  TextEditingController dob = TextEditingController();
  TextEditingController photo = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController id_number= TextEditingController();

  addUpdateData(){
    var url = 'https://teverage.com/mobiledb/vehicle_reg.php';
    http.post(url,body: {
      'fname' : fname.text,
      'lname' : lname.text,
//      'dob' : dob.text,
//      'photo' : photo.text,
      'phone' : phone.text,
      'email' : email.text,
      'id_number' : id_number.text,
      'staff_type' : staff_type,
      'id_type' : id_type,
      'terminal' : Terminal,
//      'dob': dob,

    });

  }

  int _value;
//  String staff;

  String Terminal;
  String getTerminal;

  List data = List();

  Future getAllTerminals() async {
    var response = await http.get("https://teverage.com/mobiledb/terminals.php",headers: {"Accept":"application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
    });
//    print(jsonData);
    return "success";
  }

  String _myActivity;
  String _myActivityResult;


  final formKey = new GlobalKey<FormState>();

//  final String valueText;
//  _MyHomePageState(
//      {Key key,
//
//        this.valueText,
//      });
//      : super(key: key);

//  var dob;
  String realDate,labelText;
  DateTime date = DateTime.now();
//  DateTime date = DateFormat.yMd().format(DateTime.now())
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);

      var myFormat = DateFormat('d-MM-yyyy');

      Future<void> _selectDate(BuildContext context) async {
          final DateTime picked = await showDatePicker(
              context: context,
              initialDate: date,
              firstDate: DateTime(1940),
              lastDate: DateTime(2030));

          if (picked != null && picked != date) {
            setState(() {
              date = picked;
              realDate = new DateFormat.yMd().format(date);
//              dob = date;
//              print(dob);
            });
          } else {}
      }
//          setState(() {
//            date = picked ?? date;
//          });
//        }

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    getAllTerminals();
  }

  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
      });
    }
  }

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
                    Text("We have received your application, we will get back to you soon.", style: TextStyle(fontSize: 12),)
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
    return Scaffold(
      appBar: AppBar(
        title: Text('VEHICLE REGISTRATION'),
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
//          Image.asset(
//            //TODO update this
//            'assets/car.png',
//            fit: BoxFit.fill,
//            height: double.infinity,
//            width: double.infinity,
//          ),
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(.5),
                      Colors.black.withOpacity(.5),
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
                    height: 40,
                  ),
                  Text(
                    //TODO update this
                    'Work With Us',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.green,
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
                          controller: fname,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'First Name',
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
                          controller: lname,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Last Name',
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
                  width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text("Date of Birth",
                            style: TextStyle(fontSize: 12,
                                color: Colors.white),),),
                  Container(
                    child: DateDropDown(
                      labelText: labelText,
                      valueText: new DateFormat.yMd().format(date),
                      valueStyle: valueStyle,
                      onPressed: () {
                        _selectDate(context);
                      },
                    ),
                  ),

//                  Container(
//                    width: double.infinity,
//                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                    decoration: BoxDecoration(
//                              border: Border.all(color: Colors.white),
//                              borderRadius: BorderRadius.circular(10),
//                              ),
//                    child: Padding(
//                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                    child: InkWell(
//                      onTap: () => _selectDate(context),
//                      child: IgnorePointer(
//                        child: TextField(
////                          valueText: realDate,
////                          controller: dob,
//                          decoration: InputDecoration(
//                            // labelText: 'Select Date',
////                            hintText: ('${myFormat.format(date)}'),
//                            hintText: ('${myFormat.format(date).toString()}'),
//                            hintStyle: TextStyle(color: Colors.white70),
//                          ),
//                        ),
//                      ),
//                    ),
//                ),
//                  ),

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

//                  Padding(
//                      padding: EdgeInsets.only(top: 30, bottom: 30),
//                      child :
//                      //Printing Item on Text Widget
//                      Text('Selected Item = ' + '$Terminal',
//                          style: TextStyle
//                            (fontSize: 22,
//                              color: Colors.black))),

                  SizedBox(
                    height: 16
                  ),

                  Container(
                    width: double.infinity,
//                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text("Staff Type",
                      style: TextStyle(fontSize: 12,
                          color: Colors.white),),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    width: double.infinity,
                    height: 70,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValue,
//                          hint: Text('Staff Type', style: TextStyle(
//                              color: Colors.white70
//                          ),),
                          onChanged: (String data) {
                            setState(() {
                              dropdownValue = data;
                            });
                          },
                          items: staffType.map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onTap: () => getDropDownItem(),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                  height: 16.0
                ),

                  Container(
                    width: double.infinity,
//                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text("Choose Your Desired Operational Terminal",
                      style: TextStyle(fontSize: 12,
                          color: Colors.white),),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    width: double.infinity,
                    height: 70,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value: getTerminal,
                        items: data.map((list){
                          return DropdownMenuItem(
                            child: Text(list['name']),
                            value: list['name'],);
                        },).toList(),
                        onChanged: (value){
                          setState(() {
                            getTerminal = value;
                          });
                        },
                        onTap: () => getDropDownItem(),
                      ),
                    ),
                  ),

                SizedBox(
                  height: 16.0
                ),

                  Container(
                    width: double.infinity,
//                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text("Identity Card Type",
                      style: TextStyle(fontSize: 12,
                          color: Colors.white),),
                  ),

                  SizedBox(
                    height: 5,
                  ),

                  Container(
                    height: 70,
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: InkWell(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: dropdownValue1,
                          hint: Text('Choose Your Identity Card Type', style: TextStyle(
                              color: Colors.white70
                          ),),
                          onChanged: (String data) {
                            setState(() {
                              dropdownValue1 = data;
                            });
                          },
                          items: idType.map<DropdownMenuItem<String>>((String value1) {
                            return DropdownMenuItem<String>(
                              value: value1,
                              child: Text(value1),
                            );
                          }).toList(),
                          onTap: () => getDropDownItem(),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 16
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
                          )),
                      Container(
                          height: 50,
                          margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                          padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: TextField(
                            controller: id_number,
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                                hintText: 'Identity Card Number',
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
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        OpenAlert();
                        addUpdateData();
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleReg(),),);
                    },
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: Center(
                        child: Text(
                          'JOIN US NOW',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white),
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