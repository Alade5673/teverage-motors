import 'package:flutter/material.dart';


class SliderModel{

  String logo;
  String imageAssetPath;
  String title;
  String desc;

  SliderModel({this.logo, this.imageAssetPath,this.title,this.desc});

  void setLogo(String getLogo){
    logo = getLogo;
  }

  void setImageAssetPath(String getImageAssetPath){
    imageAssetPath = getImageAssetPath;
  }

  void setTitle(String getTitle){
    title = getTitle;
  }

  void setDesc(String getDesc){
    desc = getDesc;
  }

  String getLogo(){
    return logo;
  }

  String getImageAssetPath(){
    return imageAssetPath;
  }

  String getTitle(){
    return title;
  }

  String getDesc(){
    return desc;
  }

}


List<SliderModel> getSlides(){

  List<SliderModel> slides = new List<SliderModel>();
  SliderModel sliderModel = new SliderModel();

  //1
  
  sliderModel.setDesc("Travelling made easy and comfortable with Teverage Limited App");
  sliderModel.setTitle("BOOK A SEAT");
  sliderModel.setLogo("assets/edited_logo1.png");
  sliderModel.setImageAssetPath("assets/travelling.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //2
  sliderModel.setDesc("Select your desired destination");
  sliderModel.setTitle("SELECT DESTINATION");
  sliderModel.setLogo("assets/edited_logo1.png");
  sliderModel.setImageAssetPath("assets/destination.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  //3
  sliderModel.setDesc("Sign in and give us your feedback.");
  sliderModel.setTitle("GIVE FEEDBACK");
  sliderModel.setLogo("assets/edited_logo1.png");
  sliderModel.setImageAssetPath("assets/feedback.png");
  slides.add(sliderModel);

  sliderModel = new SliderModel();

  return slides;
}