import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class AccountEvent extends Equatable{}

class SetImageEvent extends AccountEvent{

  File image;

  SetImageEvent({this.image});

  @override
  // TODO: implement props
  List<Object> get props =>[image];
}

class DashboardEvent extends AccountEvent{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class RegisterDealerEvent extends AccountEvent{

  String name;
  String ph;
  String address;
  String details;
  File image;

  RegisterDealerEvent({@required this.name,@required this.ph,@required this.address,@required this.details,@required this.image});

  @override
  // TODO: implement props
  List<Object> get props =>[name,ph,address,details,image];
}