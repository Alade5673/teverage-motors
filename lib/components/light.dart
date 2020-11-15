import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter/material.dart';
import 'package:teverage_motors/components/about_us.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'package:teverage_motors/components/heavy_fleet_booking.dart';
import 'package:teverage_motors/components/gps.dart';
import 'package:teverage_motors/components/vehicle_reg.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
// import 'package:date_field/date_field.dart';
// import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:datetime_picker_formfield/time_picker_formfield.dart';

// const appName = 'DateTimePickerFormField Example';

void main() => runApp(Light());

class Light extends StatelessWidget {
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

  // DateTime _dateTime = DateTime.now();

  // Future<Null> selectDate(BuildContext context) async {
  //   DateTime _datePicker = await showDatePicker(
  //     context: context,
  //     initialDate: _dateTime,
  //     firstDate: DateTime(2020),
  //     lastDate: DateTime(2030),
  //   );

  //   if (_datePicker != null && _datePicker != _dateTime){
  //     setState(() {
  //       _dateTime = _datePicker;
  //     });
  //   }
  // }
  
  DateTime date = DateTime.now();

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

  @override
  void initState() {
    super.initState();
    _myActivity = '';
    _myActivityResult = '';
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

  @override
  void init1State() {
    super.initState();
    _myActivity1 = '';
    _myActivityResult1 = '';
  }

  _saveForm1() {
    var form1 = formKey.currentState;
    if (form1.validate()) {
      form1.save();
      setState(() {
        _myActivityResult1 = _myActivity1;
      });
    }
  }

  @override
  void init2State() {
    super.initState();
    _myActivity2 = '';
    _myActivityResult2 = '';
  }

  _saveForm2() {
    var form2 = formKey.currentState;
    if (form2.validate()) {
      form2.save();
      setState(() {
        _myActivityResult2 = _myActivity2;
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

            signin == true ? signInUi() : signUpUi(),

          ],
        ),
      ),
    );
  }

  Widget signInUi(){
    return Column(
      children: <Widget>[

        Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Travelling From',
                    hintText: 'Departure Terminal',
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
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Travelling To',
                    hintText: 'Arrival Terminal',
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
                      height: 10,
                    ),
                Container(
                  width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text("Select Your Departure Date", style: TextStyle(color: Colors.black45)),
                          ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10),
                            
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
                      height: 10,
                    ),
                    
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Number Of Seats',
                    // hintText: 'Arrival Terminal',
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
                        "display": "1",
                        "value": "1",
                      },
                      {
                        "display": "2",
                        "value": "2",
                      },
                      {
                        "display": "3",
                        "value": "3",
                      },
                      {
                        "display": "4",
                        "value": "4",
                      },
                      {
                        "display": "5",
                        "value": "5",
                      },
                      {
                        "display": "6",
                        "value": "Bayelsa",
                      },
                      {
                        "display": "7",
                        "value": "7",
                      },
                      {
                        "display": "8",
                        "value": "8",
                      },
                      {
                        "display": "9",
                        "value": "9",
                      },
                      {
                        "display": "10",
                        "value": "10",
                      },
                      {
                        "display": "11",
                        "value": "11",
                      },
                      {
                        "display": "12",
                        "value": "12",
                      },
                      {
                        "display": "13",
                        "value": "13",
                      },
                      {
                        "display": "14",
                        "value": "14",
                      },
                      {
                        "display": "15",
                        "value": "15",
                      },
                      {
                        "display": "16",
                        "value": "16",
                      },
                      {
                        "display": "17",
                        "value": "17",
                      },
                      {
                        "display": "18",
                        "value": "18",
                      },
                      
                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                SizedBox(
                  height:10
                ),
                InkWell(
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => Register()),
                      //   );
                      // },
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





        // TextField(
        //   // controller: emailctrl,
        //   decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
        //   hintText: 'email'),
        // ),


        // TextField(
        //   // controller: passctrl,
        //   decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
        //       hintText: 'pass'),
        // ),

        // SizedBox(height: 10.0,),

        // MaterialButton(
        //   // onPressed:() => userSignIn(),
        //   child: processing == false ? Text('Sign In',
        //     style: GoogleFonts.varelaRound(fontSize: 18.0,
        //         color: Colors.green),) : CircularProgressIndicator(backgroundColor: Colors.red,)
        // ),

    ],
    );
  }

  Widget signUpUi(){
    return Column(
      children: <Widget>[

        Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Travelling From',
                    hintText: 'Departure Terminal',
                    value: _myActivity3,
                    onSaved: (value) {
                      setState(() {
                        _myActivity3 = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity3 = value;
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
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Travelling To',
                    hintText: 'Arrival Terminal',
                    value: _myActivity4,
                    onSaved: (value) {
                      setState(() {
                        _myActivity4 = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity4 = value;
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
                      height: 10,
                    ),
                Container(
                  width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text("Select Your Departure Date", style: TextStyle(color: Colors.black45)),
                          ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10),
                            
                              ), 
                    
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: InkWell(
                      onTap: () => _selectDate(context),
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
                      height: 10,
                    ),
                 Container(
                  width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Text("Select Your Return Date", style: TextStyle(color: Colors.black45)),
                          ),
                Container(
                    width: double.infinity,
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                              border: Border.all(color: Colors.black26),
                              borderRadius: BorderRadius.circular(10),
                            
                              ), 
                    
                    child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: InkWell(
                      onTap: () => _selectDate(context),
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
                      height: 10,
                    ),
                    
                Container(
                  padding: EdgeInsets.all(10),
                  child: DropDownFormField(
                    titleText: 'Number Of Seats',
                    // hintText: 'Arrival Terminal',
                    value: _myActivity5,
                    onSaved: (value) {
                      setState(() {
                        _myActivity5 = value;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _myActivity5 = value;
                      });
                    },
                    dataSource: [
                      {
                        "display": "1",
                        "value": "1",
                      },
                      {
                        "display": "2",
                        "value": "2",
                      },
                      {
                        "display": "3",
                        "value": "3",
                      },
                      {
                        "display": "4",
                        "value": "4",
                      },
                      {
                        "display": "5",
                        "value": "5",
                      },
                      {
                        "display": "6",
                        "value": "Bayelsa",
                      },
                      {
                        "display": "7",
                        "value": "7",
                      },
                      {
                        "display": "8",
                        "value": "8",
                      },
                      {
                        "display": "9",
                        "value": "9",
                      },
                      {
                        "display": "10",
                        "value": "10",
                      },
                      {
                        "display": "11",
                        "value": "11",
                      },
                      {
                        "display": "12",
                        "value": "12",
                      },
                      {
                        "display": "13",
                        "value": "13",
                      },
                      {
                        "display": "14",
                        "value": "14",
                      },
                      {
                        "display": "15",
                        "value": "15",
                      },
                      {
                        "display": "16",
                        "value": "16",
                      },
                      {
                        "display": "17",
                        "value": "17",
                      },
                      {
                        "display": "18",
                        "value": "18",
                      },
                      
                    ],
                    textField: 'display',
                    valueField: 'value',
                  ),
                ),
                SizedBox(
                  height:10
                ),
                InkWell(
                      // onTap: () {
                      //   Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => Register()),
                      //   );
                      // },
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


        // TextField(
        //   // controller: namectrl,
        //   decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
        //       hintText: 'name'),
        // ),

        // TextField(
        //   // controller: emailctrl,
        //   decoration: InputDecoration(prefixIcon: Icon(Icons.account_box,),
        //       hintText: 'email'),
        // ),


        // TextField(
        //   // controller: passctrl,
        //   decoration: InputDecoration(prefixIcon: Icon(Icons.lock,),
        //       hintText: 'pass'),
        // ),

        // SizedBox(height: 10.0,),

        // MaterialButton(
        //   // onPressed:() => registerUser(),
        //   child: processing == false ? Text('Sign Up',
        //     style: GoogleFonts.varelaRound(fontSize: 18.0,
        //         color: Colors.green),) : CircularProgressIndicator(backgroundColor: Colors.red)
        // ),

      ],
    );
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('LIGHT FLEET BOOKING'),
        elevation: defaultTargetPlatform == TargetPlatform.android ? 5.0 : 0.0,
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
              title: new Text("Heavy Fleet Booking"),
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
              title: new Text("Promotion/Coupons"),
              // trailing: new Icon(Icons.lock_outline),
//                onTap: () {
//                  Navigator.of(context).pop();
//                  Navigator.of(context).pushNamed("/d");
//                }
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
              title: new Text("About Us"),
              onTap: () {
                 Navigator.of(context).pushNamed("/f");
               }
            ),
            new ListTile(
              title: new Text("FAQ"),
              // trailing: new Icon(Icons.bookmark),
            ),
          //   Divider(),
          //   new ListTile(
          //     title: new Text("Close"),
          //     // trailing: new Icon(Icons.close,),
          //     onTap: () => Navigator.of(context).pop(),
          // ),
        ],
      ),
      ),

       body: SingleChildScrollView(
              child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // Image.asset(
                //     'assets/edited_logo.png',
                //     height: 50,
                //     ),
                // SizedBox(
                //   height: 20.0
                // ),
                boxUi(),
              ]
            )
          )
        )
       )

        // child: Column(
        //   children: <Widget>[
        //     boxUi(),
        //   ]
          
        // ),
      
     
      
      // body: SingleChildScrollView(
      //         child: Center(
      //     child: Form(
      //       key: formKey,
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.start,
      //         children: <Widget>[
      //           Image.asset(
      //               'assets/edited_logo.png',
      //               height: 70,
      //               ),
      //           SizedBox(
      //             height: 20.0
      //           ),
                // Container(
                //   padding: EdgeInsets.all(10),
                //   child: DropDownFormField(
                //     titleText: 'Travelling From',
                //     hintText: 'Departure Terminal',
                //     value: _myActivity,
                //     onSaved: (value) {
                //       setState(() {
                //         _myActivity = value;
                //       });
                //     },
                //     onChanged: (value) {
                //       setState(() {
                //         _myActivity = value;
                //       });
                //     },
                //     dataSource: [
                //       {
                //         "display": "Abia",
                //         "value": "Abia",
                //       },
                //       {
                //         "display": "Adamawa",
                //         "value": "Adamawa",
                //       },
                //       {
                //         "display": "Akwa Ibom",
                //         "value": "Akwa Ibom",
                //       },
                //       {
                //         "display": "Anambra",
                //         "value": "Anambra",
                //       },
                //       {
                //         "display": "Bauchi",
                //         "value": "Bauchi",
                //       },
                //       {
                //         "display": "Bayelsa",
                //         "value": "Bayelsa",
                //       },
                //       {
                //         "display": "Benue",
                //         "value": "Benue",
                //       },
                //       {
                //         "display": "Borno",
                //         "value": "Borno",
                //       },
                //       {
                //         "display": "Cross River",
                //         "value": "Cross River",
                //       },
                //       {
                //         "display": "Delta",
                //         "value": "Delta",
                //       },
                //       {
                //         "display": "Ebonyi",
                //         "value": "Ebonyi",
                //       },
                //       {
                //         "display": "Edo",
                //         "value": "Edo",
                //       },
                //       {
                //         "display": "Ekiti",
                //         "value": "Ekiti",
                //       },
                //       {
                //         "display": "Enugu",
                //         "value": "Enugu",
                //       },
                //       {
                //         "display": "Gombe",
                //         "value": "Gombe",
                //       },
                //       {
                //         "display": "Imo",
                //         "value": "Imo",
                //       },
                //       {
                //         "display": "Jigawa",
                //         "value": "Jigawa",
                //       },
                //       {
                //         "display": "Kaduna",
                //         "value": "Kaduna",
                //       },
                //       {
                //         "display": "Kano",
                //         "value": "Kano",
                //       },
                //       {
                //         "display": "Katsina",
                //         "value": "Katsina",
                //       },
                //       {
                //         "display": "Kebbi",
                //         "value": "Kebbi",
                //       },
                //       {
                //         "display": "Kogi",
                //         "value": "Kogi",
                //       },
                //       {
                //         "display": "Kwara",
                //         "value": "Kwara",
                //       },
                //       {
                //         "display": "Lagos",
                //         "value": "Lagos",
                //       },
                //       {
                //         "display": "Nasarawa",
                //         "value": "Nasarawa",
                //       },
                //       {
                //         "display": "Niger",
                //         "value": "Niger",
                //       },
                //       {
                //         "display": "Ogun",
                //         "value": "Ogun",
                //       },
                //       {
                //         "display": "Ondo",
                //         "value": "Ondo",
                //       },
                //       {
                //         "display": "Osun",
                //         "value": "Osun",
                //       },
                //       {
                //         "display": "Oyo",
                //         "value": "Oyo",
                //       },
                //       {
                //         "display": "Plateau",
                //         "value": "Plateau",
                //       },
                //       {
                //         "display": "Rivers",
                //         "value": "Rivers",
                //       },
                //       {
                //         "display": "Sokoto",
                //         "value": "Sokoto",
                //       },
                //       {
                //         "display": "Taraba",
                //         "value": "Taraba",
                //       },
                //       {
                //         "display": "Yobe",
                //         "value": "Yobe",
                //       },
                //       {
                //         "display": "Zamfara",
                //         "value": "Zamfara",
                //       },
                //     ],
                //     textField: 'display',
                //     valueField: 'value',
                //   ),
                // ),
                // SizedBox(
                //   height: 10,
                // ),
                // Container(
                //   padding: EdgeInsets.all(10),
                //   child: DropDownFormField(
                //     titleText: 'Travelling To',
                //     hintText: 'Arrival Terminal',
                //     value: _myActivity1,
                //     onSaved: (value) {
                //       setState(() {
                //         _myActivity1 = value;
                //       });
                //     },
                //     onChanged: (value) {
                //       setState(() {
                //         _myActivity1 = value;
                //       });
                //     },
                //     dataSource: [
                //       {
                //         "display": "Abia",
                //         "value": "Abia",
                //       },
                //       {
                //         "display": "Adamawa",
                //         "value": "Adamawa",
                //       },
                //       {
                //         "display": "Akwa Ibom",
                //         "value": "Akwa Ibom",
                //       },
                //       {
                //         "display": "Anambra",
                //         "value": "Anambra",
                //       },
                //       {
                //         "display": "Bauchi",
                //         "value": "Bauchi",
                //       },
                //       {
                //         "display": "Bayelsa",
                //         "value": "Bayelsa",
                //       },
                //       {
                //         "display": "Benue",
                //         "value": "Benue",
                //       },
                //       {
                //         "display": "Borno",
                //         "value": "Borno",
                //       },
                //       {
                //         "display": "Cross River",
                //         "value": "Cross River",
                //       },
                //       {
                //         "display": "Delta",
                //         "value": "Delta",
                //       },
                //       {
                //         "display": "Ebonyi",
                //         "value": "Ebonyi",
                //       },
                //       {
                //         "display": "Edo",
                //         "value": "Edo",
                //       },
                //       {
                //         "display": "Ekiti",
                //         "value": "Ekiti",
                //       },
                //       {
                //         "display": "Enugu",
                //         "value": "Enugu",
                //       },
                //       {
                //         "display": "Gombe",
                //         "value": "Gombe",
                //       },
                //       {
                //         "display": "Imo",
                //         "value": "Imo",
                //       },
                //       {
                //         "display": "Jigawa",
                //         "value": "Jigawa",
                //       },
                //       {
                //         "display": "Kaduna",
                //         "value": "Kaduna",
                //       },
                //       {
                //         "display": "Kano",
                //         "value": "Kano",
                //       },
                //       {
                //         "display": "Katsina",
                //         "value": "Katsina",
                //       },
                //       {
                //         "display": "Kebbi",
                //         "value": "Kebbi",
                //       },
                //       {
                //         "display": "Kogi",
                //         "value": "Kogi",
                //       },
                //       {
                //         "display": "Kwara",
                //         "value": "Kwara",
                //       },
                //       {
                //         "display": "Lagos",
                //         "value": "Lagos",
                //       },
                //       {
                //         "display": "Nasarawa",
                //         "value": "Nasarawa",
                //       },
                //       {
                //         "display": "Niger",
                //         "value": "Niger",
                //       },
                //       {
                //         "display": "Ogun",
                //         "value": "Ogun",
                //       },
                //       {
                //         "display": "Ondo",
                //         "value": "Ondo",
                //       },
                //       {
                //         "display": "Osun",
                //         "value": "Osun",
                //       },
                //       {
                //         "display": "Oyo",
                //         "value": "Oyo",
                //       },
                //       {
                //         "display": "Plateau",
                //         "value": "Plateau",
                //       },
                //       {
                //         "display": "Rivers",
                //         "value": "Rivers",
                //       },
                //       {
                //         "display": "Sokoto",
                //         "value": "Sokoto",
                //       },
                //       {
                //         "display": "Taraba",
                //         "value": "Taraba",
                //       },
                //       {
                //         "display": "Yobe",
                //         "value": "Yobe",
                //       },
                //       {
                //         "display": "Zamfara",
                //         "value": "Zamfara",
                //       },
                //     ],
                //     textField: 'display',
                //     valueField: 'value',
                //   ),
                // ),

                // SizedBox(
                //       height: 10,
                //     ),
                // Container(
                //   width: double.infinity,
                //     margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
                //   child: Text("Select Your Departure Date", style: TextStyle(color: Colors.black45)),
                //           ),
                // Container(
                //     width: double.infinity,
                //     margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //     decoration: BoxDecoration(
                //               border: Border.all(color: Colors.black26),
                //               borderRadius: BorderRadius.circular(10),
                            
                //               ), 
                    
                //     child: Padding(
                //     padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                //     child: InkWell(
                //       onTap: () => _selectDate(context),
                //       child: IgnorePointer(
                //         child: TextField(             
                //           controller: _datecontroller,
                //           decoration: InputDecoration(
                //             labelText: ('${myFormat.format(date)}'),
                //             hintText: 'select date',
                //           ),
                //         ),
                //       ),
                //     ),
                // ),
                //   ),

                // SizedBox(
                //       height: 10,
                //     ),
                    
                // Container(
                //   padding: EdgeInsets.all(10),
                //   child: DropDownFormField(
                //     titleText: 'Number Of Seats',
                //     // hintText: 'Arrival Terminal',
                //     value: _myActivity2,
                //     onSaved: (value) {
                //       setState(() {
                //         _myActivity2 = value;
                //       });
                //     },
                //     onChanged: (value) {
                //       setState(() {
                //         _myActivity2 = value;
                //       });
                //     },
                //     dataSource: [
                //       {
                //         "display": "1",
                //         "value": "1",
                //       },
                //       {
                //         "display": "2",
                //         "value": "2",
                //       },
                //       {
                //         "display": "3",
                //         "value": "3",
                //       },
                //       {
                //         "display": "4",
                //         "value": "4",
                //       },
                //       {
                //         "display": "5",
                //         "value": "5",
                //       },
                //       {
                //         "display": "6",
                //         "value": "Bayelsa",
                //       },
                //       {
                //         "display": "7",
                //         "value": "7",
                //       },
                //       {
                //         "display": "8",
                //         "value": "8",
                //       },
                //       {
                //         "display": "9",
                //         "value": "9",
                //       },
                //       {
                //         "display": "10",
                //         "value": "10",
                //       },
                //       {
                //         "display": "11",
                //         "value": "11",
                //       },
                //       {
                //         "display": "12",
                //         "value": "12",
                //       },
                //       {
                //         "display": "13",
                //         "value": "13",
                //       },
                //       {
                //         "display": "14",
                //         "value": "14",
                //       },
                //       {
                //         "display": "15",
                //         "value": "15",
                //       },
                //       {
                //         "display": "16",
                //         "value": "16",
                //       },
                //       {
                //         "display": "17",
                //         "value": "17",
                //       },
                //       {
                //         "display": "18",
                //         "value": "18",
                //       },
                      
                //     ],
                //     textField: 'display',
                //     valueField: 'value',
                //   ),
                // ),
                // SizedBox(
                //   height:10
                // ),
                // InkWell(
                //       // onTap: () {
                //       //   Navigator.push(
                //       //     context,
                //       //     MaterialPageRoute(builder: (context) => Register()),
                //       //   );
                //       // },
                //     child: Container(
                //       height: 50,
                //       decoration: BoxDecoration(
                //           color: Colors.green,
                //           borderRadius: BorderRadius.circular(10)
                //       ),
                //       margin: EdgeInsets.fromLTRB(70, 0, 70, 50),
                //       child: Center(
                //           child: Text(
                //             'Book Now',
                //             style: TextStyle(
                //                 fontSize: 16,
                //                 color: Colors.white),
                //           )),
//                     ),),

//               ],
//             ),
//           ),
//         ),
//       ),
    );
  }
}

class DateTimePickerFormField {
}