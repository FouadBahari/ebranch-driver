import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation{
  static mainNavigator (context,screen)=> Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
  static removeUntilNavigator (context,screen)=> Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => screen), (route) => false);
  static ReplacementNavigator (context,screen)=> Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => screen));
}