import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:flutter/material.dart';

class LogOut extends StatelessWidget {

  final DataRepository dataRepository;

  LogOut({this.dataRepository});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: Center(
       child: GestureDetector(
         onTap: (){
           dataRepository.logOut();
           Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
         },
         child: Container(
           height: 50,
             width: 110,
           decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(10.0),
             color: Style.orangeColor,
             boxShadow: [
               BoxShadow(
                 spreadRadius: 2.0,
                 blurRadius: 2.0,
                 color: Colors.white
               )
             ]
           ),
           child: Center(child: Text('Log out',
           style: Style.button1TextStyle,)
           ),
         ),
       )
     ),
    );
  }
}
