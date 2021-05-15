import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:flutter/material.dart';

import 'clippers.dart';


class CustomDealerAppBar extends StatelessWidget with PreferredSizeWidget{


  final Size preferredSize;
  DataRepository dataRepository = DataRepository();
  CustomDealerAppBar(
  { Key key,}) : preferredSize = Size.fromHeight(120.0),
        super(key: key);


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 15.0,
        ),
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: 110,
            decoration: BoxDecoration(
              color: Style.yellowColor,
            ),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance.collection('dealers').doc(dataRepository.userId).snapshots(),
              builder:(context, AsyncSnapshot<DocumentSnapshot> snapshot)  {


                if(!snapshot.hasData||snapshot.hasError){
                  return CircularProgressIndicator(backgroundColor: Style.yellowColor,);
                }else if(snapshot.connectionState == ConnectionState.active){
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top:30.0),
                        child: Center(child: Text(snapshot.data['dealerName'],
                          style: Style.headerTextStyle,
                        )),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top:10.0),
                        child: Center(child: Text('Last Updated at 16:00 hrs',
                          style: Style.normalTextStyle,
                        )),
                      )
                    ],
                  );
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator(backgroundColor: Style.yellowColor,);
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:30.0),
                      child: Center(child: Text(snapshot.data['dealerName'],
                        style: Style.headerTextStyle,
                      )),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top:10.0),
                      child: Center(child: Text('Last Updated at 16:00 hrs',
                        style: Style.normalTextStyle,
                      )),
                    )
                  ],
                );
              }
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),

      ],
    );
  }


}
