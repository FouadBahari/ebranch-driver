import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Components/Components.dart';
import '../../Helpers/Config.dart';
import '../../Helpers/HelperFunctions.dart';
import '../../Helpers/Navigation.dart';
import '../../Models/AuthModels/UserModel.dart';
import '../AuthScreens/LoginScreen.dart';
import 'HomeScreen.dart';
import 'RateScreen.dart';
import 'TermsScreen.dart';
import 'Wallet/WalletScreen.dart';
class DrawerScreen extends StatefulWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  var nameController = TextEditingController();
  var emailController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchProfileData();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 250,
                color: Colors.white,
              ),
              Container(
                height: 250,
                color: Config.mainColor,
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20,),
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.white,
                      child: Image.asset("images/logo.png",fit: BoxFit.fill,height: 60,width: 60,),
                    ),
                    const SizedBox(height: 7,),
                    CustomText(text: "${nameController.text}", fontSize: 14,fontWeight: FontWeight.w600,color: Colors.white,),
                    CustomText(text: "${emailController.text}", fontSize: 11,color: Colors.white,),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: Config.responsiveHeight(context)-250,
            width: double.infinity,
            color: Config.mainColor,
            child: SingleChildScrollView(
              child: Container(
                color: Colors.black.withOpacity(0.1),
                child: Column(
                  children: [
                    // Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    // Directionality(
                    //   textDirection: TextDirection.rtl,
                    //   child: ListTile(
                    //     onTap: (){
                    //
                    //     },
                    //     title: CustomText(text:"الشخصية", fontSize: 14,color: Colors.white,),
                    //     leading: const Icon(Icons.person,color: Colors.white),
                    //   ),
                    // ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.removeUntilNavigator(context, HomeScreen(index: 4,));
                        },
                        title: CustomText(text:"متاحة", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/home.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.removeUntilNavigator(context, HomeScreen(index: 3,));
                        },
                        title: CustomText(text:"قيد التنفيذ", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/home.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.removeUntilNavigator(context, HomeScreen(index: 2,));
                        },
                        title: CustomText(text:"تم التسليم", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/home.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.removeUntilNavigator(context, HomeScreen(index: 1,));
                        },
                        title: CustomText(text:"مرتجع", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/home.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.removeUntilNavigator(context, HomeScreen(index: 0,));
                        },
                        title: CustomText(text:"متعثرة", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/home.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                            Navigation.mainNavigator(context, const RateScreen());
                        },
                        title: CustomText(text:"التقييم", fontSize: 14,color: Colors.white,),
                        leading: const Icon(Icons.star,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, const WalletScreen());
                        },
                        title: CustomText(text:"رصيد ودخل", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/home.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, TermsScreen(type: "privcy"));
                        },
                        title: CustomText(text:"سياسة الخصوصية", fontSize: 14,color: Colors.white,),
                        leading: const Icon(Icons.people,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: (){
                          Navigation.mainNavigator(context, TermsScreen(type: "terms"));
                        },
                        title: CustomText(text:"الشروط والأحكام", fontSize: 14,color: Colors.white,),
                        leading: Image.asset("images/terms.png",height: 25,width: 25,color: Colors.white,),
                      ),
                    ),
                    Container(height: 0.5,width: double.infinity,color: Colors.white,),

                    Directionality(
                      textDirection: TextDirection.rtl,
                      child: ListTile(
                        onTap: () async {
                          SharedPreferences pre = await SharedPreferences.getInstance();
                          pre.clear();
                        // await  FirebaseAuth.instance.signOut();
                          Navigation.removeUntilNavigator(context, LoginScreen());
                        },
                        title: CustomText(text:"خروج", fontSize: 14,color: Colors.white,),
                        leading: const Icon(Icons.logout,color: Colors.white,),
                      ),
                    ),

                    Container(height: 0.5,width: double.infinity,color: Colors.white,),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
  fetchProfileData() async {
    Map<String,dynamic> mapResponse = jsonDecode(await getSavedString("userData", ""));
    Data model = Data.fromJson(mapResponse);
    print(model);
    nameController.text = "الاسم بالكامل : ${model.name.toString()}";
    emailController.text = "البريد الالكتروني : ${model.email.toString()}";
    setState(() {});
  }
}
