
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Components/Components.dart';
import '../../../Helpers/Navigation.dart';
import '../../../Providers/Home/HomeProvider.dart';
import '../../../Providers/Home/HomeStates.dart';
import '../OrderDetailsScreens/OrderDetailsScreen.dart';
class RefundOrdersPage extends StatefulWidget {
  const RefundOrdersPage({Key? key}) : super(key: key);

  @override
  _RefundOrdersPageState createState() => _RefundOrdersPageState();
}

class _RefundOrdersPageState extends State<RefundOrdersPage> {
  late HomeProvider provider;
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
      //     return snapshot.data!.docs.length==0?Center(child: CustomText(text: "لا يوجد طلبات مرتجعة", fontSize: 18,)):
      //     ListView.separated(
      //         itemBuilder: (context,index){
      //           return  OrderCard(onTap: (){
      //             Navigation.mainNavigator(context,  OrderDetailsScreen(order: snapshot.data!.docs[index].data()));
      //
      //             // Navigation.mainNavigator(context,  OrderDetailsScreen(order: provider.onlineOrderModel!.data![index]));
      //           },deliveryPrice: snapshot.data!.docs[index]["deliveryprice"],status: "debug",vendorName: snapshot.data!.docs[index]["vendorName"],/*distance1: Geolocator.distanceBetween(position!.latitude, position!.longitude,  double.parse("2"*//*provider.onlineOrderModel!.data![index].products![0].user!.lat.toString()*//*), double.parse(1*//*provider.onlineOrderModel!.data![index].products![0].user!.lang*//*.toString())),*/
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
      create: (BuildContext context) => HomeProvider()..getOrders("back"),
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
            if(state == OrdersOnProccessState.LOADED && provider.backOrderModel!.data!.isEmpty){
              return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
            }
            return ListView.separated(
                itemBuilder: (context,index){
                  return OrderCard(onTap: (){
                    final Map<String, dynamic> orderData = new Map<String, dynamic>();
                    orderData["id"] = provider!.backOrderModel!.data![index].id;
                    orderData["product_id"] = provider!.backOrderModel!.data![index].productId;
                    orderData["amount"] = provider!.backOrderModel!.data![index].amount;
                    orderData["price"] = provider!.backOrderModel!.data![index].price;
                    orderData["user_id"] = provider!.backOrderModel!.data![index].userId;
                    orderData["driver_id"] = provider!.backOrderModel!.data![index].driverId;
                    orderData["address"] = provider!.backOrderModel!.data![index].address;
                    orderData["lat"] = provider!.backOrderModel!.data![index].lat;
                    orderData["name"] = provider!.backOrderModel!.data![index].products![0].user!.name!;



                    orderData["vendor_id"] = provider!.backOrderModel!.data![index].vendor_id;
                    orderData["vendor_name"] = provider!.backOrderModel!.data![index].vendor_name;
                    orderData["vendor_address"] = provider!.backOrderModel!.data![index].vendor_address;
                    orderData["vendor_lat"] = provider!.backOrderModel!.data![index].vendor_lat;
                    orderData["vendor_lang"] = provider!.backOrderModel!.data![index].vendor_lang;
                    orderData["vendor_phone"] = provider!.backOrderModel!.data![index].vendor_phone;
                    orderData["username"] = provider!.backOrderModel!.data![index].username;
                    orderData["userphone"] = provider!.backOrderModel!.data![index].userphone;

                    orderData["lang"] = provider!.backOrderModel!.data![index].lang;
                    orderData["status"] = provider!.backOrderModel!.data![index].status;
                    orderData["type"] = provider!.backOrderModel!.data![index].type;
                    orderData["rate"] = provider!.backOrderModel!.data![index].rate;
                    orderData["shipping_price"] = provider!.onlineOrderModel!.data![index].deliveryPrice;
                    orderData["description"] = provider!.onlineOrderModel!.data![index].description;
                    orderData["replay"] = provider!.backOrderModel!.data![index].replay;
                    orderData["created_at"] = provider!.backOrderModel!.data![index].createdAt;
                    orderData["updated_at"] = provider!.backOrderModel!.data![index].updatedAt;
                    orderData["products"] = provider!.backOrderModel!.data![index].products!.map((e)=>e.toJson()).toList() ?? [];
                    orderData["driver"] = provider!.backOrderModel!.data![index].driver!.toJson() ??'';
                    Navigation.mainNavigator(context,  OrderDetailsScreen(order: orderData,));
                  },deliveryPrice: provider.backOrderModel!.data![index].deliveryPrice.toString(),status: "debug",vendorName: provider.backOrderModel!.data![index].products![0].user!.name!, price: provider.backOrderModel!.data![index].price.toString(), orderId: provider.backOrderModel!.data![index].id.toString(),
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 10,);
                },
                itemCount: provider.backOrderModel!.data!.length
            );
          }
      ),
    );
  }
}
