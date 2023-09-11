
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Components/Components.dart';
import '../../../Helpers/Navigation.dart';
import '../../../Providers/Home/HomeProvider.dart';
import '../../../Providers/Home/HomeStates.dart';
import '../OrderDetailsScreens/OrderDetailsScreen.dart';
class ProblemOrdersPage extends StatefulWidget {
  const ProblemOrdersPage({Key? key}) : super(key: key);

  @override
  _ProblemOrdersPageState createState() => _ProblemOrdersPageState();
}

class _ProblemOrdersPageState extends State<ProblemOrdersPage> {
  HomeProvider? provider;
  double? distanceMeVendor , dicsanceVendorDriver;

  @override
  Widget build(BuildContext context) {
    return

      // StreamBuilder(
      //   stream: FirebaseFirestore.instance
      //       .collection("orders")
      //       .snapshots(),
      //   builder: (context,
      //       AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(
      //         child: CircularProgressIndicator(
      //           color: Colors.white,
      //         ),
      //       );
      //     }
      //     return snapshot.data!.docs.length==0?Center(child: CustomText(text: "لا يوجد طلبات متعثرة", fontSize: 18,)):
      //     ListView.separated(
      //         itemBuilder: (context,index){
      //           return  OrderCard(onTap: (){
      //             Navigation.mainNavigator(context,  OrderDetailsScreen(order: snapshot.data!.docs[index].data()));
      //
      //             // Navigation.mainNavigator(context,  OrderDetailsScreen(order: provider.onlineOrderModel!.data![index]));
      //           },deliveryPrice: snapshot.data!.docs[index]["deliveryprice"],status: "back",vendorName: snapshot.data!.docs[index]["vendorName"],/*distance1: Geolocator.distanceBetween(position!.latitude, position!.longitude,  double.parse("2"*//*provider.onlineOrderModel!.data![index].products![0].user!.lat.toString()*//*), double.parse(1*//*provider.onlineOrderModel!.data![index].products![0].user!.lang*//*.toString())),*/
      //             /*distance2: Geolocator.distanceBetween(position!.latitude, position!.longitude,  double.parse(*//*provider.onlineOrderModel!.data![index].lat.toString()*//*"2"), double.parse("3"*//*provider.onlineOrderModel!.data![index].lang.toString()*//*))*/ price: snapshot.data!.docs[index]["price"], orderId: snapshot.data!.docs[index]["id"],
      //           );
      //         },
      //         separatorBuilder: (context,index){
      //           return const SizedBox(height: 10,);
      //         },
      //         itemCount:snapshot.data!.docs.length
      //     );
      //
      //   });

    ChangeNotifierProvider(
      create: (BuildContext context) => HomeProvider()..getOrders("debug"),
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
            if(state == OrdersOnProccessState.LOADED && provider!.debugOrderModel!.data!.isEmpty){
              return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
            }
            return ListView.separated(
                itemBuilder: (context,index){
                  return OrderCard(onTap: (){
                    final Map<String, dynamic> orderData = new Map<String, dynamic>();
                    orderData["id"] = provider!.debugOrderModel!.data![index].id;
                    orderData["product_id"] = provider!.debugOrderModel!.data![index].productId;
                    orderData["amount"] = provider!.debugOrderModel!.data![index].amount;
                    orderData["price"] = provider!.debugOrderModel!.data![index].price;
                    orderData["user_id"] = provider!.debugOrderModel!.data![index].userId;
                    orderData["driver_id"] = provider!.debugOrderModel!.data![index].driverId;
                    orderData["address"] = provider!.debugOrderModel!.data![index].address;
                    orderData["lat"] = provider!.debugOrderModel!.data![index].lat;
                    orderData["lang"] = provider!.debugOrderModel!.data![index].lang;
                    orderData["status"] = provider!.debugOrderModel!.data![index].status;
                    orderData["type"] = provider!.debugOrderModel!.data![index].type;
                    orderData["rate"] = provider!.debugOrderModel!.data![index].rate;
                    orderData["name"] = provider!.debugOrderModel!.data![index].products![0].user!.name!;
                    orderData["shipping_price"] = provider!.debugOrderModel!.data![index].deliveryPrice;



                    orderData["vendor_id"] = provider!.debugOrderModel!.data![index].vendor_id;
                    orderData["vendor_name"] = provider!.debugOrderModel!.data![index].vendor_name;
                    orderData["vendor_address"] = provider!.debugOrderModel!.data![index].vendor_address;
                    orderData["vendor_lat"] = provider!.debugOrderModel!.data![index].vendor_lat;
                    orderData["vendor_lang"] = provider!.debugOrderModel!.data![index].vendor_lang;
                    orderData["vendor_phone"] = provider!.debugOrderModel!.data![index].vendor_phone;
                    orderData["username"] = provider!.debugOrderModel!.data![index].username;
                    orderData["userphone"] = provider!.debugOrderModel!.data![index].userphone;

                    orderData["description"] = provider!.debugOrderModel!.data![index].description;
                    orderData["replay"] = provider!.debugOrderModel!.data![index].replay;
                    orderData["created_at"] = provider!.debugOrderModel!.data![index].createdAt;
                    orderData["updated_at"] = provider!.debugOrderModel!.data![index].updatedAt;
                    orderData["products"] = provider!.debugOrderModel!.data![index].products!.map((e)=>e.toJson()).toList() ?? [];
                    orderData["driver"] = provider!.debugOrderModel!.data![index].driver!.toJson() ??'';
                    Navigation.mainNavigator(context,  OrderDetailsScreen(order: orderData,));
                  },deliveryPrice: provider!.debugOrderModel!.data![index].deliveryPrice.toString(),status: "back",vendorName: provider!.debugOrderModel!.data![index].products![0].user!.name!, price: provider!.debugOrderModel!.data![index].price.toString(), orderId: provider!.debugOrderModel!.data![index].id.toString(),
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 10,);
                },
                itemCount: provider!.debugOrderModel!.data!.length
            );
          }
      ),
    );
  }
}
