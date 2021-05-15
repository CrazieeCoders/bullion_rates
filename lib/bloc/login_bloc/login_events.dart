import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable{}

class SendOtpEvent extends LoginEvent{

  String phNo;

  SendOtpEvent({this.phNo});

  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class OtpSentEvent extends LoginEvent{

  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class OTPAutoReadEvent extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}

class VerifyOtpEvent extends LoginEvent{

  String otp;

  VerifyOtpEvent({@required this.otp});

  @override
  // TODO: implement props
  List<Object> get props =>[otp];
}

class LogoutEvent extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class LoggedInEvent extends LoginEvent{

  User user;

  LoggedInEvent({@required this.user});
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class LoginExceptionEvent extends LoginEvent{

  final String message;

  LoginExceptionEvent({@required this.message});

  @override
  // TODO: implement props
  List<Object> get props =>[message];

}

class ValidatingUserEvent extends LoginEvent{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

