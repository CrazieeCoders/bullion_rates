import 'package:firebase_phone_auth_bloc/bloc/dealerbloc/dealer_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/dealerbloc/dealer_event.dart';
import 'package:firebase_phone_auth_bloc/bloc/dealerbloc/dealer_state.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:firebase_phone_auth_bloc/ui_stylers/custom_appbar_dealer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DealerDashBoardProvider extends StatefulWidget {

  final DataRepository dataRepository;

  DealerDashBoardProvider({this.dataRepository});

  @override
  _DealerDashBoardProviderState createState() => _DealerDashBoardProviderState();
}

class _DealerDashBoardProviderState extends State<DealerDashBoardProvider> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DealerBloc>(
        create: (context) => DealerBloc(dataRepository: widget.dataRepository), child: DealerDashboard(dataRepository: widget.dataRepository,));
  }
}

class DealerDashboard extends StatefulWidget {

  final DataRepository dataRepository;

  DealerDashboard({this.dataRepository});

  @override
  _DealerDashboardState createState() => _DealerDashboardState();
}

class _DealerDashboardState extends State<DealerDashboard> {
  TextEditingController _pureTextController = TextEditingController();
  TextEditingController _kachaTextController = TextEditingController();
  TextEditingController _ftTextController = TextEditingController();
  String text = '5000';

  DealerBloc _dealerBloc;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference quoteRef =
      FirebaseFirestore.instance.collection('quote');
  final FirebaseAuth auth = FirebaseAuth.instance;
  String dealerName = 'Name of the dealer';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  Future<DocumentSnapshot> getUserInfo()async{
    User user = FirebaseAuth.instance.currentUser;
    return await quoteRef.doc(user.uid).get();
  }


  @override
  Widget build(BuildContext context) {
    _dealerBloc = BlocProvider.of<DealerBloc>(context);
    final User user = auth.currentUser;

    return Scaffold(
        appBar:CustomDealerAppBar(),
        body: BlocBuilder<DealerBloc,DealerState>(
         builder: (context,state){
           return Container(
             child: ListView(
               children: [
                 Container(
                   child: bodyAsPerState(state),
                 ),
                 SizedBox(
                   height: 45.0,
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     height: 100,
                     width: 400,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10.0),
                         color:Colors.white,
                         boxShadow: [
                           BoxShadow(
                             blurRadius: 6.0,
                           )
                         ]),
                     child: Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text(
                                 'PURE',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 height: 7.0,
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           width: 10.0,
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               height: 50,
                               width: 300,
                               decoration: BoxDecoration(
                                   color: Colors.white,
                                   borderRadius: BorderRadius.circular(10.0),
                                   boxShadow: [
                                     BoxShadow(
                                       blurRadius: 4.0,
                                     ),
                                   ]),
                               child: Center(
                                   child: Row(
                                     children: [
                                       SizedBox(
                                         width: 110,
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 28.0),
                                         child: GestureDetector(
                                           child: Container(
                                             height: 70,
                                             width: 90,

                                             child: Center(
                                               child: TextFormField(
                                                 cursorColor: Colors.black,
                                                 controller: _pureTextController,
                                                 onChanged: (String newVal) {
                                                   if (newVal.length <= 5) {
                                                     text = newVal;
                                                   } else {
                                                     _pureTextController.value =
                                                     new TextEditingValue(
                                                         text: text,
                                                         selection: new TextSelection(
                                                           baseOffset: 5,
                                                           extentOffset: 5,
                                                           affinity:
                                                           TextAffinity.upstream,
                                                           isDirectional: false,
                                                         ),
                                                         composing: new TextRange(
                                                             start: 0, end: 5));
                                                     _pureTextController.text = text;
                                                   }
                                                 },
                                                 keyboardType: TextInputType.number,
                                                 maxLength: 5,
                                                 decoration: InputDecoration(
                                                     counter: Offstage(),
                                                     border: InputBorder.none),
                                                 style: TextStyle(
                                                     fontWeight: FontWeight.bold,
                                                     fontStyle: FontStyle.italic,
                                                     fontSize: 22.0),
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                       SizedBox(
                                         width: 60,
                                       ),
                                       Icon(
                                         Icons.upload_outlined,
                                         size: 30.0,
                                         color: Style.orangeColor,
                                       ),
                                     ],
                                   )),
                             ),
                             GestureDetector(
                               onTap: () {

                                 if(state is GoldBuyState){
                                   quoteRef.doc(user.uid).update({
                                     'goldbuy.pure':_pureTextController.text,


                                   });
                                 }else if(state is GoldSellState){
                                   quoteRef.doc(user.uid).update({
                                     'goldsell.pure':_pureTextController.text,
                                     },
                                   );
                                 }else if(state is SilverBuyState){
                                   quoteRef.doc(user.uid).update({
                                     'silverbuy.pure':_pureTextController.text,

                                   });
                                 }else if(state is SilverSellState){
                                   quoteRef.doc(user.uid).update({
                                     'silversell.pure':_pureTextController.text,

                                   },);
                                 }

                                 _pureTextController.clear();

                                 Scaffold.of(context)..hideCurrentSnackBar()..showSnackBar(
                                   SnackBar(content: Row(
                                     children: [
                                       Text('Pure rate updated'),
                                     ],
                                   ),)
                                 );


                               },
                               child: Container(
                                 height: 30,
                                 width: 300,
                                 decoration: BoxDecoration(
                                     color: Style.yellowColor,
                                     borderRadius: BorderRadius.circular(10.0),
                                     boxShadow: [
                                       BoxShadow(
                                         blurRadius: 4.0,
                                       ),
                                     ]),
                                 child: Center(
                                   child: Text(
                                     'UPLOAD',
                                     style:Style.subHeaderTextStyle,
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 30.0,
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     height: 100,
                     width: 400,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10.0),
                         color: Colors.white,
                         boxShadow: [
                           BoxShadow(
                             blurRadius: 6.0,
                           )
                         ]),
                     child: Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text(
                                 'KACHA',
                                 style: Style.subHeaderTextStyle
                               ),
                               SizedBox(
                                 height: 7.0,
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           width: 5.0,
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               height: 50,
                               width: 300,
                               decoration: BoxDecoration(
                                   color:Colors.white,
                                   borderRadius: BorderRadius.circular(10.0),
                                   boxShadow: [
                                     BoxShadow(
                                       blurRadius: 4.0,
                                     ),
                                   ]),
                               child: Center(
                                   child: Row(
                                     children: [
                                       SizedBox(
                                         width: 110,
                                       ),
                                       Padding(
                                         padding: const EdgeInsets.only(top: 28.0),
                                         child: Container(
                                           height: 70,
                                           width: 90,
                                           child: Center(
                                             child: TextFormField(
                                               cursorColor: Colors.black,
                                               controller: _kachaTextController,
                                               onChanged: (String newVal) {
                                                 if (newVal.length <= 5) {
                                                   text = newVal;
                                                 } else {
                                                   _kachaTextController.value =
                                                   new TextEditingValue(
                                                       text: text,
                                                       selection: new TextSelection(
                                                         baseOffset: 5,
                                                         extentOffset: 5,
                                                         affinity:
                                                         TextAffinity.upstream,
                                                         isDirectional: false,
                                                       ),
                                                       composing: new TextRange(
                                                           start: 0, end: 5));
                                                   _kachaTextController.text = text;
                                                 }
                                               },
                                               keyboardType: TextInputType.number,
                                               maxLength: 5,
                                               decoration: InputDecoration(
                                                   counter: Offstage(),
                                                   border: InputBorder.none),
                                               style: TextStyle(
                                                   fontWeight: FontWeight.bold,
                                                   fontStyle: FontStyle.italic,
                                                   fontSize: 22.0),
                                             ),
                                           ),
                                         ),
                                       ),
                                       SizedBox(
                                         width: 60,
                                       ),
                                       Center(
                                         child: Icon(
                                           Icons.upload_outlined,
                                           size: 30.0,
                                           color: Style.orangeColor,
                                         ),
                                       ),
                                     ],
                                   )),
                             ),
                             GestureDetector(
                               onTap: (){

                                 if(state is GoldBuyState){
                                   quoteRef.doc(user.uid).update({
                                     'goldbuy.kacha':_kachaTextController.text,
                                   });
                                 }else if(state is GoldSellState){
                                   quoteRef.doc(user.uid).update({
                                     'goldsell.kacha': _kachaTextController.text,
                                   });
                                 }else if(state is SilverBuyState){
                                   quoteRef.doc(user.uid).update({
                                     'silverbuy.kacha':_kachaTextController.text,
                                   });
                                 }else if(state is SilverSellState){
                                   quoteRef.doc(user.uid).update({
                                     'silversell.kacha':_kachaTextController.text,
                                   },);
                                 }

                                 _kachaTextController.clear();

                                 Scaffold.of(context)..hideCurrentSnackBar()..showSnackBar(
                                     SnackBar(content: Row(
                                       children: [
                                         Text('kacha rate updated'),
                                       ],
                                     ),)
                                 );



                               },
                               child: Container(
                                 height: 30,
                                 width: 300,
                                 decoration: BoxDecoration(
                                     color: Style.yellowColor,
                                     borderRadius: BorderRadius.circular(10.0),
                                     boxShadow: [
                                       BoxShadow(
                                         blurRadius: 4.0,
                                       ),
                                     ]),
                                 child: Center(
                                   child: Text(
                                     'UPLOAD',
                                     style: Style.subHeaderTextStyle
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 30.0,
                 ),
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Container(
                     height: 100,
                     width: 400,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10.0),
                         color: Style.whiteColor,
                         boxShadow: [
                           BoxShadow(
                             blurRadius: 6.0,
                           )
                         ]),
                     child: Row(
                       children: [
                         Padding(
                           padding: const EdgeInsets.all(8.0),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text(
                                 'FT',
                                 style:Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 height: 7.0,
                               ),
                             ],
                           ),
                         ),
                         SizedBox(
                           width: 50.0,
                         ),
                         Column(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Container(
                               height: 50,
                               width: 300,
                               decoration: BoxDecoration(
                                   color: Style.whiteColor,
                                   borderRadius: BorderRadius.circular(10.0),
                                   boxShadow: [
                                     BoxShadow(
                                       blurRadius: 4.0,
                                     ),
                                   ]),
                               child: Row(
                                 children: [
                                   SizedBox(
                                     width: 110,
                                   ),
                                   Padding(
                                     padding: const EdgeInsets.only(top: 28.0),
                                     child: Container(
                                       height: 70,
                                       width: 90,
                                       child: Center(
                                         child: TextFormField(
                                           cursorColor: Colors.black,
                                           controller: _ftTextController,
                                           onChanged: (String newVal) {
                                             if (newVal.length <= 5) {
                                               text = newVal;
                                             } else {
                                               _ftTextController.value =
                                               new TextEditingValue(
                                                 text: text,
                                                 selection: new TextSelection(
                                                   baseOffset: 5,
                                                   extentOffset: 5,
                                                   affinity: TextAffinity.upstream,
                                                   isDirectional: false,
                                                 ),
                                                 composing:
                                                 new TextRange(start: 0, end: 5),
                                               );
                                               _ftTextController.text = text;
                                             }
                                           },
                                           keyboardType: TextInputType.number,
                                           maxLength: 5,
                                           decoration: InputDecoration(
                                             counter: Offstage(),
                                             border: InputBorder.none,
                                           ),
                                           style: TextStyle(
                                               fontWeight: FontWeight.bold,
                                               fontStyle: FontStyle.italic,
                                               fontSize: 22.0),
                                         ),
                                       ),
                                     ),
                                   ),
                                   SizedBox(
                                     width: 60,
                                   ),
                                   Center(
                                     child: Icon(
                                       Icons.upload_outlined,
                                       size: 30.0,
                                       color: Style.orangeColor,
                                     ),
                                   ),
                                 ],
                               ),
                             ),
                             GestureDetector(
                               onTap: (){
                                 if(state is GoldBuyState){
                                   quoteRef.doc(user.uid).update({
                                     'goldbuy.ft':_ftTextController.text,
                                   });
                                 }else if(state is GoldSellState){
                                   quoteRef.doc(user.uid).update({
                                     'goldsell.ft':_ftTextController.text,
                                   });
                                 }else if(state is SilverBuyState){
                                   quoteRef.doc(user.uid).update({
                                     'silverbuy.ft':_ftTextController.text,

                                   });
                                 }else if(state is SilverSellState){
                                   quoteRef.doc(user.uid).update({
                                     'silversell.ft':_ftTextController.text,
                                   },);
                                 }

                                 _ftTextController.clear();

                                 Scaffold.of(context)..hideCurrentSnackBar()..showSnackBar(
                                     SnackBar(content: Row(
                                       children: [
                                         Text('ft rate updated'),
                                       ],
                                     ),)
                                 );



                               },
                               child: Container(
                                 height: 30,
                                 width: 300,
                                 decoration: BoxDecoration(
                                     color: Style.yellowColor,
                                     borderRadius: BorderRadius.circular(10.0),
                                     boxShadow: [
                                       BoxShadow(
                                         blurRadius: 4.0,
                                       ),
                                     ]),
                                 child: Center(
                                   child: Text(
                                     'UPLOAD',
                                     style: Style.subHeaderTextStyle
                                   ),
                                 ),
                               ),
                             ),
                           ],
                         ),
                       ],
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 120.0,
                 ),
               ],
             ),
           );
         },
      ),
    );
  }

  bodyAsPerState(DealerState state) {

    if (state is GoldBuyState) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _dealerBloc.add(EventGoldBuyPressed()),
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      color:Style.yellowColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6.0,
                        )
                      ]
                  ),
                  child: Center(
                      child: Text(
                    'GOLD',
                        style: Style.normalTextStyle,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () => _dealerBloc.add(EventSilverBuyPressed()),
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      color:Style.halfWhiteColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                        )
                      ]
                  ),
                  child: Center(
                      child: Text(
                    'SILVER',
                        style: Style.normalTextStyle,
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: EdgeInsets.only(left: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (state is GoldSellState) {
                      _dealerBloc.add(EventGoldBuyPressed());
                    } else if (state is SilverSellState) {
                      _dealerBloc.add(EventSilverBuyPressed());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        color:Style.orangeColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                          )
                        ]
                    ),
                    child: Center(
                        child: Text(
                      'BUY PRICE',
                          style: Style.normalTextStyle,
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (state is GoldBuyState) {
                      _dealerBloc.add(EventGoldSellPressed());
                    } else if (state is SilverBuyState) {
                      _dealerBloc.add(EventSilverSellPressed());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        color:Style.lightBlueColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.0,
                          )
                        ]
                    ),
                    child: Center(
                        child: Text(
                      'SELL PRICE',
                          style: Style.normalTextStyle,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (state is GoldSellState) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () => _dealerBloc.add(EventGoldBuyPressed()),
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      color:Style.yellowColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6.0,
                        )
                      ]
                  ),
                  child: Center(
                      child: Text(
                    'GOLD',
                        style: Style.normalTextStyle,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () => _dealerBloc.add(EventSilverBuyPressed()),
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      color:Style.halfWhiteColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                        )
                      ]
                  ),
                  child: Center(
                      child: Text(
                    'SILVER',
                        style: Style.normalTextStyle,
                  )),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left:60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    if (state is GoldSellState) {
                      _dealerBloc.add(EventGoldBuyPressed());
                    } else if (state is SilverSellState) {
                      _dealerBloc.add(EventSilverBuyPressed());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        color:Style.orangeColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.0,
                          )
                        ]
                    ),
                    child: Center(
                        child: Text(
                      'BUY PRICE',
                          style: Style.normalTextStyle,
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (state is GoldBuyState) {
                      _dealerBloc.add(EventGoldSellPressed());
                    } else if (state is SilverBuyState) {
                      _dealerBloc.add(EventSilverSellPressed());
                    }
                  },
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        color:Style.lightBlueColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                          )
                        ]
                    ),
                    child: Center(
                        child: Text(
                      'SELL PRICE',
                          style: Style.normalTextStyle,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (state is SilverBuyState) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _dealerBloc.add(EventGoldBuyPressed()),
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        color:Style.yellowColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.0,
                          )
                        ]
                    ),
                    child: Center(
                        child: Text(
                      'GOLD',
                          style: Style.normalTextStyle,
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () => _dealerBloc.add(EventSilverBuyPressed()),
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        color:Style.halfWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                          )
                        ]
                    ),
                    child: Center(
                        child: Text(
                      'SILVER',
                          style: Style.normalTextStyle,
                    )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (state is GoldSellState) {
                    _dealerBloc.add(EventGoldBuyPressed());
                  } else if (state is SilverSellState) {
                    _dealerBloc.add(EventSilverBuyPressed());
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      color:Style.orangeColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6.0,
                        )
                      ]
                  ),
                  child: Center(
                      child: Text(
                    'BUY PRICE',
                        style: Style.normalTextStyle,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (state is GoldBuyState) {
                    _dealerBloc.add(EventGoldSellPressed());
                  } else if (state is SilverBuyState) {
                    _dealerBloc.add(EventSilverSellPressed());
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      color:Style.lightBlueColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                        )
                      ]
                  ),
                  child: Center(
                      child: Text(
                    'SELL PRICE',
                        style: Style.normalTextStyle,
                  )),
                ),
              ),
            ],
          ),
        ],
      );
    } else if (state is SilverSellState) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left:60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => _dealerBloc.add(EventGoldBuyPressed()),
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        color:Style.yellowColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 0.0,
                          )
                        ]
                    ),
                    child: Center(
                        child: Text(
                      'GOLD',
                          style: Style.normalTextStyle,
                    )),
                  ),
                ),
                GestureDetector(
                  onTap: () => _dealerBloc.add(EventSilverBuyPressed()),
                  child: Container(
                    height: 40,
                    width: 150,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(6.0),
                          bottomLeft: Radius.circular(6.0),
                        ),
                        color:Style.halfWhiteColor,
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 6.0,
                          )
                        ]
                    ),
                    child: Center(
                        child: Text(
                      'SILVER',
                          style: Style.normalTextStyle,
                    )),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  if (state is GoldSellState) {
                    _dealerBloc.add(EventGoldBuyPressed());
                  } else if (state is SilverSellState) {
                    _dealerBloc.add(EventSilverBuyPressed());
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      color:Style.orangeColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 0.0,
                        )
                      ]
                  ),
                  child: Center(
                      child: Text(
                    'BUY PRICE',
                        style: Style.normalTextStyle,
                  )),
                ),
              ),
              GestureDetector(
                onTap: () {
                  if (state is GoldBuyState) {
                    _dealerBloc.add(EventGoldSellPressed());
                  } else if (state is SilverBuyState) {
                    _dealerBloc.add(EventSilverSellPressed());
                  }
                },
                child: Container(
                  height: 40,
                  width: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(6.0),
                        bottomLeft: Radius.circular(6.0),
                      ),
                      color:Style.lightBlueColor,
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 6.0,
                        )
                      ]
                  ),
                  child: Center(
                      child: Text(
                    'SELL PRICE',
                        style: Style.normalTextStyle,
                  )),
                ),
              ),
            ],
          ),
        ],
      );
    } else {
      return Center(child: Text('No state Found'));
    }
  }
}
