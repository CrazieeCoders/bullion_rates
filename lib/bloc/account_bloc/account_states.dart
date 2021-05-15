import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AccountState extends Equatable{
}


class InitialAccountState extends AccountState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class SetImageState extends AccountState{

  File image;

  SetImageState({this.image});

  @override
  // TODO: implement props
  List<Object> get props =>[image];

}


class DashBoardState extends AccountState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class DashBoardLoadingState extends AccountState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class RegisterDealerState extends AccountState{

String name;
String ph;
String address;
String details;
File image;

RegisterDealerState({@required this.name,@required this.ph,@required this.address,@required this.details,@required this.image});

@override
// TODO: implement props
List<Object> get props =>[name,ph,address,details,image];
}


class FirebaseErrorState extends AccountState{
  String errMsg;


  FirebaseErrorState({@required this.errMsg});
  @override
  // TODO: implement props
  List<Object> get props =>[errMsg];
}