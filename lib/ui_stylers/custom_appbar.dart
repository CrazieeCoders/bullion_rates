import 'package:firebase_phone_auth_bloc/bloc/buyer_dashboard_bloc/buyer_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/buyer_dashboard_bloc/buyer_event.dart';
import 'package:firebase_phone_auth_bloc/bloc/buyer_dashboard_bloc/buyer_state.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:firebase_phone_auth_bloc/ui_stylers/clippers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget{


  BuyerBloc _buyerBloc;

  final Size preferredSize;
  CustomAppBar(
      { Key key,}) : preferredSize = Size.fromHeight(150.0),
        super(key: key);

  @override
  Widget build(BuildContext context) {

    _buyerBloc = BlocProvider.of<BuyerBloc>(context);

    MediaQueryData mediaQuery = MediaQuery.of(context);
    double height = 100;
       // (mediaQuery.size.height - mediaQuery.padding.top) * 30;
    return Column(
      children: [
        SizedBox(
          height: 15.0,
        ),
        ClipPath(
          clipper: HeaderClipper(),
          child: Container(
            height: 80,
            decoration: BoxDecoration(
              color: Style.yellowColor,
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top:30.0),
                  child: Center(child: Text('DashBoard',
                    style: Style.headerTextStyle,
                  )),
                )
              ],
            ),
          ),
        ),
        SizedBox(
          height: 15.0,
        ),
        SwitchButton(),

      ],
    );
  }

  Widget SwitchButton(){
    return   Padding(
      padding: const EdgeInsets.only(top:32.0,left: 100.0),
      child: BlocBuilder<BuyerBloc,BuyerState>(
        builder:(context,state){

          if(state is GoldPressedState){
            return Row(
                children: [

                  GestureDetector(
                    onTap: (){
                      _buyerBloc.add(GoldPressedEvent());
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6.0),
                            bottomLeft: Radius.circular(6.0),
                          ),
                          color:Style.yellowColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.0,
                            )
                          ]
                      ),
                      child: Center(child: Text('gold',
                        style: Style.normalTextStyle,
                      )),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _buyerBloc.add(SilverPressedEvent());
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6.0),
                            bottomRight: Radius.circular(6.0),
                          ),
                          color: Style.halfWhiteColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.0,
                            )
                          ]
                      ),
                      child: Center(child: Text('silver',
                          style: Style.normalTextStyle
                      )),
                    ),
                  )

                ]
            );
          }else if(state is SilverPressedState){

            return Row(
                children: [

                  GestureDetector(
                    onTap: (){
                      _buyerBloc.add(GoldPressedEvent());
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(6.0),
                            bottomLeft: Radius.circular(6.0),
                          ),
                          color:Style.yellowColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 0.0,
                            )
                          ]
                      ),
                      child: Center(child: Text('gold',
                        style: Style.normalTextStyle,
                      )),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      _buyerBloc.add(SilverPressedEvent());
                    },
                    child: Container(
                      height: 40,
                      width: 150,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(6.0),
                            bottomRight: Radius.circular(6.0),
                          ),
                          color: Style.halfWhiteColor,
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 2.0,
                            )
                          ]
                      ),
                      child: Center(child: Text('silver',
                          style: Style.normalTextStyle
                      )),
                    ),
                  )

                ]
            );
          }
          return Center(child: Text('Error in custom app bar line 178',
          style: Style.errorTextStyle,
          ));


        } ,
      ),
    );
  }

}