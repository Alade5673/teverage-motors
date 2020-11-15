import 'dart:io';
import 'package:teverage_motors/components/mainlightfleet.dart';
import 'package:teverage_motors/onboarding/data/data.dart';
import 'package:teverage_motors/onboarding/data/main.dart';
import 'package:flutter/material.dart';
import 'package:teverage_motors/login/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<SliderModel> mySLides = new List<SliderModel>();
  int slideIndex = 0;
  PageController controller;

  Widget _buildPageIndicator(bool isCurrentPage){
    return Container(
     margin: EdgeInsets.symmetric(horizontal: 2.0),
      height: isCurrentPage ? 10.0 : 6.0,
      width: isCurrentPage ? 10.0 : 6.0,
      decoration: BoxDecoration(
        color: isCurrentPage ? Colors.green : Colors.green[100],
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mySLides = getSlides();
    controller = new PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [const Color(0xff3C8CE7), const Color(0xff00EAFF)])),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height - 70,
          child: PageView(
            controller: controller,
              onPageChanged: (index) {
                setState(() {
                  slideIndex = index;
                });
              },
          children: <Widget>[
            SlideTile(
              logo: mySLides[0].getLogo(),
              imagePath: mySLides[0].getImageAssetPath(),
              title: mySLides[0].getTitle(),
              desc: mySLides[0].getDesc(),
            ),
            SlideTile(
              logo: mySLides[0].getLogo(),
              imagePath: mySLides[1].getImageAssetPath(),
              title: mySLides[1].getTitle(),
              desc: mySLides[1].getDesc(),
            ),
            SlideTile(
              logo: mySLides[0].getLogo(),
              imagePath: mySLides[2].getImageAssetPath(),
              title: mySLides[2].getTitle(),
              desc: mySLides[2].getDesc(),
            )
          ],
          ),
        ),
        bottomSheet: slideIndex != 2 ? Container(
          margin: EdgeInsets.symmetric(vertical: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              FlatButton(
                onPressed: (){
                  controller.animateToPage(2, duration: Duration(milliseconds: 400), curve: Curves.linear);
                },
                splashColor: Colors.white,
                child: Text(
                  "SKIP",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                ),
              ),
              Container(
                child: Row(
                  children: [
                    for (int i = 0; i < 3 ; i++) i == slideIndex ? _buildPageIndicator(true): _buildPageIndicator(false),
                  ],),
              ),
              FlatButton(
                onPressed: (){
                  print("this is slideIndex: $slideIndex");
                  controller.animateToPage(slideIndex + 1, duration: Duration(milliseconds: 500), curve: Curves.linear);
                },
                splashColor: Colors.white,
                child: Text(
                  "NEXT",
                  style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ): InkWell(
          onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => mainLightFleet()),
                    );
                  },
          child: Container(
            height: Platform.isIOS ? 70 : 60,
            color: Colors.green,
            alignment: Alignment.center,
            child: Text(
              "GET STARTED NOW",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w400),
            ),
          ),
        ),
      ),
    );
  }
}

class SlideTile extends StatelessWidget {
  String logo, imagePath, title, desc;

  SlideTile({this.logo, this.imagePath, this.title, this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(logo),
          
          // SizedBox(
          //   height: 70,
          // ),
          Image.asset(imagePath),
          SizedBox(
            height: 70,
          ),
          Text(title, textAlign: TextAlign.center,style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 30
          ),),
          SizedBox(
            height: 10,
          ),
          Text(desc, textAlign: TextAlign.center,style: TextStyle(
          fontWeight: FontWeight.w400,
              fontSize: 15))
        ],
      ),
    );
  }
}

