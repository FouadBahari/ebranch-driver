import 'package:another_flushbar/flushbar.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:provider/provider.dart';

import '../../Components/Components.dart';
import '../../Helpers/Config.dart';
import '../../Providers/Home/HomeProvider.dart';
import 'DrawerScreen.dart';
import 'Tabs/AvailableOrdersPage.dart';
import 'Tabs/DeliverdOrdersPage.dart';
import 'Tabs/OnProccessingOrdersPage.dart';
import 'Tabs/ProblemOrdersPage.dart';
import 'Tabs/RefundOrdersPage.dart';
class HomeScreen extends StatefulWidget {
  int? index;
  HomeScreen({Key? key, this.index}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchDataWithinNotification(context);
  }
  fetchDataWithinNotification(context) async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    messaging.requestPermission();
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    FirebaseMessaging.onMessage.listen((event) {
      Flushbar(
        message: event.notification!.body ,
        title: event.notification!.title,
        messageColor: Colors.white,
        titleColor: Colors.white,
        textDirection: TextDirection.rtl,
        padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        // maxWidth: double.infinity,
        isDismissible: true,
        duration: const Duration(seconds: 5),
        flushbarPosition: FlushbarPosition.TOP,
        barBlur: .1,
        backgroundColor: Config.mainColor,
        borderColor: Colors.white,
        margin: const EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
      ).show(context);
      Provider.of<HomeProvider>(context,listen: false).getOrders("online");
      Provider.of<HomeProvider>(context,listen: false).getOrders("onproccess");
      Provider.of<HomeProvider>(context,listen: false).getOrders("receved");
      Provider.of<HomeProvider>(context,listen: false).getOrders("debug");
      Provider.of<HomeProvider>(context,listen: false).getOrders("back");
      setState(() {});
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: const DrawerScreen(),
        appBar: CustomAppBar(text: "الرئيسية"),
        body: DefaultTabController(
          length: 5,
          initialIndex: widget.index??4,
          child: Column(
            children: [
              TabBar(
                  indicatorWeight: 2,
                  indicatorColor: Config.mainColor,
                  tabs: <Widget>[
                    Tab(child: Text("متعثرة",style: TextStyle(color: Config.mainColor),),),
                    Tab(child: Text("مرتجع",style: TextStyle(color: Config.mainColor),),),
                    Tab(child: Text("تم التسليم",style: TextStyle(color: Config.mainColor,fontSize: 13),),),
                    Tab(child: Text("قيد التنفيذ",style: TextStyle(color: Config.mainColor),),),
                    Tab(child: Text("متاحة",style: TextStyle(color: Config.mainColor),),),
                  ]
              ),

               Expanded(
                child: TabBarView(
                    children: <Widget>[
                      const ProblemOrdersPage(),
                      const RefundOrdersPage(),
                      const DeliverdOrdersPage(),
                      const OnProccessingOrdersPage(),
                      AvailableOrdersPage(),
                    ]),
              ),
            ],
          ),
        )
    );
  }
}
