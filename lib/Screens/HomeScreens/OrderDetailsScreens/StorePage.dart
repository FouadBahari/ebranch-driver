import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../Components/Components.dart';
import '../../../Helpers/Config.dart';
import '../../../Helpers/HelperFunctions.dart';
import '../../../Helpers/Navigation.dart';
import '../../../Models/AuthModels/UserModel.dart';
import '../../../Models/OrderModel.dart';
import '../../../Models/maekets.dart';
import '../../../Providers/Home/HomeProvider.dart';
import '../../../Providers/Home/HomeStates.dart';
import '../HomeScreen.dart';

class StorePage extends StatefulWidget {
  Map<String, dynamic>? order;

  StorePage({Key? key, this.order}) : super(key: key);

  @override
  _StorePageState createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late GoogleMapController mapController;
  late MarketsModel marketsModel;
  Set<Marker> _markers = {};
  late HomeProvider reasonProvider;
  late Position currentPosition;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      currentPosition = await determinePosition();
      marketsModel = await Provider.of<HomeProvider>(context, listen: false)
          .getMarketsWithLocation(
              currentPosition.latitude, currentPosition.longitude);
      mapController.moveCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(currentPosition.latitude, currentPosition.longitude),
            zoom: 10),
      ));
      for (var element in marketsModel.vendors!) {
        _markers.add(Marker(
            markerId: MarkerId(element.id.toString()),
            onTap: () async {
              //     Navigation.mainNavigator(context, MerchantScreen(id: element.id.toString(),));
            },
            position: LatLng(double.parse("${element.lat.toString()}"),
                double.parse("${element.lang.toString()}")),
            icon: await BitmapDescriptor.fromAssetImage(
              ImageConfiguration(size: Size.fromHeight(5)),
              "images/logo2.png",
            )));
      }
      setState(() {});
      print("_markers.length ${_markers.length}");
    });
    // TODO: implement initState
    super.initState();
    print(widget.order!["satus"]);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey[100],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                "images/logo.png",
                width: 180,
                height: 180,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: Config.responsiveWidth(context) * 0.68,
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: widget.order!["vendor_name"], fontSize: 14),
                  ),
                  Container(
                    height: 50,
                    width: Config.responsiveWidth(context) * 0.23,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    child: CustomText(
                      text: "الاسم",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              CustomButton(
                text: "اتصال",
                onPressed: () {
                  // print(widget.order!.products![0].user!.phone);
                  launch("tel:${widget.order!["vendor_phone"]}");
                },
                color: Config.mainColor,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    width: Config.responsiveWidth(context) * 0.68,
                    color: Colors.white,
                    alignment: Alignment.centerRight,
                    child: CustomText(
                        text: widget.order!["vendor_address"], fontSize: 14),
                  ),
                  Container(
                    height: 50,
                    width: Config.responsiveWidth(context) * 0.23,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.grey,
                    ),
                    child: CustomText(
                      text: "الموقع",
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 170.0,
                width: double.infinity,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    GoogleMap(
                      onMapCreated: onMapCreated,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              widget.order!["vendor_lat"] !=  null ? double.parse(widget.order!["vendor_lat"].toString()): 20,widget.order!["vendor_lang"] !=  null?double.parse(widget.order!["vendor_lang"].toString()):20) ,zoom: 16),
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      markers: _markers,
                    ),
                    Icon(
                      Icons.add_location,
                      color: Config.mainColor,
                      size: 30,
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              if (widget.order!["status"] == "تم الموافقة من السائق")
                Column(
                  children: [
                    CustomButton(
                        text: "التوجه للمتجر",
                        onPressed: () {
                          GoogleMapInitialize.openMap(
                              widget.order!["vendor_lat"] !=  null ? double.parse(widget.order!["vendor_lat"].toString()): 20,
                              widget.order!["vendor_lang"] !=  null ? double.parse(widget.order!["vendor_lang"].toString()): 20,
                             );
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    ChangeNotifierProvider(
                      create: (BuildContext context) =>
                          HomeProvider()..getReasons("متعثر"),
                      child: Selector<HomeProvider, ReasonsState>(
                          selector: (context, provider) {
                        reasonProvider = provider;
                        return HomeStates.reasonsState;
                      }, builder: (context, state, child) {
                        return CustomButton(
                          text: "حدثت مشكلة اثناء الاستلام من المتجر",
                          onPressed: () async {
                            await showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) {
                                  bool loading = false;
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                    ),
                                    title: CustomText(
                                      text: "ما سبب عدم الاستلام من المتجر ؟",
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    content: StatefulBuilder(
                                        builder: (context, changeState) {
                                      return SingleChildScrollView(
                                        child: ListBody(children: [
                                          Column(
                                            children: List.generate(
                                                reasonProvider.reasonsModel!
                                                    .data!.length, (index) {
                                              return RadioListTile(
                                                value: index,
                                                groupValue: reasonProvider
                                                    .radioButtonValue,
                                                onChanged: (v) {
                                                  reasonProvider.changeValue(v);
                                                  changeState(() {});
                                                },
                                                title: CustomText(
                                                    text: reasonProvider
                                                        .reasonsModel!
                                                        .data![index]
                                                        .name,
                                                    fontSize: 16),
                                              );
                                            }),
                                          ),
                                          CustomButton(
                                              text: "ارسال",
                                              onPressed: () async {
                                                Map<String, dynamic> formData =
                                                    {
                                                  "orderid": widget.order!["id"]
                                                      .toString(),
                                                  "status": "debug",
                                                  "reason": reasonProvider
                                                      .reasonsModel!
                                                      .data![reasonProvider
                                                          .radioButtonValue]
                                                      .name
                                                };
                                                loading = true;
                                                changeState(() {});
                                                Map<String, dynamic> response =
                                                    await reasonProvider
                                                        .changeOrderStatus(
                                                            formData);
                                                toast(response['msg'], context);
                                                await reasonProvider
                                                    .getOrders("online");
                                                loading = false;
                                                changeState(() {});
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              })
                                        ]),
                                      );
                                    }),
                                  );
                                });
                          },
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        text: "الاستلام من المتجر",
                        onPressed: () async {
                          Map<String, dynamic> formData = {
                            "orderid": widget.order!["id"].toString(),
                            "status": "donevendor",
                            "reason": ""
                          };
                          Map<String, dynamic> response =
                              await reasonProvider.changeOrderStatus(formData);
                          toast(response['msg'], context);
                          await reasonProvider.getOrders("onproccess");
                          Navigation.removeUntilNavigator(
                              context,
                              HomeScreen(
                                index: 3,
                              ));
                        }),
                  ],
                )
              else if (widget.order!["status"] == "تم الموافقة من المتجر")
                Consumer<HomeProvider>(
                    builder: (context, reasonProvider, child) {
                  return HomeStates.reasonsState != ReasonsState.LOADING
                      ? CustomButton(
                          text: "الموافقة علي الطلب",
                          onPressed: () async {
                            Map<String, dynamic> formData = {
                              "orderid": widget.order!["id"].toString(),
                              "status": "accept",
                              "reason": ""
                            };
                            Map<String, dynamic> response = await reasonProvider
                                .changeOrderStatus(formData);
                            toast(response['msg'], context);
                            await reasonProvider.getOrders("online");
                            Navigator.pop(context);
                          })
                      : const Center(child: CircularProgressIndicator());
                }),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
  }
}
