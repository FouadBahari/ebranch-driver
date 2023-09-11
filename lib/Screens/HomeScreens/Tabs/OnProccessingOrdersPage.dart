
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../Components/Components.dart';
import '../../../Helpers/Navigation.dart';
import '../../../Providers/Home/HomeProvider.dart';
import '../../../Providers/Home/HomeStates.dart';
import '../OrderDetailsScreens/OrderDetailsScreen.dart';
class OnProccessingOrdersPage extends StatefulWidget {
  const OnProccessingOrdersPage({Key? key}) : super(key: key);

  @override
  _OnProccessingOrdersPageState createState() => _OnProccessingOrdersPageState();
}

class _OnProccessingOrdersPageState extends State<OnProccessingOrdersPage> {
  late HomeProvider provider;
  double? distanceMeVendor , dicsanceVendorDriver;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<HomeProvider>().getOrders("onproccess");
    });
  }
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
      //     return snapshot.data!.docs.length==0?Center(child: CustomText(text: "لا يوجد طلبات قيد التنفيذ", fontSize: 18,)):
      //     ListView.separated(
      //         itemBuilder: (context,index){
      //           return  OrderCard(onTap: (){
      //             Navigation.mainNavigator(context,  OrderDetailsScreen(order: snapshot.data!.docs[index].data()));
      //
      //             // Navigation.mainNavigator(context,  OrderDetailsScreen(order: provider.onlineOrderModel!.data![index]));
      //           },deliveryPrice: snapshot.data!.docs[index]["deliveryprice"],status: "onproccess",vendorName: snapshot.data!.docs[index]["vendorName"],/*distance1: Geolocator.distanceBetween(position!.latitude, position!.longitude,  double.parse("2"*//*provider.onlineOrderModel!.data![index].products![0].user!.lat.toString()*//*), double.parse(1*//*provider.onlineOrderModel!.data![index].products![0].user!.lang*//*.toString())),*/
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
    Consumer<HomeProvider>(
        builder: (context, provider,child) {
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.LOADING || context.read<HomeProvider>().onproccessOrderModel==null){
            return const Center(child:  CircularProgressIndicator());
          }
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.ERROR){
            return Center(child: CustomText(text: "حدث خطأ", fontSize: 16));
          }
          if(HomeStates.ordersOnProccessState == OrdersOnProccessState.LOADED && provider.onproccessOrderModel!.data!.isEmpty){
            return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
          }
          return ListView.separated(
              itemBuilder: (context,index){
                return OrderCard(onTap: (){
                  final Map<String, dynamic> orderData = new Map<String, dynamic>();
                  orderData["id"] = provider!.onproccessOrderModel!.data![index].id;
                  orderData["product_id"] = provider!.onproccessOrderModel!.data![index].productId;
                  orderData["amount"] = provider!.onproccessOrderModel!.data![index].amount;
                  orderData["price"] = provider!.onproccessOrderModel!.data![index].price;
                  orderData["user_id"] = provider!.onproccessOrderModel!.data![index].userId;
                  orderData["driver_id"] = provider!.onproccessOrderModel!.data![index].driverId;
                  orderData["address"] = provider!.onproccessOrderModel!.data![index].address;
                  orderData["lat"] = provider!.onproccessOrderModel!.data![index].lat;
                  orderData["lang"] = provider!.onproccessOrderModel!.data![index].lang;
                  orderData["status"] = provider!.onproccessOrderModel!.data![index].status;
                  orderData["type"] = provider!.onproccessOrderModel!.data![index].type;
                  orderData["name"] = provider.onproccessOrderModel!.data![index].products![0].user!.name!;



                  orderData["vendor_id"] = provider!.onproccessOrderModel!.data![index].vendor_id;
                  orderData["vendor_name"] = provider!.onproccessOrderModel!.data![index].vendor_name;
                  orderData["vendor_address"] = provider!.onproccessOrderModel!.data![index].vendor_address;
                  orderData["vendor_lat"] = provider!.onproccessOrderModel!.data![index].vendor_lat;
                  orderData["vendor_lang"] = provider!.onproccessOrderModel!.data![index].vendor_lang;
                  orderData["vendor_phone"] = provider!.onproccessOrderModel!.data![index].vendor_phone;
                  orderData["username"] = provider!.onproccessOrderModel!.data![index].username;
                  orderData["userphone"] = provider!.onproccessOrderModel!.data![index].userphone;

                  orderData["rate"] = provider!.onproccessOrderModel!.data![index].rate;
                  orderData["shipping_price"] = provider!.onproccessOrderModel!.data![index].deliveryPrice.toString();
                  orderData["description"] = provider!.onproccessOrderModel!.data![index].description;
                  orderData["replay"] = provider!.onproccessOrderModel!.data![index].replay;
                  orderData["created_at"] = provider!.onproccessOrderModel!.data![index].createdAt;
                  orderData["updated_at"] = provider!.onproccessOrderModel!.data![index].updatedAt;
                  orderData["products"] = provider!.onproccessOrderModel!.data![index].products!.map((e)=>e.toJson()).toList() ?? [];
                  orderData["driver"] = provider!.onproccessOrderModel!.data![index].driver!.toJson() ??'';
                  Navigation.mainNavigator(context,  OrderDetailsScreen(order: orderData));

                },status: "onproccess",vendorName: provider.onproccessOrderModel!.data![index].products![0].user!.name!, price: provider.onproccessOrderModel!.data![index].price.toString(), orderId: provider.onproccessOrderModel!.data![index].id.toString(), deliveryPrice: provider.onproccessOrderModel!.data![index].deliveryPrice.toString(),
                );
              },
              separatorBuilder: (context,index){
                return const SizedBox(height: 10,);
              },
              itemCount: provider.onproccessOrderModel!.data!.length
          );
        }
    );
  }
}
