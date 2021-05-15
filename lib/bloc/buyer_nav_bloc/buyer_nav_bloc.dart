import 'package:firebase_phone_auth_bloc/bloc/buyer_nav_bloc/buyer_nav_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/buyer_nav_bloc/buyer_nav_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BuyerNavDrawerBloc extends Bloc<BuyerNavDrawerEvent,BuyNavDrawerState>{

  BuyerNavDrawerBloc() : super(BuyNavDrawerState(NavItem.page_one));

  @override
  Stream<BuyNavDrawerState> mapEventToState(BuyerNavDrawerEvent event) async* {
    // TODO: implement mapEventToState

    if(event is BuyNavigateTo){
      if(event.destination != state.selectedItem){
        yield BuyNavDrawerState(event.destination);
      }
    }


  }
}