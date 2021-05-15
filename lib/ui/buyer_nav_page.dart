import 'package:firebase_phone_auth_bloc/bloc/buyer_nav_bloc/buyer_nav_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/buyer_nav_bloc/buyer_nav_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/buyer_nav_bloc/buyer_nav_state.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'buyer_page_dashboard.dart';

class BuyerNavPage extends StatefulWidget {
  @override
  _BuyerNavPageState createState() => _BuyerNavPageState();
}

class _BuyerNavPageState extends State<BuyerNavPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuyerNavDrawerBloc>(
      create: (context) => BuyerNavDrawerBloc(),
      child: BlocBuilder<BuyerNavDrawerBloc,BuyNavDrawerState>(
        builder: (context,state){
          return Scaffold(
            drawer: BuyNavDrawerWidget("BullionRates", "chennai"),
            body: _bodyForState(state),
          );
        },
      ),
    );
  }
}


Widget _bodyForState(BuyNavDrawerState state){

  if(state.selectedItem == NavItem.page_one){
    return BuyerDashBoard();
  }else if(state.selectedItem == NavItem.page_two){
    return Center(child: Text('Second screen'));
  }else if(state.selectedItem == NavItem.page_three){
    return Center(child: Text('Third Screen'));
  }else if(state.selectedItem ==  NavItem.page_four){
    return Center(child: Text('Fourth screen'));
  }


}

class BuyNavDrawerWidget extends StatelessWidget {

  final String name;
  final String location;

  BuyNavDrawerWidget(this.name,this.location);

  final List<_NavigationItem> _listItem =[
    _NavigationItem(true, null, null, null),
    _NavigationItem(false, NavItem.page_one, "Page one", Icons.add),
    _NavigationItem(false, NavItem.page_two, "Page two", Icons.add),
    _NavigationItem(false, NavItem.page_three, "Page three", Icons.add),
    _NavigationItem(false, NavItem.page_four, "Page four", Icons.add),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        child: ListView.builder(
          itemCount: _listItem.length,
          itemBuilder: (BuildContext context,int index){
            return BlocBuilder<BuyerNavDrawerBloc,BuyNavDrawerState>(
              builder: (context,state){
                return _buildItem(_listItem[index],state);
              },
            );
          },

        ),
      ),
    );
  }

  Widget _buildItem(_NavigationItem data,BuyNavDrawerState state) =>
      data.header ? _makeHeaderItem() :_makeListItem(data,state);

  Widget _makeHeaderItem()=>UserAccountsDrawerHeader(
      accountName:Text(name,style: TextStyle(color: Colors.white),),
      accountEmail: Text(location,style: TextStyle(color: Colors.white),));

  Widget _makeListItem(_NavigationItem data, BuyNavDrawerState state)=>Card(
    color: data.item ==state.selectedItem?Style.yellowColor:Colors.white,
    shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
    borderOnForeground: true,
    margin: EdgeInsets.zero,
    elevation: 0,
    child: Builder(
      builder: (BuildContext context)=>ListTile(
        title: Text(data.title,
        style: TextStyle(
          color: Colors.blueGrey,
        ),),
        leading: Icon(
          data.iconData,
          color: Colors.blueGrey,
        ),
        onTap: ()=>_handleItemClick(context,data.item),
      ),
    ),
  );

  void _handleItemClick(BuildContext context,NavItem item){
    BlocProvider.of<BuyerNavDrawerBloc>(context).add(BuyNavigateTo(item));
    Navigator.pop(context);
  }
}

class _NavigationItem{

  final bool header;
  final NavItem item;
  final String title;
  final IconData iconData;

  _NavigationItem(this.header,this.item,this.title,this.iconData);

}