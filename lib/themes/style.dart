import 'dart:ui';
import 'package:firebase_phone_auth_bloc/themes/size_config.dart';
import 'package:flutter/material.dart';


class Style{

  Style._();

  static const Color appBackgroundColor = Colors.orange;
  static const Color searchIconColor = Colors.deepOrange;
  static const Color yellowColor = const Color(0xFFffda77);
  static const Color lightBlueColor = const Color(0xFFaee6e6);
  static const Color halfWhiteColor = const Color(0xFFfbf6f0);
  static const Color orangeColor = const Color(0xFFffa45b);
  static const Color whiteColor = Colors.white;

  static final TextStyle headerTextStyle =  TextStyle(
      color: Colors.blueGrey,
      fontWeight: FontWeight.bold,
      fontSize: 25.0,
  );

  static final TextStyle subHeaderTextStyle =  TextStyle(
    color: Colors.blueGrey,
    fontStyle: FontStyle.italic,
     fontWeight: FontWeight.bold,
    fontSize: 22.0,
  );

  static final TextStyle descTextStyle = TextStyle(
    color: Colors.blueGrey,
    fontStyle: FontStyle.italic,
    fontSize: 18.0,

  );


  static final TextStyle buttonTextStyle = TextStyle(
    color: Colors.blueGrey,
    fontStyle: FontStyle.italic,
    fontSize: 20.0,

  );

  static final TextStyle button1TextStyle = TextStyle(
    color: Colors.white,
    fontStyle: FontStyle.italic,
    fontSize: 20.0,

  );

  static final TextStyle columnTextStyle = TextStyle(
    color: Colors.blueGrey,
    fontStyle: FontStyle.italic,
    fontSize: 18.0,

  );


  static final TextStyle normalTextStyle = TextStyle(
    color: Colors.blueGrey,
    fontStyle: FontStyle.italic,
    fontSize: 16.0,

  );

  static final TextStyle errorTextStyle = TextStyle(
    color: Colors.red,
    fontStyle: FontStyle.italic,
    fontSize: 16.0,

  );

  static final TextStyle inputTextStyle = TextStyle(
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.italic,
  fontSize: 20.0);

  static final TextStyle hintTextStyle = TextStyle(
    color: Colors.blueGrey,
    fontStyle: FontStyle.italic,
    fontSize: 15.0,

  );

  static final TextStyle subTextStyle = TextStyle(
    color: Colors.blueGrey,
    fontStyle: FontStyle.italic,
    fontSize: 18.0,

  );

  static final TextStyle SplashbuttonTextStyle =  TextStyle(
      fontSize: 22,
      fontStyle: FontStyle.italic
  );


  static final TextStyle movieErrorTextStyle =  TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 2.43 * SizeConfig.textMultiplier,
  );

  static final TextStyle movieLoadingTextStyle =  TextStyle(
  fontFamily: 'Montserrat',
  fontSize: 2.92 * SizeConfig.textMultiplier,
  fontWeight: FontWeight.bold
  );

  static final TextStyle appTitleTextStyle = TextStyle(
    fontFamily: 'Montserrat',
    color: Colors.blueGrey,
    fontSize: 1.95 * SizeConfig.textMultiplier,
  );

  static final TextStyle movieTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 1.95 * SizeConfig.textMultiplier
  );

  static final TextStyle movieSubTitleStyle = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 1.95 * SizeConfig.textMultiplier
  );

  static final TextStyle movieHeaderStyle = TextStyle(
      fontFamily: 'Montserrat',
      fontSize: 3.29 * SizeConfig.textMultiplier,
      fontWeight: FontWeight.bold
  );

  static final TextStyle movieDetail = TextStyle(
      fontFamily: 'Montserrat',
      fontStyle: FontStyle.italic,
      fontSize: 1.70 * SizeConfig.textMultiplier,
      color: Colors.orange.withOpacity(0.5)
  );

  static final TextStyle movieDetailInfo = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 1.70 * SizeConfig.textMultiplier,
    fontWeight: FontWeight.bold,
    color: Colors.blueGrey,
  );






}