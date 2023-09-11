import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../Components/Components.dart';
import '../../Helpers/Config.dart';
import '../../Helpers/HelperFunctions.dart';
import '../../Helpers/Navigation.dart';
import '../../Models/AuthModels/UserModel.dart';
import '../../Providers/Auth/AuthProvider.dart';
import '../../Providers/Auth/AuthStates.dart';
import '../../services/firebase_auth_methods.dart';
import '../HomeScreens/HomeScreen.dart';
import 'LoginScreen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var phoneNumberController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordConfirmationController = TextEditingController();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var countryController = TextEditingController();

  XFile? file1, file2, file3;
  String images = "";
  GlobalKey _formKey = GlobalKey<FormState>();

  var addressController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  Uint8List? _licenceimageURL;
  Uint8List? _istemaraimageURL;
  Uint8List? _identityimageURL;

  selectedlicenceImage() async {
    Uint8List imageURL = await picklicenceImage(
      ImageSource.gallery,
    );
    setState(() {
      _licenceimageURL = imageURL;
    });
  }

  selectedistemaraImage() async {
    Uint8List imageURL = await pickistemaraImage(
      ImageSource.gallery,
    );
    setState(() {
      _istemaraimageURL = imageURL;
    });
  }

  selectedidentityImage() async {
    Uint8List imageURL = await pickidentityImage(
      ImageSource.gallery,
    );
    setState(() {
      _identityimageURL = imageURL;
    });
  }

  picklicenceImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
  pickistemaraImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }
  pickidentityImage(ImageSource source) async {
    final ImagePicker _imagePicker = ImagePicker();
    XFile? _file = await _imagePicker.pickImage(source: source);
    if (_file != null) {
      return await _file.readAsBytes();
    }
    print('No Image Selected');
  }

  @override
  Widget build(BuildContext context) {
//     submitForm() async {
//       if(passwordController.text.isEmpty){
// toast("الرقم السرى لابد ان يكون اكثر من ستة عناصر", context);
//       }else{
//         await FirebaseAuthMethods().completeProfile(
//           licencePic: _licenceimageURL!,
//           istemaraPic: _istemaraimageURL!,
//           identityPic: _identityimageURL!,
//           fullname: nameController.text,
//           phoneNumber: phoneNumberController.text,
//           address: addressController.text,
//           context: context,
//         );
//       }
//      /* String res = await FirebaseAuthMethods().completeProfile(
//         licencePic: _licenceimageURL!,
//         istemaraPic: _istemaraimageURL!,
//         identityPic: _identityimageURL!,
//         fullname: nameController.text,
//         phoneNumber: phoneNumberController.text,
//         address: addressController.text,
//         context: context,
//       );*/
//       /* if (res == 'success') {
//         */ /* setState(() {
//           isLoading = false;
//         });*/ /*
//         toast("Saved Successfully.", context);
//        */ /* Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => HomeScreen(),
//           ),
//         );*/ /*
//       }*/
//     }

    return Scaffold(
      appBar: CustomAppBar(text: "تسجيل الدخول"),
      body: Consumer<AuthProvider>(
          builder: (context, AuthProvider authProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  Image.asset(
                    "images/logo.png",
                    width: 180,
                    height: 180,
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  CustomInput(
                    controller: nameController,
                    hint: "الاسم بالكامل",
                    textInputType: TextInputType.text,
                    suffixIcon: Icon(
                      Icons.person,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    controller: passwordController,
                    hint: "كلمة المرور",
                    textInputType: TextInputType.text,
                    obscureText: true,
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    controller: passwordConfirmationController,
                    hint: "تأكيد كلمة المرور",
                    textInputType: TextInputType.text,
                    obscureText: true,
                    suffixIcon: Icon(
                      Icons.lock,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    controller: emailController,
                    hint: "البريد الإلكتروني",
                    textInputType: TextInputType.emailAddress,
                    suffixIcon: Icon(
                      Icons.email,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    controller: phoneNumberController,
                    hint: "رقم الهاتف",
                    textInputType: TextInputType.phone,
                    suffixIcon: Icon(
                      Icons.phone,
                      color: Config.mainColor,
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomInput(
                    controller: addressController,
                    hint: "العنوان",
                    textInputType: TextInputType.text,
                    suffixIcon: Icon(
                      Icons.home,
                      color: Config.mainColor,
                    ),
                  ),
                  // const SizedBox(
                  //   height: 15,
                  // ),
                  // Row(
                  //   children: [
                  //     Expanded(
                  //       child: InkWell(
                  //         onTap: () async {
                  //          /* final ImagePicker _picker = ImagePicker();
                  //           file1 = await _picker.pickImage(
                  //               source: ImageSource.gallery);*/
                  //           //if (images == "") {
                  //          //   images = file1!.path;
                  //         //  } else {
                  //             selectedlicenceImage();
                  //          //   images = "$images,${file1!.path}";
                  //         //  }
                  //           setState(() {
                  //           //  selectedlicenceImage();
                  //           });
                  //         },
                  //         child: Container(
                  //           height: 80,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(15),
                  //               color: Config.mainColor),
                  //           child: /*file1 == null
                  //               ? Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     const Icon(Icons.photo),
                  //                     const SizedBox(
                  //                       height: 7,
                  //                     ),
                  //                     CustomText(
                  //                         text: "صورة الرخصة", fontSize: 11),
                  //                   ],
                  //                 )
                  //               :*/_licenceimageURL==null? Column(
                  //             mainAxisAlignment: MainAxisAlignment.center,
                  //             children: [
                  //               const Icon(Icons.photo),
                  //               const SizedBox(
                  //                 height: 7,
                  //               ),
                  //               CustomText(
                  //                   text: "صورة الرخصة", fontSize: 11),
                  //             ],
                  //           ):Image.memory(_licenceimageURL!,fit: BoxFit.fill,)/*Image.file(
                  //                   File(file1!.path),
                  //                   fit: BoxFit.fill,
                  //                 ),*/
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 7,
                  //     ),
                  //     Expanded(
                  //       child: InkWell(
                  //         onTap: () async {
                  //          /* final ImagePicker _picker = ImagePicker();
                  //           file2 = await _picker.pickImage(
                  //               source: ImageSource.gallery);
                  //           if (images == "") {
                  //             images = file2!.path;
                  //           } else {
                  //             selectedistemaraImage();
                  //             images = "$images,${file2!.path}";
                  //           }*/
                  //           selectedistemaraImage();
                  //           setState(() {
                  //            // selectedistemaraImage();
                  //           });
                  //         },
                  //         child: Container(
                  //           height: 80,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(15),
                  //               color: Config.mainColor),
                  //           child: _istemaraimageURL == null
                  //               ? Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     const Icon(Icons.photo),
                  //                     const SizedBox(
                  //                       height: 7,
                  //                     ),
                  //                     CustomText(
                  //                         text: "صورة الاستمارة", fontSize: 11),
                  //                   ],
                  //                 )
                  //               : Image.memory(_istemaraimageURL!,fit: BoxFit.fill,)/*Image.file(
                  //                   File(file2!.path),
                  //                   fit: BoxFit.fill,
                  //                 ),*/
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 7,
                  //     ),
                  //     Expanded(
                  //       child: InkWell(
                  //         onTap: () async {
                  //           /*final ImagePicker _picker = ImagePicker();
                  //           file3 = await _picker.pickImage(
                  //               source: ImageSource.gallery);
                  //           if (images == "") {
                  //             images = file3!.path;
                  //           } else {
                  //             selectedidentityImage();
                  //             images = "$images,${file3!.path}";
                  //           }*/
                  //           selectedidentityImage();
                  //           setState(() {
                  //
                  //            // selectedidentityImage();
                  //           });
                  //         },
                  //         child: Container(
                  //           height: 80,
                  //           decoration: BoxDecoration(
                  //               borderRadius: BorderRadius.circular(15),
                  //               color: Config.mainColor),
                  //           child: _identityimageURL == null
                  //               ? Column(
                  //                   mainAxisAlignment: MainAxisAlignment.center,
                  //                   children: [
                  //                     const Icon(Icons.photo),
                  //                     const SizedBox(
                  //                       height: 7,
                  //                     ),
                  //                     CustomText(
                  //                         text: "صورة الاقامة - الهوية",
                  //                         fontSize: 11),
                  //                   ],
                  //                 )
                  //               :Image.memory(_identityimageURL!,fit: BoxFit.fill,) /*Image.file(
                  //                   File(file3!.path),
                  //                   fit: BoxFit.fill,
                  //                 ),*/
                  //         ),
                  //       ),
                  //     ),
                  //     const SizedBox(
                  //       width: 7,
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      InkWell(
                        onTap: (){
                          Navigation.mainNavigator(context, const LoginScreen());
                        },
                        child: CustomText(
                          text: "دخول",
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const Spacer(),
                      CustomText(text: "نسيت كلمة المرور ؟", fontSize: 14),
                    ],
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  States.registerState == RegisterState.LOADING
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: "تسجيل",
                          onPressed: () async {
                            if (passwordController.text !=
                                passwordConfirmationController.text) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("كلمة المرور غير متطابقة"))));

                              // toast("كلمة المرور غير متطابقة", context);
                              return;
                            }
                            // if (_istemaraimageURL == null ||
                            //     _identityimageURL == null ||
                            //     _licenceimageURL == null) {
                            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("من فضلك املاء جميع الصور"))));
                            //
                            //   // toast("من فضلك املاء جميع الصور", context);
                            //   return;
                            // }
                            String? fcm = await getToken();

                             Map<String,String> formData = {
                          "name": nameController.text,
                          "email": emailController.text,
                          "phone": phoneNumberController.text,
                          "password": passwordController.text,
                          "address": addressController.text,
                          "type": "driver",
                          "token": fcm,
                        };
                             UserModel userModel = await authProvider.register(formData);
                            // /* UserModel userModel =*/ await FirebaseAuthMethods().completeProfile(formData,file1==null?"":file1!.path,file2==null?"":file2!.path,file3==null?"":file3!.path, profilePic: file1);
                            if(userModel.status!){
                          // setSavedString("jwt", userModel.data!.apiToken!);
                          setSavedString(
                              "userData", jsonEncode(userModel.data));
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("تم التسجيل بنجاح, بانتظار تفعيل الادمين"))));
                          Navigation.mainNavigator(context,  LoginScreen());
                        }else{
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text('رقم الهاتف او البريد الالكتروني يمتلك حساب من قبل'))));

                        }


                            // String res = await FirebaseAuthMethods().createUser(
                            //   email: emailController.text,
                            //   password: passwordController.text,
                            //   context: context,
                            // );
                            // if (res == 'success') {
                            //   // submitForm();
                            // //  toast("تم التسجيل بنجاح", context);
                            //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Directionality(textDirection: TextDirection.rtl,child: Text("تم التسجيل بنجاح"))));
                            //
                            //   Navigator.of(context).push(
                            //     MaterialPageRoute(
                            //       builder: (context) => HomeScreen(),
                            //     ),
                            //   );
                            // } else {}
                          }

                          )
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
