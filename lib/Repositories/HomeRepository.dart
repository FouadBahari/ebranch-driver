import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Helpers/Config.dart';
import '../Helpers/HelperFunctions.dart';
import 'PublicRopository.dart';

class HomeRepository{
  static Future<Map<String,dynamic>> getOrders(status)async{
    return await PublicRopository.repo("orders/$status", "get");
  }

  static Future<Map<String,dynamic>> getReasons(type)async{
    return await PublicRopository.repo("reasons/$type", "get");
  }

  static Future<Map<String,dynamic>> getWallet()async{
    return await PublicRopository.repo("Order-charge-card", "get");
  }

  static Future<Map<String,dynamic>> getRate()async{
    return await PublicRopository.repo("rate-delevery", "get");
  }

  static Future<Map<String,dynamic>> changeOrderStatus(formData)async{
    return await PublicRopository.repo("replay-order", "post",formData: formData);
  }

  static Future<Map<String,dynamic>> chargeWallet(num)async{
    return await PublicRopository.repo("charge-card/$num", "get");
  }

  static Future<Map<String,dynamic>> finishOrder(Map<String,String> formData) async {

    return await PublicRopository.repo("finish-order", "post",formData: formData);

    // String jwt = await getSavedString("jwt", "");
    // var header={
    //   "Accept":'application/json',
    //   "Authorization": "Bearer $jwt"
    // };
    // var request = http.MultipartRequest("POST", Config.setApi("finish-order"));
    // request.headers.addAll(header);
    // request.fields.addAll(formData);
    //
    // request.files.add(await http.MultipartFile.fromPath("photo", photo));
    //
    // var response = await request.send();
    // final respStr = await response.stream.bytesToString();
    // print("res$respStr");
    // Map<String,dynamic> mapResponse =await json.decode(respStr);
    // return mapResponse;
  }

  static Future<Map<String,dynamic>?> terms(type) async {
    return await PublicRopository.repo("terms/$type","get");
  }


}