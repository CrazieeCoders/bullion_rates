import 'package:firebase_phone_auth_bloc/bloc/account_bloc/account_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/account_bloc/account_states.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AccountBloc extends Bloc<AccountEvent,AccountState>{

   final DataRepository dataRepository;

  AccountBloc({@required this.dataRepository}) : super(InitialAccountState());

  @override
  Stream<AccountState> mapEventToState(AccountEvent event) async*{

    // TODO: implement mapEventToState

    if(event is SetImageEvent){
      yield SetImageState(image: event.image);
    }else if (event is RegisterDealerEvent){

      print('Came inside Register dealer Event');

      yield DashBoardLoadingState();
      yield RegisterDealerState();

      try {
        await dataRepository.registerDealer(
            event.name, event.ph, event.address, event.details);
      }catch(e){
        yield FirebaseErrorState(errMsg: e.toString());
      }
    }
  }

}