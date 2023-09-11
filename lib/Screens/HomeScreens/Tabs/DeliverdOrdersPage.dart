
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../Components/Components.dart';
import '../../../Helpers/Navigation.dart';
import '../../../Providers/Home/HomeProvider.dart';
import '../../../Providers/Home/HomeStates.dart';
import '../OrderDetailsScreens/OrderDetailsScreen.dart';
class DeliverdOrdersPage extends StatefulWidget {
  const DeliverdOrdersPage({Key? key}) : super(key: key);

  @override
  _DeliverdOrdersPageState createState() => _DeliverdOrdersPageState();
}

class _DeliverdOrdersPageState extends State<DeliverdOrdersPage> {
  late HomeProvider provider;
  double? distanceMeVendor , dicsanceVendorDriver;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider()..getOrders("receved"),
      child: Selector<HomeProvider,OrdersOnProccessState>(
          selector: (context,homeProvider){
            provider = homeProvider;
            return HomeStates.ordersOnProccessState;
          },
          builder: (context, state,child) {
            if(state == OrdersOnProccessState.LOADING){
              return const Center(child:  CircularProgressIndicator());
            }
            if(state == OrdersOnProccessState.ERROR){
              return Center(child: CustomText(text: "حدث خطأ", fontSize: 16));
            }
            if(state == OrdersOnProccessState.LOADED && provider.recevedOrderModel!.data!.isEmpty){
              return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
            }
            return ListView.separated(
                itemBuilder: (context,index){
                  return OrderCard(onTap: (){
                    final Map<String, dynamic> orderData = new Map<String, dynamic>();
                    orderData["id"] = provider!.recevedOrderModel!.data![index].id;
                    orderData["product_id"] = provider!.recevedOrderModel!.data![index].productId;
                    orderData["amount"] = provider!.recevedOrderModel!.data![index].amount;
                    orderData["price"] = provider!.recevedOrderModel!.data![index].price;
                    orderData["user_id"] = provider!.recevedOrderModel!.data![index].userId;
                    orderData["driver_id"] = provider!.recevedOrderModel!.data![index].driverId;
                    orderData["address"] = provider!.recevedOrderModel!.data![index].address;
                    orderData["lat"] = provider!.recevedOrderModel!.data![index].lat;
                    orderData["lang"] = provider!.recevedOrderModel!.data![index].lang;
                    orderData["status"] = provider!.recevedOrderModel!.data![index].status;

                    orderData["type"] = provider!.recevedOrderModel!.data![index].type;
                    orderData["rate"] = provider!.recevedOrderModel!.data![index].rate;
                    orderData["name"] = provider.recevedOrderModel!.data![index].products![0].user!.name!;



                    orderData["vendor_id"] = provider!.recevedOrderModel!.data![index].vendor_id;
                    orderData["vendor_name"] = provider!.recevedOrderModel!.data![index].vendor_name;
                    orderData["vendor_address"] = provider!.recevedOrderModel!.data![index].vendor_address;
                    orderData["vendor_lat"] = provider!.recevedOrderModel!.data![index].vendor_lat;
                    orderData["vendor_lang"] = provider!.recevedOrderModel!.data![index].vendor_lang;
                    orderData["vendor_phone"] = provider!.recevedOrderModel!.data![index].vendor_phone;
                    orderData["username"] = provider!.recevedOrderModel!.data![index].username;
                    orderData["userphone"] = provider!.recevedOrderModel!.data![index].userphone;

                    orderData["shipping_price"] = provider!.recevedOrderModel!.data![index].deliveryPrice;
                    orderData["description"] = provider!.recevedOrderModel!.data![index].description;
                    orderData["replay"] = provider!.recevedOrderModel!.data![index].replay;
                    orderData["created_at"] = provider!.recevedOrderModel!.data![index].createdAt;
                    orderData["updated_at"] = provider!.recevedOrderModel!.data![index].updatedAt;
                    orderData["products"] = provider!.recevedOrderModel!.data![index].products!.map((e)=>e.toJson()).toList() ?? [];
                    orderData["driver"] = provider!.recevedOrderModel!.data![index].driver!.toJson() ??'';
                    Navigation.mainNavigator(context,  OrderDetailsScreen(order: orderData,));
                  },deliveryPrice: provider.recevedOrderModel!.data![index].deliveryPrice.toString(),status: "receved",vendorName: provider.recevedOrderModel!.data![index].products![0].user!.name!, price: provider.recevedOrderModel!.data![index].price.toString(), orderId: provider.recevedOrderModel!.data![index].id.toString(),
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 10,);
                },
                itemCount: provider.recevedOrderModel!.data!.length
            );
          }
      ),
    );
      // StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection("orders")
      //         .snapshots(),
      //     builder: (context,
      //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(
      //             color: Colors.white,
      //           ),
      //         );
      //       }
      //       return snapshot.data!.docs.length==0?Center(child: CustomText(text: "لا يوجد طلبات منتهية", fontSize: 18,)):
      //       ListView.separated(
      //           itemBuilder: (context,index){
      //             return  OrderCard(onTap: (){
      //               Navigation.mainNavigator(context,  OrderDetailsScreen(order: snapshot.data!.docs[index].data()));
      //
      //               // Navigation.mainNavigator(context,  OrderDetailsScreen(order: provider.onlineOrderModel!.data![index]));
      //             },deliveryPrice: snapshot.data!.docs[index]["deliveryprice"],status: "receved",vendorName: snapshot.data!.docs[index]["vendorName"],/*distance1: Geolocator.distanceBetween(position!.latitude, position!.longitude,  double.parse("2"*//*provider.onlineOrderModel!.data![index].products![0].user!.lat.toString()*//*), double.parse(1*//*provider.onlineOrderModel!.data![index].products![0].user!.lang*//*.toString())),*/
      //               /*distance2: Geolocator.distanceBetween(position!.latitude, position!.longitude,  double.parse(*//*provider.onlineOrderModel!.data![index].lat.toString()*//*"2"), double.parse("3"*//*provider.onlineOrderModel!.data![index].lang.toString()*//*))*/ price: snapshot.data!.docs[index]["price"], orderId: snapshot.data!.docs[index]["id"],
      //             );
      //           },
      //           separatorBuilder: (context,index){
      //             return const SizedBox(height: 10,);
      //           },
      //           itemCount:snapshot.data!.docs.length
      //       );
      //
      //     });
  }
}
