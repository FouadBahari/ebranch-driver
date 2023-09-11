
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Components/Components.dart';
import '../../../Helpers/Config.dart';
import '../../../Helpers/HelperFunctions.dart';
import '../../../Providers/Home/HomeProvider.dart';
import '../../../Providers/Home/HomeStates.dart';
class ChargeWalletScreen extends StatefulWidget {
  const ChargeWalletScreen({Key? key}) : super(key: key);

  @override
  _ChargeWalletScreenState createState() => _ChargeWalletScreenState();
}

class _ChargeWalletScreenState extends State<ChargeWalletScreen> {
  var chargeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "شحن الرصيد"),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset("images/logo.png",width: 180,height: 180,),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomText(text: "ادخل رقم البطاقة", fontSize: 16,fontWeight: FontWeight.w600,),
                ],
              ),
              const SizedBox(height: 10,),
              CustomInput(controller: chargeController, hint: "", textInputType: TextInputType.number),
              const SizedBox(height: 15,),
              Consumer<HomeProvider>(
                builder: (context, provider,child) {
                  return HomeStates.reasonsState != ReasonsState.LOADING?CustomButton(text: "اشحن", onPressed: () async {
                    if(chargeController.text.isEmpty){
                      return toast("الحقل مطلوب", context);
                    }
                    Map<String,dynamic> response = await provider.chargeWallet(chargeController.text);
                    toast(response['msg'], context);
                    if(response['status']){
                      Navigator.pop(context);
                      Navigator.pop(context);

                    }
                    chargeController.clear();

                  },color: Config.mainColor,):const Center(child: CircularProgressIndicator());
                }
              )
            ],
          ),
        ),
      ),
    );
  }
}
