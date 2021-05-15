import 'package:firebase_phone_auth_bloc/bloc/buyer_dashboard_bloc/buyer_event.dart';
import 'package:firebase_phone_auth_bloc/bloc/buyer_dashboard_bloc/buyer_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyerBloc extends Bloc<BuyerEvent,BuyerState>{

  BuyerBloc() : super(GoldPressedState());

  @override
  Stream<BuyerState> mapEventToState(BuyerEvent event) async*{

    if(event is GoldPressedEvent){
      yield BuyerLoadingState();
      yield GoldPressedState();
    }else if(event is SilverPressedEvent){
      yield BuyerLoadingState();
      yield SilverPressedState();
    }

  }
}