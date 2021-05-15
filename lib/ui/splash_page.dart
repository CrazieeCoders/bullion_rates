import 'package:firebase_phone_auth_bloc/bloc_ui/app_start_page.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {


  final DataRepository dataRepository;
  final UserRepo userRepo;

  SplashScreen({@required this.dataRepository,@required this.userRepo});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  Animation splashAnim,dealerAnim,buyerAnim;
  AnimationController _animationController;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _animationController = AnimationController(vsync: this,duration: Duration(seconds: 2));
    splashAnim = Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: _animationController,
        curve: Curves.fastOutSlowIn));
    dealerAnim = Tween(begin: -1.0,end: 0.0).animate(CurvedAnimation(parent: _animationController,
        curve: Curves.fastOutSlowIn),
    );
    buyerAnim = Tween(begin: 1.0,end: 0.0).animate(CurvedAnimation(parent: _animationController,
        curve: Curves.fastOutSlowIn));

    _animationController.forward();
  }


  @override
  Widget build(BuildContext context) {

    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

   // _splashBloc = BlocProvider.of<SplashBloc>(context);

    return AnimatedBuilder(
        animation: _animationController,
        builder: (BuildContext context,Widget child){
          return    Scaffold(
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Transform(
                  transform: Matrix4.translationValues(0.0, splashAnim.value*height, 0.0),
                  child: Center(
                    child: Image.asset(
                      'assets/bullionrates.PNG',
                      width: 180.0,
                      height: 180.0,
                    ),
                  ),
                ),

                Center(
                  child: Text('BULLION RATES',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Arapey',
                      color: Colors.black,
                      fontSize: 40.0,
                      fontWeight:FontWeight.bold,
                      backgroundColor:Style.orangeColor,
                    ),
                  ),
                ),

                SizedBox(
                  height: 10.0,
                ),

                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('where Buyers',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Caveat',
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight:FontWeight.normal,
                            backgroundColor: const Color(0xFFaee6e6)
                        ),
                      ),
                      Text('& ',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Caveat',
                          color: Colors.black,
                          fontSize: 30.0,
                          fontWeight:FontWeight.normal,

                        ),
                      ),
                      Text(' Sellers meet',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Caveat',
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight:FontWeight.normal,
                            fontStyle: FontStyle.italic,
                            backgroundColor:Style.lightBlueColor
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Transform(
                      transform: Matrix4.translationValues(dealerAnim.value*width, 0.0, 0.0),
                      child: GestureDetector(
                        onTap: (){
                          //Navigator.pushNamed(context,'/dealerPage');

                          print('came inside Dealer button');
                          Navigator.pushNamed(context,'/authPage');

                        },
                        child: Container(
                          height: 70,
                          width: 120,
                          child: Center(child: Text('Dealers',
                              style: Style.buttonTextStyle
                          )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xFFffda77),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0
                                )
                              ]
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40.0,
                    ),
                    Transform(
                      transform: Matrix4.translationValues(buyerAnim.value * width, 0.0, 0.0),
                      child: GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context,'/buyerPage');
                        },
                        child: Container(
                          height: 70,
                          width: 120,
                          child: Center(child: Text('Buyers',
                              style: Style.buttonTextStyle
                          )),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Color(0xFFfbf6f0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 2.0,
                                    spreadRadius: 2.0
                                )
                              ]
                          ),
                        ),
                      ),
                    ),
                  ],
                ),



              ],
            ),
          );
        }

    );
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _animationController.dispose();
    super.dispose();
  }
}
