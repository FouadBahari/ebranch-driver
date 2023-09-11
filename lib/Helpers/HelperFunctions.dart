
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:geolocator/geolocator.dart';
import 'package:oktoast/oktoast.dart'; // 1. import library
import 'package:url_launcher/url_launcher.dart';
import '../Components/Components.dart';
import '../Screens/AuthScreens/LoginScreen.dart';
import 'Navigation.dart';

toast(msg,context){
  showToast(
    msg,
    textPadding: const EdgeInsets.all(15),
    context: context,
    textDirection: TextDirection.rtl,
    duration: const Duration(seconds: 2),
    position: ToastPosition.center,
    backgroundColor: Colors.black.withOpacity(0.8),
    radius: 13.0,
    textStyle: const TextStyle(fontSize: 16.0),
  );
}


// Retrieve string data stored
Future<String> getSavedString(String value,String defaultVal) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  String savedValue = _prefs.getString(value) ?? defaultVal;
  return savedValue;
}

// Store String data
Future<bool> setSavedString(String key,String value) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  bool savedValue =await _prefs.setString(key,value);
  return savedValue;
}

logOut(context) async {
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  await _prefs.clear();
  Navigation.ReplacementNavigator(context, LoginScreen());
}

// get current location

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    await Geolocator.openLocationSettings();
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately.
    return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
  }

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
  return await Geolocator.getCurrentPosition();
}


// Show dialog
Future<Widget> dialog(context,title,List<Widget> dialogBody,{barrierDismissible=true})async{
    return await showDialog(context: context,barrierDismissible: barrierDismissible, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        title: CustomText(text: title,textAlign: TextAlign.center,fontWeight: FontWeight.bold, fontSize: 16,),
        content: StatefulBuilder(
          builder: (context, changeState) {
            return SingleChildScrollView(
              child: ListBody(
                children: dialogBody,
              ),
            );
          }
        ),
      );
    });
}



class GoogleMapInitialize{
  GoogleMapInitialize._();
  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl = 'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}


Future<String> getToken() async{
  String? fcm = await FirebaseMessaging.instance.getToken();
  return fcm!;
}
