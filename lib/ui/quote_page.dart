import 'package:firebase_phone_auth_bloc/bloc/quote_bloc/quoteBloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/quote_bloc/quote_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/quote_bloc/quote_state.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class QuotePageProvider extends StatelessWidget {

  final DataRepository dataRepository;
  final UserRepo userRepo;

  QuotePageProvider({@required this.dataRepository,@required this.userRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<QuoteBloc>(
        create: (context)=>QuoteBloc(dataRepository: dataRepository,),
        child: QuotePage());
  }
}

class QuotePage extends StatefulWidget {

  @override
  _QuotePageState createState() => _QuotePageState();
}

class _QuotePageState extends State<QuotePage> {

  String text = 'no-data';
  QuoteBloc quoteBloc;
  final _formKey = GlobalKey<FormState>();

  TextEditingController _goldBuyPure = TextEditingController();
  TextEditingController _goldBuyKacha = TextEditingController();
  TextEditingController _goldBuyFt = TextEditingController();
  TextEditingController _goldSellPure = TextEditingController();
  TextEditingController _goldSellKacha = TextEditingController();
  TextEditingController _goldSellFt = TextEditingController();

  TextEditingController _silverBuyPure = TextEditingController();
  TextEditingController _silverBuyKacha = TextEditingController();
  TextEditingController _silverBuyFt = TextEditingController();
  TextEditingController _silverSellPure = TextEditingController();
  TextEditingController _silverSellKacha = TextEditingController();
  TextEditingController _silverSellFt = TextEditingController();

  @override
  Widget build(BuildContext context) {

    quoteBloc = BlocProvider.of<QuoteBloc>(context);

      return Scaffold(
      appBar: AppBar(
        title: Text('Quote',
        style: Style.headerTextStyle,),
        centerTitle: true,
      ),
     body: BlocListener<QuoteBloc,QuoteState>(
       listener: (context,state){
          if(state is UpdateQuoteState){
            Navigator.pushNamed(context,'/dealerNavPage');
          }
       },
       child: BlocBuilder<QuoteBloc,QuoteState>(
         builder:(context,state){
           if(state is QuoteInitialState){
             return Form(
               key: _formKey,
               child: ListView(
                 children: [
                   SizedBox(
                     height: 40.0,
                   ),
                   Container(
                     height: 300,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(
                           10.0,
                         ),
                         color:Style.halfWhiteColor,
                         boxShadow: [
                           BoxShadow(
                             blurRadius: 2.0,
                           )
                         ]),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         Padding(
                           padding: const EdgeInsets.only(left:28.0,top:20),
                           child: Text('Gold :',
                             style: Style.headerTextStyle,
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(top:28.0),
                           child: Row(
                             children: [
                               SizedBox(width: 120.0,),
                               Text('Buy Price',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 width: 60.0,
                               ),
                               Text('Sell Price',
                                 style: Style.subHeaderTextStyle,
                               )
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left:25.0,top:20),
                           child: Row(
                             children: [
                               Text('Pure',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 width: 50.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _goldBuyPure,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _goldBuyPure.value =
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
                                         _goldBuyPure.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                         contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     style: Style.inputTextStyle,
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: 50.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _goldSellPure,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _goldSellPure.value =
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
                                         _goldSellPure.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     validator: (value){
                                       if(value.isEmpty){
                                         return '* mandatory';
                                       }
                                       return null;
                                     },
                                     style: Style.inputTextStyle,
                                   ),
                                 ),
                               ),

                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left:25.0,top: 20),
                           child: Row(
                             children: [
                               Text('Kacha',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 width: 38.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _goldBuyKacha,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _goldBuyKacha.value =
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
                                         _goldBuyKacha.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     style: Style.inputTextStyle,
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: 50.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _goldSellKacha,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _goldSellKacha.value =
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
                                         _goldSellKacha.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     style:Style.inputTextStyle,
                                     validator: (value){
                                       if(value.isEmpty){
                                         return '* mandatory';
                                       }
                                       return null;
                                     },
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left:25.0,top:20),
                           child: Row(
                             children: [
                               Text('FT',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 width: 70.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _goldBuyFt,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _goldBuyFt.value =
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
                                         _goldBuyFt.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(10.0),
                                     ),
                                     style: Style.inputTextStyle,
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: 50.0,
                               ),

                               Container(
                                 height: 40,
                                 width:110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _goldSellFt,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _goldSellFt.value =
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
                                         _goldSellFt.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     style: Style.inputTextStyle,
                                     validator: (value){
                                       if(value.isEmpty){
                                         return '* mandatory';
                                       }
                                       return null;
                                     },
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                   Container(
                     height: 300,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(
                           10.0,
                         ),
                         color:Style.halfWhiteColor,
                         boxShadow: [
                           BoxShadow(
                             blurRadius: 2.0,
                           )
                         ]),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [

                         Padding(
                           padding: const EdgeInsets.only(left:28.0,top:20.0),
                           child: Text('Silver :',
                             style: Style.headerTextStyle,
                           ),
                         ),

                         Padding(
                           padding: const EdgeInsets.only(top:28.0),
                           child: Row(
                             children: [
                               SizedBox(width: 120.0,),
                               Text('Buy Price',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 width: 60.0,
                               ),
                               Text('Sell Price',
                                 style: Style.subHeaderTextStyle,
                               )
                             ],
                           ),
                         ),


                         Padding(
                           padding: const EdgeInsets.only(left:25.0,top:20),
                           child: Row(
                             children: [
                               Text('Pure',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 width: 50.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _silverBuyPure,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _silverBuyPure.value =
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
                                         _silverBuyPure.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     style: Style.inputTextStyle,
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: 50.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _silverSellPure,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _silverSellPure.value =
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
                                         _silverSellPure.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     validator: (value) {
                                       if (value.isEmpty) {
                                         return '* mandatory';
                                       }
                                       return null;
                                     },
                                     style:Style.inputTextStyle,

                                   ),
                                 ),
                               ),

                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left:25.0,top: 20),
                           child: Row(
                             children: [
                               Text('Kacha',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 width: 38.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _silverBuyKacha,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _silverBuyKacha.value =
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
                                         _silverBuyKacha.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     style:Style.inputTextStyle,
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: 50.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _silverSellKacha,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _silverSellKacha.value =
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
                                         _silverSellKacha.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                       counterText: ' ',
                                     ),
                                     style: Style.inputTextStyle,
                                     validator: (value){
                                       if(value.isEmpty){
                                         return '* mandatory';
                                       }
                                       return null;
                                     },
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Padding(
                           padding: const EdgeInsets.only(left:25.0,top:20),
                           child: Row(
                             children: [
                               Text('FT',
                                 style: Style.subHeaderTextStyle,
                               ),
                               SizedBox(
                                 width: 70.0,
                               ),

                               Container(
                                 height: 40,
                                 width: 110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _silverBuyFt,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _silverBuyFt.value =
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
                                         _silverBuyFt.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     style: Style.inputTextStyle,
                                   ),
                                 ),
                               ),
                               SizedBox(
                                 width: 50.0,
                               ),

                               Container(
                                 height: 40,
                                 width:110,
                                 decoration: BoxDecoration(
                                     color: Style.orangeColor,
                                     borderRadius: BorderRadius.circular(5.0)
                                 ),
                                 child: Center(
                                   child: TextFormField(
                                     cursorColor: Colors.black,
                                     controller: _silverSellFt,
                                     onChanged: (String newVal) {
                                       if (newVal.length <= 5) {
                                         text = newVal;
                                       } else {
                                         _silverSellFt.value =
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
                                         _silverSellFt.text = text;
                                       }
                                     },
                                     keyboardType: TextInputType.number,
                                     maxLength: 5,
                                     decoration: InputDecoration(
                                         counter: Offstage(),
                                         border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(7.0),
                                     ),
                                     style: Style.inputTextStyle,
                                     validator: (value){
                                       if(value.isEmpty){
                                         return '* mandatory';
                                       }
                                       return null;
                                     },
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                       ],
                     ),
                   ),
                   SizedBox(
                     height: 40.0,
                   ),
                   Padding(
                     padding: const EdgeInsets.only(left:48.0,right: 48.0),
                     child: GestureDetector(
                       onTap: (){
                      updateQuote();
                       },
                       child: Container(
                         height: 50,
                         width: 60,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(10.0),
                             topRight: Radius.circular(10.0),
                           ),
                           color: Style.lightBlueColor,
                         ),
                         child: Center(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                     'update',
                                     style: Style.descTextStyle
                                 ),
                                 SizedBox(width: 5.0,),
                                 Icon(Icons.upload_outlined,
                                   color: Colors.white,
                                 ),
                               ],
                             )),
                       ),
                     ),
                   ),
                 ],
               ),
             );
           }else if (state is QuoteLoadingState){
             return Scaffold(
               body: Center(
                 child: Column(
                   children: [
                     CircularProgressIndicator(
                       backgroundColor: Style.yellowColor,
                     ),
                     SizedBox(height: 15.0,),
                     Text('loading ...',
                     style: Style.subTextStyle,
                     )
                   ],
                 ),
               ),
             );
           }
           return Text('Error in quote page line 826');
         },

       ),
     )
    );


    }

    updateQuote(){


      if(_formKey.currentState.validate()) {
        quoteBloc.add(UpdateQuoteEvent(gBPure: _goldBuyPure.text,
          gBKacha: _goldBuyKacha.text,
          gBFt: _goldBuyFt.text,
          gSPure: _goldSellPure.text,
          gSKacha: _goldSellKacha.text,
          gSFt: _goldSellFt.text,
          sBPure: _silverBuyPure.text,
          sBKacha: _silverBuyKacha.text,
          sBFt: _silverBuyFt.text,
          sSPure: _silverSellPure.text,
          sSKacha: _silverSellKacha.text,
          sSFt: _silverSellFt.text,));

        _formKey.currentState.reset();
      }

    }

  }


