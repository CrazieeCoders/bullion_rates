import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_bloc/bloc/buyer_dashboard_bloc/buyer_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/buyer_dashboard_bloc/buyer_state.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:firebase_phone_auth_bloc/ui_stylers/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class BuyerDashBoard extends StatefulWidget {
  @override
  _BuyerDashBoardState createState() => _BuyerDashBoardState();
}

class _BuyerDashBoardState extends State<BuyerDashBoard> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuyerBloc>(
      create: (context)=>BuyerBloc(),
      child: Scaffold(
        appBar: CustomAppBar(),
        body:StreamBuilder(
          stream:  FirebaseFirestore.instance.collection('dealers').snapshots(),
            builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){

              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator(
                  backgroundColor: Style.yellowColor,
                ));
              }else if(snapshot.hasError){
                return Center(child: Text('no data available,please check with your admin ',
                style: Style.errorTextStyle,));
              }else if(snapshot.data.docs.length == 0){
              return Center(child: Text('There are no dealers available',
              style: Style.normalTextStyle,
              ));
              }else if(snapshot.connectionState == ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(
                  backgroundColor: Style.yellowColor,
                ));
              }else if(snapshot.connectionState == ConnectionState.active){
                return ListView(
                  children:snapshot.data.docs.map((doc){
                    return ListBuilder(doc);
                  }).toList(),
                );
              }
              return ListView(
                children:snapshot.data.docs.map((doc){
                  return ListBuilder(doc);
                }).toList(),
              );

            }
        ),
      ),
    );
  }

  Widget ListBuilder(DocumentSnapshot dealerSnapshot){
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('quote').doc(dealerSnapshot.id).snapshots(),
      builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> quoteSnapshot){

        if(!quoteSnapshot.hasData){
          return Center(child: Text('There are no dealers available',
            style: Style.errorTextStyle,
          ));
        }else if(!quoteSnapshot.hasData){
          return Center(child: CircularProgressIndicator(
            backgroundColor: Style.yellowColor,
          ));
        } else if(quoteSnapshot.hasError){
          return Center(child: Text('no data available,please check with your admin ',
            style: Style.errorTextStyle,));
        }else if(quoteSnapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator(
            backgroundColor: Style.yellowColor,
          ));
        }else if(quoteSnapshot.hasData){
          return  Column(
            children: [
              SizedBox(
                height: 30.0,
              ),

              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color:Style.halfWhiteColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2.0,
                        )
                      ]
                  ),
                  child: BlocBuilder<BuyerBloc,BuyerState>(
                    builder: (context,state){

                      if(state is BuyerLoadingState){
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Style.yellowColor,
                          ),
                        );
                      }else if(state is GoldPressedState){
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Center(child: Text(dealerSnapshot['dealerName'],
                                style: Style.subHeaderTextStyle,
                              )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SubHeaders(),
                            SizedBox(
                              height: 10.0,
                            ),
                            BuyRow(quoteSnapshot,'gold'),
                            SizedBox(
                              height: 10.0,
                            ),
                            SellRow(quoteSnapshot,'gold')

                          ],
                        );

                      }else if (state is SilverPressedState){
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Center(child: Text(dealerSnapshot['dealerName'],
                                style: Style.subHeaderTextStyle,
                              )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SubHeaders(),
                            SizedBox(
                              height: 10.0,
                            ),
                            BuyRow(quoteSnapshot,'silver'),
                            SizedBox(
                              height: 10.0,
                            ),
                            SellRow(quoteSnapshot,'silver')

                          ],
                        );
                      }
                      return Text('Error in Buyer_page Dashboard line 86');

                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:50.0,right: 50.0),
                child: Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      color: Style.lightBlueColor,

                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                        )
                      ]
                  ),
                  child: Center(child: Text('Last updated at 16:00',
                    style: Style.hintTextStyle,)),
                ),
              ),

            ],
          );
        }else if(quoteSnapshot.connectionState == ConnectionState.active){
          return  Column(
            children: [
              SizedBox(
                height: 30.0,
              ),

              Padding(
                padding: const EdgeInsets.only(left:8.0,right: 8.0),
                child: Container(
                  height: 200,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                      color:Style.halfWhiteColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 2.0,
                        )
                      ]
                  ),
                  child: BlocBuilder<BuyerBloc,BuyerState>(
                    builder: (context,state){

                      if(state is BuyerLoadingState){
                        return Center(
                          child: CircularProgressIndicator(
                            backgroundColor: Style.yellowColor,
                          ),
                        );
                      }else if(state is GoldPressedState){
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Center(child: Text(dealerSnapshot['dealerName'],
                                style: Style.subHeaderTextStyle,
                              )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SubHeaders(),
                            SizedBox(
                              height: 10.0,
                            ),
                            BuyRow(quoteSnapshot,'gold'),
                            SizedBox(
                              height: 10.0,
                            ),
                            SellRow(quoteSnapshot,'gold')

                          ],
                        );

                      }else if (state is SilverPressedState){
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: Center(child: Text(dealerSnapshot['dealerName'],
                                style: Style.subHeaderTextStyle,
                              )),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            SubHeaders(),
                            SizedBox(
                              height: 10.0,
                            ),
                            BuyRow(quoteSnapshot,'silver'),
                            SizedBox(
                              height: 10.0,
                            ),
                            SellRow(quoteSnapshot,'silver')

                          ],
                        );
                      }
                      return Text('Error in Buyer_page Dashboard line 86');

                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:50.0,right: 50.0),
                child: Container(
                  height: 30.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      color: Style.lightBlueColor,

                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                        )
                      ]
                  ),
                  child: Center(child: Text('Last updated at 16:00',
                    style: Style.hintTextStyle,)),
                ),
              ),

            ],
          );
        }
        return  Column(
          children: [
            SizedBox(
              height: 30.0,
            ),

            Padding(
              padding: const EdgeInsets.only(left:8.0,right: 8.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                      10.0,
                    ),
                    color:Style.halfWhiteColor,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 2.0,
                      )
                    ]
                ),
                child: BlocBuilder<BuyerBloc,BuyerState>(
                  builder: (context,state){

                    if(state is BuyerLoadingState){
                      return Center(
                        child: CircularProgressIndicator(
                         backgroundColor: Style.yellowColor,
                        ),
                      );
                    }else if(state is GoldPressedState){
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Center(child: Text(dealerSnapshot['dealerName'],
                              style: Style.subHeaderTextStyle,
                            )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SubHeaders(),
                          SizedBox(
                            height: 10.0,
                          ),
                          BuyRow(quoteSnapshot,'gold'),
                          SizedBox(
                            height: 10.0,
                          ),
                          SellRow(quoteSnapshot,'gold')

                        ],
                      );

                    }else if (state is SilverPressedState){
                      return Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top:8.0),
                            child: Center(child: Text(dealerSnapshot['dealerName'],
                              style: Style.subHeaderTextStyle,
                            )),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SubHeaders(),
                          SizedBox(
                            height: 10.0,
                          ),
                          BuyRow(quoteSnapshot,'silver'),
                          SizedBox(
                            height: 10.0,
                          ),
                          SellRow(quoteSnapshot,'silver')

                        ],
                      );
                    }
                      return Text('Error in Buyer_page Dashboard line 86');

                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:50.0,right: 50.0),
              child: Container(
                height: 30.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0),
                    ),
                    color: Style.lightBlueColor,

                    boxShadow: [
                      BoxShadow(
                        blurRadius: 0.0,
                      )
                    ]
                ),
                child: Center(child: Text('Last updated at 16:00',
                  style: Style.hintTextStyle,)),
              ),
            ),

          ],
        );

      },
    );
  }


  Widget SubHeaders(){
    return  Row(
      children: [
        SizedBox(
          width: 110.0,
        ),
        Text('Pure',
          style: Style.columnTextStyle,),
        SizedBox(
          width: 70.0,
        ),
        Text('Ft',
            style: Style.columnTextStyle),
        SizedBox(
          width: 80.0,
        ),
        Text('Kacha',
            style: Style.columnTextStyle)
      ],
    );
  }


  Widget BuyRow(AsyncSnapshot quoteSnapshot,String product){

    return  Row(
      children: [
        SizedBox(
          width: 10.0,
        ),
        Text('BuyPrice :',
          style: Style.normalTextStyle,),
        SizedBox(
          width: 10.0,
        ),

        Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
              color: Style.orangeColor,
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Center(
            child: Text(
                quoteSnapshot.data['${product}buy.pure'],
                style: Style.subTextStyle
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
              color: Style.orangeColor,
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Center(
            child: Text(
                quoteSnapshot.data['${product}buy.ft'],
                style: Style.subTextStyle
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
              color: Style.orangeColor,
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Center(
            child: Text(
                quoteSnapshot.data['${product}buy.kacha'],
                style: Style.subTextStyle
            ),
          ),
        ),

      ],
    );

  }

  Widget SellRow(AsyncSnapshot quoteSnapshot,String product){

    return  Row(
      children: [
        SizedBox(
          width: 10.0,
        ),
        Text('SellPrice :',
          style: Style.normalTextStyle,),
        SizedBox(
          width: 10.0,
        ),

        Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
              color: Style.orangeColor,
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Center(
            child: Text(
                quoteSnapshot.data['${product}sell.pure'],
                style: Style.subTextStyle
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
              color: Style.orangeColor,
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Center(
            child: Text(
                quoteSnapshot.data['${product}sell.ft'],
                style: Style.subTextStyle
            ),
          ),
        ),
        SizedBox(
          width: 10.0,
        ),
        Container(
          height: 40,
          width: 90,
          decoration: BoxDecoration(
              color: Style.orangeColor,
              borderRadius: BorderRadius.circular(5.0)
          ),
          child: Center(
            child: Text(
                quoteSnapshot.data['${product}sell.kacha'],
                style: Style.subTextStyle
            ),
          ),
        ),

      ],
    );

  }
}
