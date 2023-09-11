import 'package:flutter/material.dart';
// import 'package:rating_bar/rating_bar.dart';

import '../Helpers/Config.dart';
import '../Helpers/Config.dart';



class CustomInput extends StatelessWidget {
  String? hint;
  TextEditingController? controller;
  TextInputType? textInputType;
  Function? onChange;
  bool? obscureText;
  Widget? suffixIcon;
  Widget? prefixIcon;
  int? maxLines;
  CustomInput({@required this.controller,@required this.hint,@required this.textInputType,this.obscureText = false,this.prefixIcon,this.suffixIcon,this.onChange,this.maxLines});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(13),
        color: Colors.white,
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText??false,
        textAlign: TextAlign.right,
        validator: (v){
          if(v!.isEmpty) {
            return "هذا الحقل مطلوب";
          }
        },
        maxLines: maxLines??1,
        decoration: InputDecoration(
          hintText: hint,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          contentPadding: EdgeInsets.symmetric(horizontal: 10,vertical: Config.responsiveHeight(context)*0.0153),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Config.mainColor)
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Config.buttonColor)
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Config.mainColor)
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(13),
            borderSide: BorderSide(color: Config.mainColor)
          ),

        ),
      ),
    );
  }
}

class CustomText extends StatelessWidget {
  String? text;
  int? fontSize;
  TextAlign textAlign;
  FontWeight fontWeight;
  Color color;
  CustomText({Key? key,@required this.text,@required this.fontSize,this.textAlign = TextAlign.right,this.fontWeight = FontWeight.w400,this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(text!,textAlign: textAlign,style: TextStyle(color: color,fontSize: double.parse(fontSize.toString()),fontWeight: fontWeight),textDirection: TextDirection.rtl,);
  }
}


class CustomButton extends StatelessWidget {
  Color? color;
  int radius;
  String? text;
  Color? textColor;
  Function()? onPressed;
  CustomButton({Key? key,@required this.text,@required this.onPressed,this.color,this.radius = 15,this.textColor = Colors.white}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
    //  padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 50),
     /* shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(double.parse("$radius")),
      ),*/
     // color: color??Config.buttonColor,
      child: CustomText(text: text, fontSize: 16,fontWeight: FontWeight.w600,color: textColor!,),
    );
  }
}


AppBar CustomAppBar ({@required text,Widget? leading,List<Widget>? actions}){
  return AppBar(
    backgroundColor: Config.mainColor,
    title: CustomText(text: text, fontSize: 18,color: Colors.white,fontWeight: FontWeight.w600,),
    centerTitle: true,
    leading: leading,
    actions: actions,
  );
}

class ProductCard extends StatelessWidget {
  double rate;
  String? name,price,image,catName;
  Function()? onTap;
  ProductCard({Key? key,@required this.name,this.rate = 0.0,this.price = "0",this.image="",this.onTap,@ required this.catName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 7,
        child: Container(
        height: 170,width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white
          ),
          padding: const EdgeInsets.only(left: 8,right: 8,top: 8),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                  child: FadeInImage(placeholder: const AssetImage("images/homeBanner.png"),imageErrorBuilder: (context,builder,stackTrace)=>Image.asset("images/logo.png",width: 180,height: 180,), image: NetworkImage(image!),height: 120,width: double.infinity,fit: BoxFit.fill,)),
              const SizedBox(height: 7,),
              CustomText(text: "$price ر.س", fontSize: 11,textAlign: TextAlign.center,color: Config.buttonColor,),
              CustomText(text: name, fontSize: 16,textAlign: TextAlign.center,),
              CustomText(text: catName, fontSize: 11,textAlign: TextAlign.center,color: Config.buttonColor,)
            ],
          ),
        ),
      ),
    );
  }
}

class CategoriesCard extends StatelessWidget {
  String? name,image,color;
  Function()? onTap;
  CategoriesCard({Key? key,@required this.name,this.color = "888888",this.image="",this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        elevation: 7,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            FadeInImage(placeholder: const AssetImage("images/logo.png"),imageErrorBuilder: (context,builder,stackTrace)=>Image.asset("images/logo.png",width: 180,height: 180,), image: NetworkImage(image!),height: double.infinity,width: double.infinity,fit: BoxFit.fill,),
            Container(
              height: 35,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7),
                color: Color(int.parse("0xff$color"))
              ),
              child: CustomText(text: name, fontSize: 16,color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}

class CartCard extends StatelessWidget {
  String? image,text,desc,price;
  CartCard({Key? key,@required this.text,this.image = "",this.price = "0.00",this.desc=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topLeft,
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(width: 0.5,color: Config.mainColor)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 3,),
                  CustomText(text: text, fontSize: 16,fontWeight: FontWeight.w600,),
                  const SizedBox(height: 3,),
                  CustomText(text: desc, fontSize: 14,),
                  const SizedBox(height: 6,),
                  Row(
                    children: [
                      CustomText(text: "$price ريال", fontSize: 16,fontWeight: FontWeight.w600,),
                      const SizedBox(width: 5,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        alignment: Alignment.center,
                        child: CustomText(fontSize: 15,text: "-",),
                      ),
                      const SizedBox(width: 2,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 6),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(width: 0.3)
                        ),
                        child: CustomText(fontSize: 12,text: "1",),
                      ),
                      const SizedBox(width: 2,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        alignment: Alignment.center,
                        child: CustomText(fontSize: 15,text: "+",),
                      ),
                      const SizedBox(width: 2,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 15),
                        alignment: Alignment.center,
                        color: Config.buttonColor,
                        child: CustomText(fontSize: 12,text: "الكمية",color: Colors.white,),
                      ),
                      const SizedBox(width: 2,),
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 5),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.3,color: Colors.black)
                        ),
                        child: Image.asset("images/orders.png",height: 23,width: 23,),
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(width: 5,),
              FadeInImage(placeholder: const AssetImage("images/logo.png",),imageErrorBuilder: (context,builder,stackTrace)=>Image.asset("images/logo.png",width: 180,height: 180,), image: NetworkImage(image!),height: double.infinity,fit: BoxFit.fill,width: 100,),

            ],
          ),
        ),
        const Icon(Icons.close),
      ],
    );
  }
}


class DecoratedContainer extends StatelessWidget {
  double? height,width,radius,borderWidth;
  Color? borderColor;
  Alignment alignment;
  Widget? child;

  DecoratedContainer({Key? key,@required this.height,@required this.width,@required this.child,this.alignment = Alignment.center,this.borderColor,this.radius = 0,this.borderWidth}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,width: width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
        border: borderColor==null?null:Border.all(width: borderWidth!,color: borderColor!),
      ),
      alignment: alignment,
      child: child,
    );
  }
}

class OrderCard extends StatelessWidget {
  Function()? onTap;
  String status,vendorName,price,deliveryPrice,orderId;
  double? distance1,distance2;
  OrderCard({Key? key,this.onTap,required this.status,required this.deliveryPrice,required this.vendorName,this.distance1,this.distance2,required this.price,required this.orderId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(distance2);
    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        elevation: 7,
        child: Container(
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.all(10),
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Column(
            children: [
              Expanded(
                flex: 5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Image.asset("images/home2.png",height: 30,width: 30,),
                        CustomText(text: "العميل", fontSize: 16,fontWeight: FontWeight.w600,)
                      ],
                    ),
                    status=="online"?Column(
                      children: [
                        CustomText(text: "${(distance2!/1000).toString().length>7?(distance2!/1000).toString().substring(0,6):(distance2!/1000)}كم", fontSize: 11,fontWeight: FontWeight.w600,),
                        Image.asset("images/arrow.png",width: 50,),
                      ],
                    ):status=="onproccess"?Column(
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            width: Config.responsiveWidth(context)*0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.redAccent
                            ),
                            alignment: Alignment.center,
                            child: CustomText(text: "التوجه للعميل", fontSize: 13,color: Colors.white,textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    ):const SizedBox(),
                    Column(
                      children: [
                        Image.asset("images/store.png",height: 30,width: 30,),
                        CustomText(text: "المتجر", fontSize: 16,fontWeight: FontWeight.w600,)
                      ],
                    ),
                    status=="online"?Column(
                      children: [
                        CustomText(text: "${(distance1!/1000).toString().length>7?(distance1!/1000).toString().substring(0,6):(distance1!/1000)}كم", fontSize: 11,fontWeight: FontWeight.w600,),
                        Image.asset("images/arrow.png",width: 50,),
                      ],
                    ):status=="onproccess"?Column(
                      children: [
                        InkWell(
                          onTap: (){

                          },
                          child: Container(
                            width: Config.responsiveWidth(context)*0.15,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.redAccent
                            ),
                            alignment: Alignment.center,
                            child: CustomText(text: "التوجه للتاجر", fontSize: 13,color: Colors.white,textAlign: TextAlign.center,),
                          ),
                        ),
                      ],
                    ):const SizedBox(),
                    Column(
                      children: [
                        Image.asset("images/client.png",height: 30,width: 30,),
                        CustomText(text: "انت", fontSize: 16,fontWeight: FontWeight.w600,)
                      ],
                    ),
                    Image.asset("images/logo.png",width: 80,),
                  ],
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  children: [
                    Column(
                      children: [
                        CustomText(text: "سعر الطلب", fontSize: 14,),
                        Container(
                          height: 30,
                          width: Config.responsiveWidth(context)*0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.redAccent
                          ),
                          alignment: Alignment.center,
                          child: CustomText(text: " $price ر.س ", fontSize: 14,color: Colors.white,),
                        ),
                      ],
                    ),
                    const SizedBox(width: 20,),
                    Column(
                      children: [
                        CustomText(text: "سعر التوصيل", fontSize: 14,),
                        Container(
                          height: 30,
                          width: Config.responsiveWidth(context)*0.2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.redAccent
                          ),
                          alignment: Alignment.center,
                          child: CustomText(text: "$deliveryPrice ر.س", fontSize: 14,color: Colors.white,),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      width: Config.responsiveWidth(context)*0.2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Config.buttonColor
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          CustomText(text: "رقم الطلب", fontSize: 14,color: Colors.white,),
                          CustomText(text: orderId, fontSize: 14,color: Colors.white,),
                        ],
                      ),
                    ),

                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
