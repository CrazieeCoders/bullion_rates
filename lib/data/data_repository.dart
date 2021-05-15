import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;

class DataRepository{

  CollectionReference collRef = FirebaseFirestore.instance.collection('dealers');
  CollectionReference quoteRef = FirebaseFirestore.instance.collection('quote');
  final FirebaseAuth auth = FirebaseAuth.instance;

  firebase_storage.FirebaseStorage storage =
      firebase_storage.FirebaseStorage.instance;


  String get userId{
    return   auth.currentUser.uid;
  }


  logOut(){
    return auth.signOut();
  }


  addDealer() async {
    try {
      final User user = auth.currentUser;
      collRef.doc(user.uid).set({
        'dealerName':'no-data',
        'dealerPhone':'no-data',
        'dealerAddress':'no-data',
        'dealerAbout':'no data',
        'isUpdated':false,
      }
      );

    } on firebase_core.FirebaseException catch (e) {
      print('error :${e.message}');
    }
  }



  addQuote(){
    try{

      final User user = auth.currentUser;
      quoteRef.doc(user.uid).set({
        'goldbuy':{
          'ft':'no-data',
          'pure':'no-data',
          'kacha':'no-data',
        },
        'goldsell':{
          'ft':'no-data',
          'pure':'no-data',
          'kacha':'no-data',
        },
        'silverbuy':{
          'ft':'no-data',
          'pure':'no-data',
          'kacha':'no-data',
        },
        'silversell':{
          'ft':'no-data',
          'pure':'no-data',
          'kacha':'no-data',
        },
        'isUpdated':false,
      });

    }on firebase_core.FirebaseException catch (e){
      print('error :${e.message}');
    }
  }



  Future registerDealer(String name,String ph,String address,String details) async {
    try {
      final User user = auth.currentUser;
      collRef.doc(user.uid).set({
        'dealerName':name,
        'dealerPhone':ph,
        'dealerAddress':address,
        'dealerAbout':details,
        'isUpdated':true,
      }
      );

    } on firebase_core.FirebaseException catch (e) {
      print('error :${e.message}');
    }
  }

  Future updateQuote({String gBPure,String gBKacha,String gBFt,String gSPure,String gSKacha,String gSFt,
    String sBPure,String sBKacha,String sBFt,String sSPure,String sSKacha,String sSFt,
  }){
    try{

      final User user = auth.currentUser;
      quoteRef.doc(user.uid).set({
        'goldbuy':{
          'ft':gBFt,
          'pure':gBPure,
          'kacha':gBKacha,
        },
        'goldsell':{
          'ft':gSFt,
          'pure':gSPure,
          'kacha':gSKacha,
        },
        'silverbuy':{
          'ft':sBFt,
          'pure':sBPure,
          'kacha':sBKacha,
        },
        'silversell':{
          'ft':sSFt,
          'pure':sSPure,
          'kacha':sSKacha,
        },
        'isUpdated':true,
      });

    }on firebase_core.FirebaseException catch (e){
      print('error :${e.message}');
    }
  }


   getDealerDoc(){
    final User user = auth.currentUser;
     return collRef.doc(user.uid).get().then((value){
      print('value : ${value['isUpdated']}');
        return  (value['isUpdated']);
    });
  }

   getQuoteDoc(){
     final User user = auth.currentUser;
     return quoteRef.doc(user.uid).get().then((value){
       print('value : ${value['isUpdated']}');
         return  value['isUpdated'];
     });
    }

}