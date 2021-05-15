import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:firebase_auth/firebase_auth.dart';

class UserRepo{

  FirebaseAuth auth = FirebaseAuth.instance;




    bool getUser(){

    if(auth.currentUser != null){
      return true;
    }else{
      return false;
    }

  }


}