import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:teverage_motors/components/light.dart';
import 'package:teverage_motors/components/light_fleet_booking.dart';
import 'dart:convert';
// import 'package:phpmysqlcrud/main.dart';

class AddEditPage extends StatefulWidget {
  final List list;
  final int index;
  AddEditPage({this.list,this.index});
  @override
  _AddEditPageState createState() => _AddEditPageState();
}

class _AddEditPageState extends State<AddEditPage> {

  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController address = TextEditingController();

  bool editMode = false;


  addUpdateData(){
    var url = 'https://teverage.com/mobiledb/register/insert.php';
    http.post(url,body: {
        'firstname' : firstName.text,
        'lastname' : lastName.text,
        'phone' : phone.text,
        'address' : address.text,
      });
    // if(editMode){
    //   var url = 'http://192.168.51.2/teverage/edit.php';
    //   http.post(url,body: {
    //     'id' : widget.list[widget.index]['id'],
    //     'fistname' : firstName.text,
    //     'lastname' : lastName.text,
    //     'phone' : phone.text,
    //     'address' : address.text,
    //   });
    // }else{
    //   var url = 'http://192.168.51.2/teverage/add.php';
    //   http.post(url,body: {
    //     'fistname' : firstName.text,
    //     'lastname' : lastName.text,
    //     'phone' : phone.text,
    //     'address' : address.text,
    //   });
    // }

  }


  @override
  void initState() {
    super.initState();
    if(widget.index != null){
      editMode = true;
      firstName.text = widget.list[widget.index]['firstname'];
      lastName.text = widget.list[widget.index]['lastname'];
      phone.text = widget.list[widget.index]['phone'];
      address.text = widget.list[widget.index]['address'];
    }

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(editMode ? 'Update' :'Add Data'),),
      body: ListView(
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: firstName,
              decoration: InputDecoration(
                labelText: 'First Name',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: lastName,
              decoration: InputDecoration(
                labelText: 'Last Name',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: phone,
              decoration: InputDecoration(
                labelText: 'Phone',
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: address,
              decoration: InputDecoration(
                labelText: 'Address',
              ),
            ),
          ),

          Padding(padding: EdgeInsets.all(8),
            child: RaisedButton(
              onPressed: (){
                setState(() {
                  addUpdateData();
                });
                Navigator.push(context, MaterialPageRoute(builder: (context) => Light(),),);
                debugPrint('Clicked RaisedButton Button');
              },
              color: Colors.blue,
              child: Text(editMode ? 'Update' :'Save',style: TextStyle(color: Colors.white),),
            ),
          ),
        ],
      ),
    );
  }
}
