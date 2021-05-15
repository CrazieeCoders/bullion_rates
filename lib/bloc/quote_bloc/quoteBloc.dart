import 'package:firebase_phone_auth_bloc/bloc/quote_bloc/quote_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/quote_bloc/quote_state.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class QuoteBloc extends Bloc<QuoteEvent,QuoteState>{

  final DataRepository dataRepository;

  QuoteBloc({this.dataRepository}) : super(QuoteInitialState());

  @override
  Stream<QuoteState> mapEventToState(QuoteEvent event) async*{

     if(event is UpdateQuoteEvent){

       yield QuoteLoadingState();

        await dataRepository.updateQuote(gBPure:event.gBPure,gBKacha:event.gBKacha ,gBFt:event.gBFt,
         gSPure: event.gSPure,gSKacha:event.gSKacha,gSFt:event.gSFt,
         sBPure:event.sBPure,sBKacha:event.sBKacha ,sBFt:event.sBFt,
         sSPure: event.sSPure,sSKacha:event.sSPure,sSFt:event.sSKacha,);

      yield UpdateQuoteState();
       yield QuoteLoadingState();

     }
  }


}