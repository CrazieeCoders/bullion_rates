import 'package:firebase_phone_auth_bloc/bloc/Auth_bloc/authBloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/Auth_bloc/auth_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/Auth_bloc/auth_states.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class AppStartPageProvider extends StatelessWidget {

  final DataRepository dataRepository;
  final UserRepo userRepo;

  AppStartPageProvider({@required this.dataRepository,@required this.userRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthBloc>(
        create: (context)=>AuthBloc(dataRepository:dataRepository,userRepo:userRepo )..add(AppStartedEvent()),
        child: AppStartPage(dataRepository: dataRepository,userRepo: userRepo));
  }
}



class AppStartPage extends StatelessWidget {


  final DataRepository dataRepository;
  final UserRepo userRepo;

  AppStartPage({@required this.dataRepository,@required this.userRepo});

    @override
    Widget build(BuildContext context) {

      return Scaffold(
        body: BlocListener<AuthBloc,AuthState>(
          listener: (context,state){

            if(state is DealerNavPageState){
              Navigator.pushNamedAndRemoveUntil(context,'/dealerNavPage',(_)=>false);
            }else if (state is QuotePageState){
              Navigator.pushNamedAndRemoveUntil(context,'/quotePage',(_)=>false);
            }else if(state is DealerRegisterState){
              Navigator.pushNamedAndRemoveUntil(context,'/accountPage',(_)=>false);
            }else if(state is LoginPageState){
              Navigator.pushNamedAndRemoveUntil(context,'/loginPage',(_)=>false);
            }

          },
          child: BlocBuilder<AuthBloc,AuthState>(
            builder:(context,state){
              if(state is AuthLoadingState)
              return Scaffold(
                body: Center(child: CircularProgressIndicator(
                  backgroundColor: Style.yellowColor,
                )),
              );
                return Scaffold(
                body: Center(child: CircularProgressIndicator(
                  backgroundColor: Style.yellowColor,
                )),
              );
            },
          ),
        ),
      );
    }

}








