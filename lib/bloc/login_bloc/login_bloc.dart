import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_phone_auth_bloc/bloc/login_bloc/login_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/login_bloc/login_states.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginBloc extends Bloc<LoginEvent,LoginState>{

  final UserRepo userRepo;
  final DataRepository dataRepo;

  LoginBloc({this.userRepo,this.dataRepo}) : super(InitialLoginState());

  StreamSubscription subscription;

  String smsCode = '';
  String verificationId='';
  FirebaseAuth auth = FirebaseAuth.instance;


  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async*{
    // TODO: implement mapEventToState

      if(event is SendOtpEvent){
              yield LoginLoadingState(loadingMsg: 'Verifying Recapcha Image');
              subscription = sendOtp(event.phNo).listen((event) {
                add(event);
              });
      }else if(event is OtpSentEvent){
           yield OtpSentState();
      }else if(event is VerifyOtpEvent){
        this.smsCode = event.otp;
        yield LoginLoadingState(loadingMsg:'verifying otp');

        try {

          PhoneAuthCredential phoneAuthCredential =
          PhoneAuthProvider.credential(
              verificationId: verificationId, smsCode: smsCode);

          UserCredential user = await auth.signInWithCredential(phoneAuthCredential);

          if(user.user.uid!= null) {
               dataRepo.addDealer();
               dataRepo.addQuote();

            yield LoginCompletedState();
          }else{
            yield  OtpExceptionState(exceptionMsg:'Invalid Otp!');
            yield OtpSentState();
          }

        }catch(e){
          yield OtpExceptionState(exceptionMsg:'Invalid Otp!');
          yield OtpSentState();
        }

      }else if(event is LoggedInEvent){
        yield LoginCompletedState();
      }
  }



Stream<LoginEvent> sendOtp(String phNo) async* {
  StreamController<LoginEvent> eventStream = StreamController();


  await FirebaseAuth.instance.verifyPhoneNumber(

    phoneNumber:phNo,
    verificationCompleted: (PhoneAuthCredential credential) async{
      await auth.signInWithCredential(credential).whenComplete(() =>
          eventStream.add(LoggedInEvent(user: auth.currentUser))
      ).catchError(onError);

    },
    verificationFailed: (FirebaseAuthException e) {

      if (e.code == 'invalid-phone-number') {
        eventStream.add(LoginExceptionEvent(message: e.message.toString()));
      }else{
        eventStream.add(LoginExceptionEvent(message: e.message.toString()));
      }

    },
    codeSent: (String VerificationId, int resendToken){
        verificationId = VerificationId;
      eventStream.add(OtpSentEvent());


    },
    codeAutoRetrievalTimeout: (String VerificationId) {
      print('Came inside codeAutoRetrievalTimeout');
      verificationId = VerificationId;
      eventStream.close();
    },
    timeout: const Duration(minutes: 2),

  );



    yield* eventStream.stream;
}
}