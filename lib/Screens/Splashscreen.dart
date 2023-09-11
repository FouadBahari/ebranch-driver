
import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
//import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../Helpers/HelperFunctions.dart';
import '../Helpers/Navigation.dart';
import 'AuthScreens/LoginScreen.dart';
import 'HomeScreens/HomeScreen.dart';
class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  _SplashscreenState createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 2),() async {
     String jwt  = await getSavedString("jwt", "");
      Navigation.removeUntilNavigator(context, jwt==""?const LoginScreen():HomeScreen());//: HomeScreen());
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image.asset("images/logo.png",height: 200,width: 200,fit: BoxFit.fill,),
      ),
    );
  }

   }
