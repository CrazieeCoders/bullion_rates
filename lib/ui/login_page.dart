import 'package:firebase_phone_auth_bloc/bloc/login_bloc/login_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/login_bloc/login_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/login_bloc/login_states.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:firebase_phone_auth_bloc/ui/ui_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';


class LoginPage extends StatelessWidget {

  final DataRepository dataRepository;
  final UserRepo userRepo;

  LoginPage({@required this.dataRepository,@ required this.userRepo});


  @override
  Widget build(BuildContext context) {

    return BlocProvider<LoginBloc>(
      create: (context)=>LoginBloc(dataRepo: dataRepository,userRepo: userRepo),
      child: LoginForm(),
    );
  }
}


class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

          return Scaffold(
            key: scaffoldKey,
            body: BlocListener<LoginBloc,LoginState>(
                listener: (context,state){
                  if(state is LoginCompletedState){
                    Navigator.pushNamedAndRemoveUntil(context,'/accountPage',(_)=>false);
                  }else if(state is ExceptionState || state is OtpExceptionState) {
                   String message;
                   if (state is ExceptionState) {
                     message = state.expMsg;
                   }else if (state is OtpExceptionState) {
                     message = state.exceptionMsg;
                   }

                   print('message : $message');
                   final snackBar = SnackBar(content: Row(
                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                     children: [
                       Text(message),
                       Icon(Icons.error),
                     ],
                   ),
                     backgroundColor: Colors.red,
                   );
                    scaffoldKey.currentState..hideCurrentSnackBar()..showSnackBar(snackBar);

                 }
                },
                child: BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                 return   Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Container(
                          color: Style.yellowColor,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Header(),
                              Container(
                                child: ConstrainedBox(
                                  constraints:
                                  BoxConstraints.tight(Size.fromHeight(200)),
                                  child: getViewAsPerState(context,state),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(62))),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  );
                }

                ),
              ),
            );



  }
}



  getViewAsPerState(BuildContext context,LoginState state) {
    if (state is InitialLoginState) {
      return NumberInput();
    }else if (state is LoginLoadingState ){
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            backgroundColor:Style.yellowColor,
          ),
          SizedBox(
            height: 12.0,
          ),
          Text(state.loadingMsg),
        ],
      );
    }else if(state is OtpSentState){
      return OtpInput();
    }else {
      return NumberInput();
    }
  }
  

  


class NumberInput extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _phoneTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(18.0,35.0,18.0,20.0),
            child: EditTextUtils().getCustomEditTextArea(
                labelValue: "Enter the Phone Number",
                hintValue: "",
                controller: _phoneTextController,
                keyboardtype: TextInputType.number,
                icon: Icons.phone,
                validator: (value) {
                  return validateMobile(value);
                }),
          ),
        ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: RaisedButton(
            onPressed: (){
             if(_formKey.currentState.validate()){
               BlocProvider.of<LoginBloc>(context).add(SendOtpEvent(
                phNo:"+91"+_phoneTextController.value.text
               ));
             }
            },
            color:Style.lightBlueColor,
            child: Text(
              'submit',
             style: Style.columnTextStyle,
            ),
          ),
        ),

      ],
    );
  }
}


class OtpInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PinEntryTextField(
            fields: 6,
            onSubmit: (String pin){
              BlocProvider.of<LoginBloc>(context).add(VerifyOtpEvent(otp: pin));
            },
          ),
          SizedBox(height: 15.0,),
          RaisedButton(onPressed: (){
              Navigator.pop(context);
          },
            color: Style.lightBlueColor,
            child: Text(
              'Back',
              style: Style.columnTextStyle
            ),
          )
        ],
      ),
    );
  }
}

String validateMobile(String value) {
  if (value.length != 10) {
    return 'Mobile number must be of 10 digits';
  } else {
    return null;
  }
}

class Header extends StatelessWidget {
  const Header({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        margin: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/bullionrates.PNG',
              height: 100,
              width: 100,
            ),
            Text(
              'Mobile Number',
              style: Style.subHeaderTextStyle
            ),
            Text(
              'Enter your Mobile Number to Continue',
              style: Style.normalTextStyle,
            )
          ],
        ),
      ),
    );
  }
}
