import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Components/Components.dart';
import '../../Providers/Home/HomeProvider.dart';
import '../../Providers/Home/HomeStates.dart';

class TermsScreen extends StatefulWidget {
  String? type;
  TermsScreen({Key? key,this.type}) : super(key: key);

  @override
  _TermsScreenState createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: CustomAppBar(text: widget.type=="about"?"معلومات عننا":widget.type=="privcy"?"سياسة الخصوصية":"الشروط والأحكام"),
      body:
      // StreamBuilder(
      //     stream: FirebaseFirestore.instance
      //         .collection("terms")
      //         .snapshots(),
      //     builder: (context,
      //         AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
      //       if (snapshot.connectionState == ConnectionState.waiting) {
      //         return Center(
      //           child: CircularProgressIndicator(
      //             color: Colors.white,
      //           ),
      //         );
      //       }
      //       return  Directionality(
      //         textDirection: TextDirection.rtl,
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Text(snapshot.data!.docs.first["text"],style: TextStyle(
      //             fontSize: 16,
      //           ),
      //             maxLines: 15,
      //             overflow: TextOverflow.ellipsis,
      //           ),
      //         ),
      //       );
      //     }),

      ChangeNotifierProvider(
        create: (BuildContext context) => HomeProvider()..terms(widget.type),
        child: Consumer<HomeProvider>(
          builder: (context, provider,child) {
            if(HomeStates.fetchTermsState == FetchTermsState.LOADING || provider.termsResponse == null){
              return const Center(child: CircularProgressIndicator());
            }
              return Center(
              child: CustomText(text: provider.termsResponse!['data'], fontSize: 16),
            );
          }
        ),
      ),
    );
  }
}
