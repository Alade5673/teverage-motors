import 'dart:convert';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:teverage_motors/components/about_us.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/heavy_fleet_booking.dart';
import 'package:teverage_motors/components/gps.dart';
import 'package:teverage_motors/components/payment.dart';
import 'package:teverage_motors/components/vehicle_reg.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:teverage_motors/payment/pay.dart';
import 'package:http/http.dart' as http;
import 'package:multilevel_drawer/multilevel_drawer.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(LightFleet());

class LightFleet extends StatelessWidget {
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
        "/a": (BuildContext context) => LightFleet(),
          "/b": (BuildContext context) => HeavyFleet(),
          "/c": (BuildContext context) => VehicleReg(),
          // "/d": (BuildContext context) => new Promotion("Promotion / Coupon"),
          "/e": (BuildContext context) => GPS(),
          "/f": (BuildContext context) => AboutUs(),
//           "/g": (BuildContext context) => new FAQ("FAQ"),
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

  int _value;

  String Departure;
  String Arrival;
  String Departure1;
  String Arrival1;

  List data = List();
  
  Future getAllName() async {
    var response = await http.get("https://teverage.com/mobiledb/terminals.php",headers: {"Accept":"application/json"});
    var jsonBody = response.body;
    var jsonData = json.decode(jsonBody);

    setState(() {
      data = jsonData;
    });
    print(jsonData);
    return "success";
  }

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
    _myActivity1 = '';
    _myActivityResult1 = '';
    _myActivity2 = '';
    _myActivityResult2 = '';
    _myActivity3 = '';
    _myActivityResult3 = '';
    _myActivity4 = '';
    _myActivityResult4 = '';
    _myActivity5 = '';
    _myActivityResult5 = '';
    getAllName();
  }

  bool signin = true;

  bool processing = false;

  String _myActivity;
  String _myActivityResult;
  final formKey = new GlobalKey<FormState>();

  String _myActivity1;
  String _myActivityResult1;

  String _myActivity2;
  String _myActivityResult2;

  String _myActivity3;
  String _myActivityResult3;

  String _myActivity4;
  String _myActivityResult4;

  String _myActivity5;
  String _myActivityResult5;
  
  DateTime date = DateTime.now();
  DateTime date1 = DateTime.now();
  DateTime date2 = DateTime.now();

  TextEditingController _datecontroller = new TextEditingController();
  TextEditingController _datecontroller1 = new TextEditingController();
  TextEditingController _datecontroller2 = new TextEditingController();

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

      Future<void> _selectDate1(BuildContext context) async {
        final DateTime picked = await showDatePicker(
            context: context,
            initialDate: date1,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030));
        setState(() {
          date1 = picked ?? date1;
        });
      }

      Future<void> _selectDate2(BuildContext context) async {
        final DateTime picked = await showDatePicker(
            context: context,
            initialDate: date2,
            firstDate: DateTime(2020),
            lastDate: DateTime(2030));
        setState(() {
          date2 = picked ?? date2;
        });
      }


  _saveForm() {
    var form = formKey.currentState;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivityResult = _myActivity;
        _myActivityResult1 = _myActivity1;
        _myActivityResult2 = _myActivity2;
        _myActivityResult3 = _myActivity3;
        _myActivityResult4 = _myActivity4;
        _myActivityResult5 = _myActivity5;
      });
    }
  }


  void changeState(){
    if(signin){
      setState(() {
        signin = false;

      });
    }else
      setState(() {
      signin = true;

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

  Widget boxUi(){
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[

                FlatButton(
                  onPressed:() => changeState(),
                  child: Text('ONE WAY',
                    style: GoogleFonts.varelaRound(
                      color: signin == true ? Colors.green : Colors.grey,
                      fontSize: 16.0,fontWeight: FontWeight.bold,
                    ),),
                ),

                FlatButton(
                  onPressed:() => changeState(),
                  child: Text('ROUND TRIP',
                    style: GoogleFonts.varelaRound(
                      color: signin != true ? Colors.green : Colors.grey,
                      fontSize: 16.0,fontWeight: FontWeight.bold,
                    ),),
                ),
              ],
            ),

            signin == true ? oneWay() : roundTrip(),

          ],
        ),
      ),
    );
  }

  Widget oneWay(){
    return Column(
      children: <Widget>[
        SizedBox(
          height: 20
        ),

        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text("Full Name",
            style: TextStyle(fontSize: 12,
                color: Colors.black),),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            height: 50,
//            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                border: Border.all()),
            child: TextField(
//              controller: name,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
//                  hintText: "Full Name",
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Colors.black54
                  )
              ),
//              style: TextStyle(fontSize: 16,
//                  color: Colors.black),
            )),

        SizedBox(
          height: 20,
        ),

        Container(
          width: double.infinity,
//                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text("Choose Your Departure Terminal",
            style: TextStyle(fontSize: 12,
                color: Colors.black),),
        ),

        SizedBox(
          height: 5,
        ),

        Container(
                width: 400.0,
                  padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton(
                      value: Departure,
                      hint: Text('Departure Terminal'),
                      items: data.map((list){
                        return DropdownMenuItem(
                          child: Text(list['name']),
                          value: list['name'],);
                      },).toList(),
                        onChanged: (value){
                          setState(() {
                            Departure = value;
                          });
                        },
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),

                Container(
                  width: double.infinity,
        //                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Choose Your Arrival Terminal",
                    style: TextStyle(fontSize: 12,
                        color: Colors.black),),
                ),

                SizedBox(
                  height: 5,
                ),

                  Container(
                    width: 400.0,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        value:Arrival,
                        hint: Text('Arrival Terminal'),
                        items: data.map((list){
                          return DropdownMenuItem(
                            child: Text(list['name']),
                            value: list['name'],);
                        },).toList(),
                        onChanged: (value){
                          setState(() {
                            Arrival = value;
                          });
                        },
                      ),
                    ),
                  ),

                SizedBox(
                      height: 20,
                    ),

                Container(
                  width: double.infinity,
        //                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Select Your Departure Date",
                    style: TextStyle(fontSize: 12,
                        color: Colors.black),),
                ),

                SizedBox(
                  height: 5,
                ),

                Container(
                  width: 400,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white,
                        border: Border.all()
                              ),
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: InkWell(
                      onTap: () => _selectDate(context),
                      child: IgnorePointer(
                        child: TextField(             
                          controller: _datecontroller,
                          decoration: InputDecoration(
                            labelText: ('${myFormat.format(date)}'),
                            hintText: 'select date',
                          ),
                        ),
                      ),
                    ),
                ),
                  ),

                SizedBox(
                      height: 20,
                    ),

                Container(
                  width: double.infinity,
        //                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                  child: Text("Select Your Number of Seats",
                    style: TextStyle(fontSize: 12,
                        color: Colors.black),),
                ),

                SizedBox(
                  height: 5,
                ),

                Container(
                  width: 400.0,
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.white,
                      border: Border.all()),
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: Text('Number of Seats'),
                        value: _value,
                        items: [
                          DropdownMenuItem(
                            child: Text("1"),
                            value: 1,
                          ),
                          DropdownMenuItem(
                            child: Text("2"),
                            value: 2,
                          ),
                          DropdownMenuItem(
                              child: Text("3"),
                              value: 3
                          ),
                          DropdownMenuItem(
                              child: Text("4"),
                              value: 4
                          ),
                          DropdownMenuItem(
                              child: Text("5"),
                              value: 5
                          ),
                          DropdownMenuItem(
                              child: Text("6"),
                              value: 6
                          ),
                          DropdownMenuItem(
                              child: Text("7"),
                              value: 7
                          ),
                          DropdownMenuItem(
                              child: Text("8"),
                              value: 8
                          ),
                          DropdownMenuItem(
                              child: Text("9"),
                              value: 9
                          ),
                          DropdownMenuItem(
                              child: Text("10"),
                              value: 10
                          ),
                          DropdownMenuItem(
                              child: Text("11"),
                              value: 11
                          ),
                          DropdownMenuItem(
                              child: Text("12"),
                              value: 12
                          ),
                          DropdownMenuItem(
                              child: Text("13"),
                              value: 13
                          ),
                          DropdownMenuItem(
                              child: Text("14"),
                              value: 14
                          ),
                          DropdownMenuItem(
                              child: Text("15"),
                              value: 15
                          ),
                          DropdownMenuItem(
                              child: Text("16"),
                              value: 16
                          ),
                          DropdownMenuItem(
                              child: Text("17"),
                              value: 17
                          ),
                          DropdownMenuItem(
                              child: Text("18"),
                              value: 18
                          ),
                        ],
                          onChanged: (value) {
                            setState(() {
                              _value = value;
                            });
                          },
                      ),
                    ),
                  ),
                ),

                SizedBox(
                  height:40
                ),
                InkWell(
                      onTap: () {
                         Navigator.push(
                           context,
                           MaterialPageRoute(builder: (context) => Pay()),
                         );
                      },
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(10)
                      ),
                      margin: EdgeInsets.fromLTRB(70, 0, 70, 50),
                      child: Center(
                          child: Text(
                            'Book Now',
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white),
                          )),
                    ),
                ),

    ],
    );
  }

  Widget roundTrip(){
    return Column(
      children: <Widget>[
        SizedBox(
            height: 20
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Text("Full Name",
            style: TextStyle(fontSize: 12,
                color: Colors.black),),
        ),
        SizedBox(
          height: 5,
        ),
        Container(
            height: 50,
//            margin: EdgeInsets.fromLTRB(30, 0, 30, 0),
//            padding: EdgeInsets.fromLTRB(0, 10, 0, 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.white,
                border: Border.all()),
            child: TextField(
//              controller: name,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
//                  hintText: "Full Name",
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintStyle: TextStyle(
                      color: Colors.black54
                  )
              ),
//              style: TextStyle(fontSize: 16,
//                  color: Colors.black),
            )),

        SizedBox(
          height: 20,
        ),
          Container(
            width: double.infinity,
  //                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Text("Choose Your Departure Terminal",
              style: TextStyle(fontSize: 12,
                  color: Colors.black),),
          ),

          SizedBox(
            height: 5,
          ),
            Container(
              width: 400.0,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all()),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value: Departure1,
                  hint: Text('Departure Terminal'),
                  items: data.map((list){
                    return DropdownMenuItem(
                      child: Text(list['name']),
                      value: list['name'],);
                  },).toList(),
                  onChanged: (value){
                    setState(() {
                      Departure1 = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
    //                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text("Choose Your Arrival Terminal",
                style: TextStyle(fontSize: 12,
                    color: Colors.black),),
            ),

            SizedBox(
              height: 5,
            ),
            Container(
              width: 400.0,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all()),
              child: DropdownButtonHideUnderline(
                child: DropdownButton(
                  value:Arrival1,
                  hint: Text('Arrival Terminal'),
                  items: data.map((list){
                    return DropdownMenuItem(
                      child: Text(list['name']),
                      value: list['name'],);
                  },).toList(),
                  onChanged: (value){
                    setState(() {
                      Arrival1 = value;
                    });
                  },
                ),
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Container(
              width: double.infinity,
    //                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text("Select Your Departure Date",
                style: TextStyle(fontSize: 12,
                    color: Colors.black),),
            ),

            SizedBox(
              height: 5,
            ),
              Container(
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all()
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: InkWell(
                    onTap: () => _selectDate1(context),
                    child: IgnorePointer(
                      child: TextField(
                        controller: _datecontroller1,
                        decoration: InputDecoration(
                          labelText: ('${myFormat.format(date)}'),
                          hintText: 'select date',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

            SizedBox(
              height: 20,
            ),

              Container(
                width: double.infinity,
                //                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("Select Your Arrival Date",
                  style: TextStyle(fontSize: 12,
                      color: Colors.black),),
              ),

              SizedBox(
                height: 5,
              ),
              Container(
                width: 400,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white,
                    border: Border.all()
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: InkWell(
                    onTap: () => _selectDate2(context),
                    child: IgnorePointer(
                      child: TextField(
                        controller: _datecontroller2,
                        decoration: InputDecoration(
                          labelText: ('${myFormat.format(date)}'),
                          hintText: 'select date',
                        ),
                      ),
                    ),
                  ),
                ),
              ),

                SizedBox(
                  height: 20,
                ),

              Container(
                width: double.infinity,
                //                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text("Select Your Number of Seats",
                  style: TextStyle(fontSize: 12,
                      color: Colors.black),),
              ),

              SizedBox(
                height: 5,
              ),

            Container(
              width: 400.0,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Colors.white,
                  border: Border.all()),
              child: InkWell(
                onTap: () => _selectDate(context),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    hint: Text('Number of Seats'),
                    value: _value,
                    items: [
                      DropdownMenuItem(
                        child: Text("1"),
                        value: 1,
                      ),
                      DropdownMenuItem(
                        child: Text("2"),
                        value: 2,
                      ),
                      DropdownMenuItem(
                          child: Text("3"),
                          value: 3
                      ),
                      DropdownMenuItem(
                          child: Text("4"),
                          value: 4
                      ),
                      DropdownMenuItem(
                          child: Text("5"),
                          value: 5
                      ),
                      DropdownMenuItem(
                          child: Text("6"),
                          value: 6
                      ),
                      DropdownMenuItem(
                          child: Text("7"),
                          value: 7
                      ),
                      DropdownMenuItem(
                          child: Text("8"),
                          value: 8
                      ),
                      DropdownMenuItem(
                          child: Text("9"),
                          value: 9
                      ),
                      DropdownMenuItem(
                          child: Text("10"),
                          value: 10
                      ),
                      DropdownMenuItem(
                          child: Text("11"),
                          value: 11
                      ),
                      DropdownMenuItem(
                          child: Text("12"),
                          value: 12
                      ),
                      DropdownMenuItem(
                          child: Text("13"),
                          value: 13
                      ),
                      DropdownMenuItem(
                          child: Text("14"),
                          value: 14
                      ),
                      DropdownMenuItem(
                          child: Text("15"),
                          value: 15
                      ),
                      DropdownMenuItem(
                          child: Text("16"),
                          value: 16
                      ),
                      DropdownMenuItem(
                          child: Text("17"),
                          value: 17
                      ),
                      DropdownMenuItem(
                          child: Text("18"),
                          value: 18
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
              ),
            ),

            SizedBox(
                height:40
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Pay()),
                );
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(10)
                ),
                margin: EdgeInsets.fromLTRB(70, 0, 70, 50),
                child: Center(
                    child: Text(
                      'Book Now',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white),
                    )),
              ),
            ),

//                Container(
//                  width: double.infinity,
//                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
//                  child: Text("Select Your Departure Date", style: TextStyle(color: Colors.black45)),
//                          ),
//                Container(
//                    width: double.infinity,
//                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                    decoration: BoxDecoration(
//                              border: Border.all(color: Colors.black26),
//                              borderRadius: BorderRadius.circular(10),
//
//                              ),
//
//                    child: Padding(
//                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                    child: InkWell(
//                      onTap: () => _selectDate(context),
//                      child: IgnorePointer(
//                        child: TextField(
//                          controller: _datecontroller1,
//                          decoration: InputDecoration(
//                            labelText: ('${myFormat.format(date)}'),
//                            hintText: 'select date',
//                          ),
//                        ),
//                      ),
//                    ),
//                ),
//                  ),
//
//                  SizedBox(
//                      height: 20,
//                    ),
//                    Container(
//                      width: 500,
//                      margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
//                      child: Text("Select Your Departure Date", style: TextStyle(color: Colors.black45)),
//                    ),
//                    Container(
//                      width: 400,
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.circular(10.0),
//                          color: Colors.white,
//                          border: Border.all()
//                      ),
//                      child: Padding(
//                        padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
//                        child: InkWell(
//                          onTap: () => _selectDate(context),
//                          child: IgnorePointer(
//                            child: TextField(
//                              controller: _datecontroller,
//                              decoration: InputDecoration(
//                                labelText: ('${myFormat.format(date)}'),
//                                hintText: 'select date',
//                              ),
//                            ),
//                          ),
//                        ),
//                      ),
//                    ),
//
//                SizedBox(
//                      height: 10,
//                    ),
//
//                Container(
//                  padding: EdgeInsets.all(10),
//                  child: DropDownFormField(
//                    titleText: 'Number Of Seats',
//                    // hintText: 'Arrival Terminal',
//                    value: _myActivity5,
//                    onSaved: (value) {
//                      setState(() {
//                        _myActivity5 = value;
//                      });
//                    },
//                    onChanged: (value) {
//                      setState(() {
//                        _myActivity5 = value;
//                      });
//                    },
//                    dataSource: [
//                      {
//                        "display": "1",
//                        "value": "1",
//                      },
//                      {
//                        "display": "2",
//                        "value": "2",
//                      },
//                      {
//                        "display": "3",
//                        "value": "3",
//                      },
//                      {
//                        "display": "4",
//                        "value": "4",
//                      },
//                      {
//                        "display": "5",
//                        "value": "5",
//                      },
//                      {
//                        "display": "6",
//                        "value": "Bayelsa",
//                      },
//                      {
//                        "display": "7",
//                        "value": "7",
//                      },
//                      {
//                        "display": "8",
//                        "value": "8",
//                      },
//                      {
//                        "display": "9",
//                        "value": "9",
//                      },
//                      {
//                        "display": "10",
//                        "value": "10",
//                      },
//                      {
//                        "display": "11",
//                        "value": "11",
//                      },
//                      {
//                        "display": "12",
//                        "value": "12",
//                      },
//                      {
//                        "display": "13",
//                        "value": "13",
//                      },
//                      {
//                        "display": "14",
//                        "value": "14",
//                      },
//                      {
//                        "display": "15",
//                        "value": "15",
//                      },
//                      {
//                        "display": "16",
//                        "value": "16",
//                      },
//                      {
//                        "display": "17",
//                        "value": "17",
//                      },
//                      {
//                        "display": "18",
//                        "value": "18",
//                      },
//
//                    ],
//                    textField: 'display',
//                    valueField: 'value',
//                  ),
//                ),
//                SizedBox(
//                  height:10
//                ),
//                InkWell(
//                      onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (context) => Pay()),
//                         );
//                      },
//                    child: Container(
//                      height: 50,
//                      decoration: BoxDecoration(
//                          color: Colors.green,
//                          borderRadius: BorderRadius.circular(10)
//                      ),
//                      margin: EdgeInsets.fromLTRB(70, 0, 70, 50),
//                      child: Center(
//                          child: Text(
//                            'Book Now',
//                            style: TextStyle(
//                                fontSize: 16,
//                                color: Colors.white),
//                          )),
//                    ),
//                ),
      ],
    );
  }




  @override
  Widget build(BuildContext context) {
//    Size size = MediaQuery.of(context).size;
    return Scaffold(
        drawer:MultiLevelDrawer(
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



       appBar: AppBar(
        title: Text('LIGHT FLEET BOOKING'),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
      ),




//      drawer: new Drawer(
//        child: new ListView(
//          children: <Widget>[
//            new UserAccountsDrawerHeader(
//              accountName: new Text("Falana Oluwaseun"),
//              accountEmail: new Text("alade5673@gmail.com"),
//              currentAccountPicture: new CircleAvatar(
//                backgroundColor:
//                  Theme.of(context).platform == TargetPlatform.iOS
//                      ? Colors.deepPurple
//                      : Colors.black,
//                child: new Text("F"),
//              )
//            ),
//            Divider(),
//            new ListTile(
//              title: new Text("Light Fleet Booking"),
//              trailing: new Icon(Icons.directions_car),
//              onTap: () {
//                 Navigator.of(context).pushNamed("/a");
//               }
//            ),
//            new ListTile(
//              title: new Text("Heavy Fleet Booking"),
//              trailing: new Icon(Icons.directions_bus),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushNamed("/b");
//               }
//            ),
//            new ListTile(
//              title: new Text("Vehicle Registration"),
//              trailing: new Icon(Icons.airport_shuttle),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushNamed("/c");
//               }
//            ),
//            new ListTile(
//              title: new Text("Promotion/Coupons"),
//              // trailing: new Icon(Icons.lock_outline),
////                onTap: () {
////                  Navigator.of(context).pop();
////                  Navigator.of(context).pushNamed("/d");
////                }
//            ),
//            new ListTile(
//              title: new Text("GPS Tracking"),
//              trailing: new Icon(Icons.location_on),
//               onTap: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pushNamed("/e");
//               }
//            ),
//            new ListTile(
//              title: new Text("About Us"),
//              onTap: () {
//                 Navigator.of(context).pushNamed("/f");
//               }
//            ),
//            new ListTile(
//              title: new Text("FAQ"),
//              // trailing: new Icon(Icons.bookmark),
//            ),
//          //   Divider(),
//          //   new ListTile(
//          //     title: new Text("Close"),
//          //     // trailing: new Icon(Icons.close,),
//          //     onTap: () => Navigator.of(context).pop(),
//          // ),
//        ],
//      ),
//      ),

       body: SingleChildScrollView(
              child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                boxUi(),
              ]
            )
          )
        )
       )

       
    );
  }
}

class DateTimePickerFormField {
}
