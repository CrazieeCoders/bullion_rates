import 'package:bloc/bloc.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'dealer_event.dart';
import 'dealer_state.dart';

class DealerBloc extends Bloc<DealerEvent,DealerState>{

   final DataRepository dataRepository;

  DealerBloc({this.dataRepository}) : super(GoldBuyState());


  @override
  Stream<DealerState> mapEventToState(DealerEvent event) async*{

    if(event is EventGoldBuyPressed){
          yield GoldBuyState();
    }else if(event is EventGoldSellPressed){
          yield GoldSellState();
    }else if(event is EventSilverBuyPressed){
          yield SilverBuyState();
    }else if(event is EventSilverSellPressed){
          yield SilverSellState();
    }

  }


}