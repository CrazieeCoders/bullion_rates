import 'dart:io';
import 'package:firebase_phone_auth_bloc/bloc/account_bloc/account_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/account_bloc/account_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/account_bloc/account_states.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class DealerRegisterationProvider extends StatelessWidget {

  final DataRepository dataRepository;
  final UserRepo userRepo;

  DealerRegisterationProvider({@required this.dataRepository,@required this.userRepo});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AccountBloc>(
      create: (context) => AccountBloc(dataRepository: dataRepository),
      child: DealerRegisteration(),
    );
  }
}

class DealerRegisteration extends StatefulWidget {
  @override
  _DealerRegisterationState createState() => _DealerRegisterationState();
}

class _DealerRegisterationState extends State<DealerRegisteration> {

  AccountBloc _accountBloc;
  File image;
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {

    _accountBloc = BlocProvider.of<AccountBloc>(context);

    final _formKey = GlobalKey<FormState>();
    final _nameTextController = TextEditingController();
    final _phoneTextController = TextEditingController();
    final _addressTextController = TextEditingController();
    final _detailsTextController = TextEditingController();


        return Scaffold(
           appBar: AppBar(
             title: Column(
               children: [
                 Text(
                   'BULLION RATES',
                   style: TextStyle(
                     color: Colors.black,
                     fontWeight: FontWeight.bold,
                     fontStyle: FontStyle.italic,
                     fontSize: 22.0,
                   ),
                 ),
                 Text(
                   'chennai',
                   style: TextStyle(
                     color: Colors.blueGrey,
                     fontWeight: FontWeight.bold,
                     fontStyle: FontStyle.italic,
                     fontSize: 12.0,
                   ),
                 ),
               ],
             ),
             centerTitle: true,
             backgroundColor: Colors.white,
             elevation: 0.0,
           ),
           body: Container(
             color: Colors.white,
             child: ListView(
               children: [

                 SizedBox(
                   height: 20.0,
                 ),

                 BlocListener<AccountBloc,AccountState>(
                   listener:(context,state){

                     if(state is DashBoardLoadingState){
                       return CircularProgressIndicator(
                         backgroundColor: Style.yellowColor,
                       );
                     }else if(state is RegisterDealerState){
                        Navigator.of(context).pushNamed('/quotePage');
                     }else if(state is FirebaseErrorState){
                        return Center(
                          child: Text('An error has occured while updating firebase ${state.errMsg}',
                          style: Style.subTextStyle,
                          ),
                        );
                     }

                   },
                   child: BlocBuilder<AccountBloc,AccountState>(
                     builder: (context,state){
                       return  Container(
                         child: bodyAsPerState(state),
                       );
                     },
                   ),
                 ),
                 SizedBox(
                   height: 30.0,
                 ),
                 Center(
                   child: Container(
                     height: 500,
                     width: 390,
                     decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(10.0),
                         color: Style.yellowColor),
                     child: Form(
                       key: _formKey,
                       child: Column(
                         children: [
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: [
                                 Text(
                                   'Dealer Name ',
                                   style:Style.descTextStyle
                                 ),
                                 SizedBox(
                                   width: 20.0,
                                 ),
                                 Container(
                                   height: 60,
                                   width: 240,
                                   decoration: BoxDecoration(
                                     color: Style.halfWhiteColor,
                                     borderRadius: BorderRadius.circular(10.0),
                                   ),
                                   child: TextFormField(
                                     controller: _nameTextController,
                                     cursorColor: Colors.black,
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(10.0),
                                     ),
                                     style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontStyle: FontStyle.italic,
                                         fontSize: 18.0),
                                     validator: (value) {
                                       if (value == '' || value.isEmpty) {
                                         return 'Dealer Name cannot be empty';
                                       } else {
                                         return null;
                                       }
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(
                             height: 10.0,
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: [
                                 Text(
                                   'Contact no   ',
                                   style: Style.descTextStyle
                                 ),
                                 SizedBox(
                                   width: 25.0,
                                 ),
                                 Container(
                                   height: 60,
                                   width: 240,
                                   decoration: BoxDecoration(
                                     color:Style.halfWhiteColor,
                                     borderRadius: BorderRadius.circular(10.0),
                                   ),
                                   child: TextFormField(
                                     controller: _phoneTextController,
                                     keyboardType: TextInputType.number,
                                     cursorColor: Colors.black,
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(10.0),
                                     ),
                                     style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontStyle: FontStyle.italic,
                                         fontSize: 18.0),
                                     validator: (value) {
                                       if (value.length != 10) {
                                         return 'Not valid number!';
                                       } else {
                                         return null;
                                       }
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(
                             height: 10.0,
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: [
                                 Text(
                                   'Address ',
                                   style: Style.descTextStyle
                                 ),
                                 SizedBox(
                                   width: 50.0,
                                 ),
                                 Container(
                                   height: 120,
                                   width: 240,
                                   decoration: BoxDecoration(
                                     color: Style.halfWhiteColor,
                                     borderRadius: BorderRadius.circular(10.0),
                                   ),
                                   child: TextFormField(
                                     controller: _addressTextController,
                                     cursorColor: Colors.black,
                                     keyboardType: TextInputType.multiline,
                                     minLines: 1,
                                     maxLines: 3,
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(10.0),
                                     ),
                                     style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontStyle: FontStyle.italic,
                                         fontSize: 18.0),
                                     validator: (value) {
                                       if (value == '' || value.isEmpty) {
                                         return 'Address cannot be empty';
                                       } else {
                                         return null;
                                       }
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                           SizedBox(
                             height: 10.0,
                           ),
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Row(
                               children: [
                                 Text(
                                   'About You ',
                                   style: Style.descTextStyle,
                                 ),
                                 SizedBox(
                                   width: 30.0,
                                 ),
                                 Container(
                                   height: 140,
                                   width: 240,
                                   decoration: BoxDecoration(
                                     color: Style.halfWhiteColor,
                                     borderRadius: BorderRadius.circular(10.0),
                                   ),
                                   child: TextFormField(
                                     controller: _detailsTextController,
                                     cursorColor: Colors.black,
                                     keyboardType: TextInputType.multiline,
                                     minLines: 1,
                                     maxLines: 3,
                                     decoration: InputDecoration(
                                       border: InputBorder.none,
                                       contentPadding: EdgeInsets.all(10.0),
                                     ),
                                     style: TextStyle(
                                         fontWeight: FontWeight.bold,
                                         fontStyle: FontStyle.italic,
                                         fontSize: 18.0),
                                     validator: (value) {
                                       if (value == '' || value.isEmpty) {
                                         return 'About You cannot be empty';
                                       } else {
                                         return null;
                                       }
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                         ],
                       ),
                     ),
                   ),
                 ),
                 SizedBox(
                   height: 30.0,
                 ),
                 Builder(
                   builder: (context) => GestureDetector(
                     onTap: () {
                       if (image == null) {
                         Scaffold.of(context)
                           ..hideCurrentSnackBar()
                           ..showSnackBar(SnackBar(
                             content: Row(
                               children: [
                                 Text('Please add Logo'),
                               ],
                             ),
                           ));
                       }

                       if (_formKey.currentState.validate() && image != null) {
                         Scaffold.of(context)
                           ..hideCurrentSnackBar()
                           ..showSnackBar(SnackBar(
                             content: Row(
                               children: [
                                 Text('Detail Updated Successfully'),
                               ],
                             ),
                           ));

                         _accountBloc.add(RegisterDealerEvent(name: _nameTextController.text,ph: _phoneTextController.text,address: _addressTextController.text,details: _detailsTextController.text,image: image));
                         _formKey.currentState.reset();
                       }
                     },
                     child: Padding(
                       padding: const EdgeInsets.only(left:50.0,right: 50.0),
                       child: Container(
                         height: 50,
                         width: 60,
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.only(
                             topLeft: Radius.circular(10.0),
                             topRight: Radius.circular(10.0),
                           ),
                           color: Style.lightBlueColor,
                         ),
                         child: Center(
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.center,
                               children: [
                                 Text(
                                   'update',
                                   style: Style.descTextStyle
                                 ),
                                 SizedBox(width: 5.0,),
                                 Icon(Icons.upload_outlined,
                                 color: Colors.white,
                                 ),
                               ],
                             )),
                       ),
                     ),
                   ),
                 ),
               ],
             ),
       ));

  }




  Future getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);

    _accountBloc.add(SetImageEvent(image: image));

  }


  bodyAsPerState(AccountState state){
    if (state is InitialAccountState) {
      return Center(
        child: Container(
          height: 70,
          width: 390,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Style.yellowColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Logo ',
                style: Style.descTextStyle,
              ),
              Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Style.halfWhiteColor,
                ),
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: GestureDetector(
                    onTap: () => getImage(),
                    child: Icon(
                      Icons.image,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  radius: 70,
                ),
              )
            ],
          ),
        ),
      );
    } else if (state is SetImageState) {
      image = state.image;
      return Center(
        child: Container(
          height: 70,
          width: 390,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Style.yellowColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Logo ',
                style: Style.descTextStyle,
              ),
              Container(
                height: 70,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.0),
                  color: Style.halfWhiteColor,
                ),
                child: state.image != null
                    ? GestureDetector(
                  onTap: () => getImage(),
                  child: Center(
                    child: Text('logo uploaded',
                    style: Style.normalTextStyle,
                    ),
                  )
                )
                    : CircleAvatar(
                  child: GestureDetector(
                    onTap: () => getImage(),
                    child: Icon(
                      Icons.image,
                      size: 35,
                      color: Colors.black,
                    ),
                  ),
                  radius: 50,
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: Text(
            'Undefined Error in Acccount Builder -- Account Page'),
      );
    }
  }


}
