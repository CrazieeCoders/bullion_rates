
import 'package:bloc/bloc.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';

import 'dealer_nav_events.dart';
import 'dealer_nav_states.dart';

class NavDrawerBloc extends Bloc<NavDrawerEvent,NavDrawerState>{

  final DataRepository dataRepository;
  final UserRepo userRepo;

  NavDrawerBloc({this.dataRepository,this.userRepo}) : super(NavDrawerState(NavItem.page_one));


  @override
  Stream<NavDrawerState> mapEventToState(NavDrawerEvent event) async*{
    // TODO: implement mapEventToState
       if(event is NavigateTo){
         if(event.destination != state.selectedItem){
           yield NavDrawerState(event.destination);
         }
       }
  }
  
}

