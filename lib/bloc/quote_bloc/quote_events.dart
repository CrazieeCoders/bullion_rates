import 'package:equatable/equatable.dart';

abstract class QuoteEvent extends Equatable{}

class UpdateQuoteEvent extends QuoteEvent{

  String gBPure,gBKacha,gBFt,gSPure,gSKacha,gSFt,sBPure,sBKacha,sBFt,
  sSPure,sSKacha,sSFt;

  UpdateQuoteEvent({this.gBPure,this.gBKacha,this.gBFt,this.gSPure,this.gSKacha,this.gSFt,this.sBPure,this.sBKacha,this.sBFt,
    this.sSPure,this.sSKacha,this.sSFt});

  @override
  // TODO: implement props
  List<Object> get props =>[gBPure,gBKacha,gBFt,gSPure,gSKacha,gSFt,sBPure,sBKacha,sBFt,
    sSPure,sSKacha,sSFt];

}