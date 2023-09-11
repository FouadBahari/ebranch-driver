
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../../../Components/Components.dart';
import '../../../Helpers/HelperFunctions.dart';
import '../../../Helpers/Navigation.dart';
import '../../../Providers/Home/HomeProvider.dart';
import '../../../Providers/Home/HomeStates.dart';
import '../OrderDetailsScreens/OrderDetailsScreen.dart';


class AvailableOrdersPage extends StatefulWidget {
   const AvailableOrdersPage({Key? key}) : super(key: key);

  @override
  _AvailableOrdersPageState createState() => _AvailableOrdersPageState();
}

class _AvailableOrdersPageState extends State<AvailableOrdersPage> {
  Position? position;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().getOrders("online");

    Future.delayed(const Duration(seconds: 0),() async {
      position = await determinePosition();
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
      //     return snapshot.data!.docs.length==0?Center(child: CustomText(text: "لا يوجد طلبات متاحة", fontSize: 18,)):
      //     ListView.separated(
      //         itemBuilder: (context,index){
      //           return  OrderCard(onTap: (){
      //             Navigation.mainNavigator(context,  OrderDetailsScreen(order: snapshot.data!.docs[index].data()));
      //           },deliveryPrice: snapshot.data!.docs[index]["deliveryprice"],status: "online",vendorName: snapshot.data!.docs[index]["vendorName"],distance1: Geolocator.distanceBetween(position?.latitude??1, position?.longitude??1,  double.parse("2"/*provider.onlineOrderModel!.data![index].products![0].user!.lat.toString()*/), double.parse(1/*provider.onlineOrderModel!.data![index].products![0].user!.lang*/.toString())),
      //               distance2: Geolocator.distanceBetween(position?.latitude??1, position?.longitude??1,  double.parse(/*provider.onlineOrderModel!.data![index].lat.toString()*/"2"), double.parse("3"/*provider.onlineOrderModel!.data![index].lang.toString()*/)), price: snapshot.data!.docs[index]["price"], orderId: snapshot.data!.docs[index]["id"],
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
            if(HomeStates.ordersOnProccessState == OrdersOnProccessState.LOADING || context.read<HomeProvider>().onlineOrderModel==null){
              return const Center(child:  CircularProgressIndicator());
            }
            if(HomeStates.ordersOnProccessState == OrdersOnProccessState.ERROR){
              return Center(child: CustomText(text: "حدث خطأ", fontSize: 16));
            }
            if(HomeStates.ordersOnProccessState == OrdersOnProccessState.LOADED && provider.onlineOrderModel!.data!.isEmpty){
              return Center(child: CustomText(text: "لا يوجد طلبات", fontSize: 16));
            }
            return ListView.separated(
                itemBuilder: (context,index){
                  return OrderCard(onTap: (){
                    final Map<String, dynamic> orderData = new Map<String, dynamic>();
                    orderData["id"] = provider!.onlineOrderModel!.data![index].id;
                    orderData["product_id"] = provider!.onlineOrderModel!.data![index].productId;
                    orderData["amount"] = provider!.onlineOrderModel!.data![index].amount;
                    orderData["price"] = provider!.onlineOrderModel!.data![index].price;
                    orderData["user_id"] = provider!.onlineOrderModel!.data![index].userId;
                    orderData["driver_id"] = provider!.onlineOrderModel!.data![index].driverId;
                    orderData["address"] = provider!.onlineOrderModel!.data![index].address;
                    orderData["lat"] = provider!.onlineOrderModel!.data![index].lat;
                    orderData["lang"] = provider!.onlineOrderModel!.data![index].lang;
                    orderData["status"] = provider!.onlineOrderModel!.data![index].status;
                    orderData["type"] = provider!.onlineOrderModel!.data![index].type;
                    orderData["rate"] = provider!.onlineOrderModel!.data![index].rate;
                    orderData["shipping_price"] = provider!.onlineOrderModel!.data![index].deliveryPrice;

                    orderData["vendor_id"] = provider!.onlineOrderModel!.data![index].vendor_id;
                    orderData["vendor_name"] = provider!.onlineOrderModel!.data![index].vendor_name;
                    orderData["vendor_address"] = provider!.onlineOrderModel!.data![index].vendor_address;
                    orderData["vendor_lat"] = provider!.onlineOrderModel!.data![index].vendor_lat;
                    orderData["vendor_lang"] = provider!.onlineOrderModel!.data![index].vendor_lang;
                    orderData["vendor_phone"] = provider!.onlineOrderModel!.data![index].vendor_phone;
                    orderData["username"] = provider!.onlineOrderModel!.data![index].username;
                    orderData["userphone"] = provider!.onlineOrderModel!.data![index].userphone;


                    orderData["replay"] = provider!.onlineOrderModel!.data![index].replay;
                    orderData["created_at"] = provider!.onlineOrderModel!.data![index].createdAt;
                    orderData["updated_at"] = provider!.onlineOrderModel!.data![index].updatedAt;
                    orderData["name"] = provider.onlineOrderModel!.data![index].products![0].user!.name!;
                    orderData["products"] = provider!.onlineOrderModel!.data![index].products!.map((e)=>e.toJson()).toList() ?? [];
                    orderData["driver"] = provider!.onlineOrderModel!.data![index].driver!.toJson() ??'';

                    Navigation.mainNavigator(context,  OrderDetailsScreen(order: orderData));
                  },status: "onproccess",vendorName: provider.onlineOrderModel!.data![index].products![0].user!.name!, price: provider.onlineOrderModel!.data![index].price.toString(), orderId: provider.onlineOrderModel!.data![index].id.toString(), deliveryPrice: provider.onlineOrderModel!.data![index].deliveryPrice.toString(),
                  );
                },
                separatorBuilder: (context,index){
                  return const SizedBox(height: 10,);
                },
                itemCount: provider.onlineOrderModel!.data!.length
            );
          }
      );
  }
}
