

import 'package:flutter/cupertino.dart';

import '../../Models/AuthModels/UserModel.dart';
import '../../Repositories/AuthRepositories.dart';
import 'AuthStates.dart';

class AuthProvider extends ChangeNotifier{

  Future<UserModel> register(Map<String,String> formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
      Map<String , dynamic> response = await AuthRepositories.register(formData);
      UserModel userModel = UserModel.fromJson(response);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      return userModel;
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  Future<UserModel> login(formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
      Map<String,dynamic> response = await AuthRepositories.login(formData);
      UserModel userModel = UserModel.fromJson(response);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      return userModel;
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }


  forgotPass(formData)async{
    States.registerState = RegisterState.LOADING;
    notifyListeners();
    try{
      Map response = await AuthRepositories.forgotPass(formData);
      States.registerState = RegisterState.LOADED;
      notifyListeners();
      return response;
    }catch(e){
      States.registerState = RegisterState.ERROR;
      notifyListeners();
      return Future.error(e);
    }
  }
  
}