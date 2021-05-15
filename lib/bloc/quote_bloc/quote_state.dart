import 'package:equatable/equatable.dart';

abstract class QuoteState extends Equatable{}


class QuoteInitialState extends QuoteState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}


class QuoteLoadingState extends QuoteState{
  @override
  // TODO: implement props
  List<Object> get props =>[];

}

class UpdateQuoteState extends QuoteState{

  String gBPure,gBKacha,gBFt,gSPure,gSKacha,gSFt,sBPure,sBKacha,sBFt,
      sSPure,sSKacha,sSFt;

  @override
  // TODO: implement props
  List<Object> get props =>[gBPure,gBKacha,gBFt,gSPure,gSKacha,gSFt,sBPure,sBKacha,sBFt,
    sSPure,sSKacha,sSFt];

}