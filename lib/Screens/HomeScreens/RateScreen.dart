
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

import '../../Components/Components.dart';
import '../../Providers/Home/HomeProvider.dart';
import '../../Providers/Home/HomeStates.dart';
class RateScreen extends StatefulWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  _RateScreenState createState() => _RateScreenState();
}

class _RateScreenState extends State<RateScreen> {
  HomeProvider? homeProvider;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(text: "التقييم"),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30,),
            Image.asset("images/logo.png",width: 180,height: 180,),
            const SizedBox(height: 30,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                RatingBarIndicator(
                  rating: double.parse(/*homeProvider!.response!['rate']*/5.toString()),
                  direction: Axis.horizontal,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => const Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(width: 10,),
                CustomText(text: "تقييمك هو ", fontSize: 20,fontWeight: FontWeight.w600,)
              ],
            )
          ],
        ),
      ), /*ChangeNotifierProvider(
        create: (BuildContext context)  => HomeProvider()..getRate(),
        child: Selector<HomeProvider,ReasonsState>(
          selector: (context,provider){
            homeProvider = provider;
            return HomeStates.reasonsState;
          },

          builder: (context, state,child) {
            if(state == ReasonsState.LOADING){
              return const Center(child: CircularProgressIndicator());
            }
            if(state == ReasonsState.ERROR){
              return Center(child: CustomText(text: "حدث خطأ", fontSize: 16),);
            }
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30,),
                  Image.asset("images/logo.png",width: 180,height: 180,),
                  const SizedBox(height: 30,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RatingBarIndicator(
                        rating: double.parse(homeProvider!.response!['rate'].toString()),
                        direction: Axis.horizontal,
                        itemCount: 5,
                        itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      const SizedBox(width: 10,),
                      CustomText(text: "تقييمك هو ", fontSize: 20,fontWeight: FontWeight.w600,)
                    ],
                  )
                ],
              ),
            );
          }
        ),
      ),*/
    );
  }
}
