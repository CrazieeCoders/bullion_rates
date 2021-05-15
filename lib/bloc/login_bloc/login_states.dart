import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable{}


class InitialLoginState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}

class OtpSentState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props =>[];
}


class LoginLoadingState extends LoginState{
  String loadingMsg;

  LoginLoadingState({this.loadingMsg});

  @override
  // TODO: implement props
  List<Object> get props =>[loadingMsg];
}

class OtpVerifiedState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class LoginCompletedState extends LoginState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class ExceptionState extends LoginState{
  String expMsg;
  ExceptionState({this.expMsg});

  @override
  // TODO: implement props
  List<Object> get props =>[expMsg];

}

class OtpExceptionState extends LoginState{

  String exceptionMsg;

  OtpExceptionState({this.exceptionMsg});

  @override
  // TODO: implement props
  List<Object> get props =>[exceptionMsg];

}
