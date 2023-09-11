import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Helpers/Config.dart';
import '../Helpers/HelperFunctions.dart';
import 'PublicRopository.dart';

class AuthRepositories{

  static Future<Map<String,dynamic>> register(Map<String,String> formData /*,photo,photo1,photo2*/) async {
    String jwt = await getSavedString("jwt", "");
    var header={
      "Accept":'application/json',
      "Authorization": "Bearer $jwt"
    };
    var request = http.MultipartRequest("POST", Config.setApi("signup-user"));
    request.headers.addAll(header);
    request.fields.addAll(formData);
    //
    // request.files.add(await http.MultipartFile.fromPath("photo", photo));
    // request.files.add(await http.MultipartFile.fromPath("photo1",photo1));
    // request.files.add(await http.MultipartFile.fromPath("photo2", photo2));

    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    print("res$respStr");
    Map<String,dynamic> mapResponse =await json.decode(respStr);
    return mapResponse;
  }

  static Future<Map<String,dynamic>> login(formData) async {
    return await PublicRopository.repo("logins","post",formData: formData);
  }


  static Future<Map> forgotPass(formData) async {
    return await PublicRopository.repo("Forget-Password","post",formData: formData);
  }

}