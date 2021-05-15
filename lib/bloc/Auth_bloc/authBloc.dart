import 'package:firebase_phone_auth_bloc/bloc/Auth_bloc/auth_events.dart';
import 'package:firebase_phone_auth_bloc/bloc_ui/dealer_nav_bloc_ui.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:firebase_phone_auth_bloc/ui/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_states.dart';

class AuthBloc extends Bloc<AuthEvent,AuthState>{

  final DataRepository dataRepository;
  final UserRepo userRepo;

  bool isDealerUpdated;
  bool isQuoteUpdated;

  AuthBloc({this.dataRepository,this.userRepo}) : super(AuthInitialState());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async*{
    // TODO: implement mapEventToState
    if(event is AppStartedEvent){

      final bool hasToken = userRepo.getUser();

      if (hasToken){
        yield AuthLoadingState();

        isDealerUpdated = await dataRepository.getDealerDoc();
        isQuoteUpdated =  await dataRepository.getQuoteDoc();

        print('isDealerUpdated $isDealerUpdated');
        print('isQuoteUpdated $isQuoteUpdated');

        yield AuthLoadingState();

        if(isDealerUpdated == true && isQuoteUpdated == true){
          yield DealerNavPageState();
        }else if(isDealerUpdated == true && isQuoteUpdated == false){
          yield QuotePageState();
        }else if( isDealerUpdated == false && isQuoteUpdated == false){
        yield DealerRegisterState();
        }


      } else {
      yield LoginPageState();
      }

    }
  }

}

