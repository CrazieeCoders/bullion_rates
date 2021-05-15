import 'package:firebase_phone_auth_bloc/bloc/networkBloc/network_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/networkBloc/network_events.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:firebase_phone_auth_bloc/ui/dealer_registeration_page.dart';
import 'package:firebase_phone_auth_bloc/ui/buyer_nav_page.dart';
import 'package:firebase_phone_auth_bloc/ui/login_page.dart';
import 'package:firebase_phone_auth_bloc/ui/quote_page.dart';
import 'bloc_ui/dealer_nav_bloc_ui.dart';
import 'file:///C:/Users/jsurulir/AndroidStudioProjects/arsey/firebase_phone_auth_bloc/lib/bloc_ui/app_start_page.dart';
import 'package:firebase_phone_auth_bloc/ui/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
      MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final NetworkBloc _networkBloc = NetworkBloc();

  DataRepository dataRepository = DataRepository();
  UserRepo userRepo = UserRepo();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bullion Rates',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      routes: {
        '/':(context) => BlocProvider.value(
            value: _networkBloc..add(ListenConnection()),
           child: SplashScreen(dataRepository: dataRepository,userRepo: userRepo,),
        ),
       /* '/':(context) => BlocProvider.value(
          value: _networkBloc..add(ListenConnection()),
          child: QuotePageProvider(dataRepository: dataRepository,userRepo: userRepo,),
        ),*/
        '/authPage':(context) => BlocProvider.value(
            value: _networkBloc..add(ListenConnection()),
            child: AppStartPageProvider(dataRepository: dataRepository,userRepo: userRepo,),
        ),
        '/loginPage':(context) => BlocProvider.value(
          value: _networkBloc..add(ListenConnection()),
          child: LoginPage(dataRepository: dataRepository,userRepo: userRepo,),
        ),
        '/dealerNavPage':(context) => BlocProvider.value(
          value: _networkBloc..add(ListenConnection()),
          child: DealerNavPage(dataRepository: dataRepository,userRepo: userRepo),
        ),
        '/accountPage':(context) => BlocProvider.value(
          value: _networkBloc..add(ListenConnection()),
          child: DealerRegisterationProvider(dataRepository: dataRepository,userRepo: userRepo),
        ),
        '/quotePage':(context) => BlocProvider.value(
          value: _networkBloc..add(ListenConnection()),
          child: QuotePageProvider(dataRepository: dataRepository,userRepo: userRepo,),
        ),
        '/buyerPage':(context) => BlocProvider.value(
          value: _networkBloc..add(ListenConnection()),
          child: BuyerNavPage(),
        ),
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _networkBloc.close();
    super.dispose();
  }
}






