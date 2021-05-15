import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_phone_auth_bloc/bloc/dealer_nav_bloc/dealer_nav_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/dealer_nav_bloc/dealer_nav_events.dart';
import 'package:firebase_phone_auth_bloc/bloc/dealer_nav_bloc/dealer_nav_states.dart';
import 'package:firebase_phone_auth_bloc/bloc/networkBloc/network_bloc.dart';
import 'package:firebase_phone_auth_bloc/bloc/networkBloc/network_states.dart';
import 'package:firebase_phone_auth_bloc/data/data_repository.dart';
import 'package:firebase_phone_auth_bloc/data/user_repository.dart';
import 'package:firebase_phone_auth_bloc/themes/style.dart';
import 'package:firebase_phone_auth_bloc/ui/dealer_registeration_page.dart';
import 'package:firebase_phone_auth_bloc/ui/buyer_page_dashboard.dart';
import 'package:firebase_phone_auth_bloc/ui/dealer_dasboard_page.dart';
import 'package:firebase_phone_auth_bloc/ui/logout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DealerNavPage extends StatefulWidget {

  final DataRepository dataRepository;
  final UserRepo userRepo;

  DealerNavPage({@required this.dataRepository,@required this.userRepo});

  @override
  _DealerNavPageState createState() => _DealerNavPageState();
}

class _DealerNavPageState extends State<DealerNavPage> {


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkBloc,NetworkState>(
      builder: (context,state){
        if(state is ConnectionFailure){
          return Scaffold(
            body: Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Ooops !,Something went wrong,Please check your internet connection',
              style: Style.normalTextStyle,),
            )),
          );
        }else if(state  is ConnectionSuccess){
          return BlocProvider<NavDrawerBloc>(
            create: (context)=>NavDrawerBloc(dataRepository: widget.dataRepository,userRepo: widget.userRepo),
            child: BlocBuilder<NavDrawerBloc, NavDrawerState>(
              builder: (context, state) {
                return Scaffold(
                  drawer: StreamBuilder(
                    stream: FirebaseFirestore.instance.collection('dealers').doc(widget.dataRepository.userId).snapshots(),
                    builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {

                      if(!snapshot.hasData||snapshot.hasError){
                        return NavDrawerWidget("Dealer Name", "Dealer Contact Number");
                      }else if(snapshot.connectionState == ConnectionState.active){
                        return NavDrawerWidget(snapshot.data['dealerName'], snapshot.data['dealerPhone'],);
                      }else if(snapshot.connectionState == ConnectionState.waiting){
                        return CircularProgressIndicator(backgroundColor: Style.yellowColor,);
                      }
                      return NavDrawerWidget(snapshot.data['dealerName'], snapshot.data['dealerPhone'],);
                    }
                  ),
                  body: _bodyForState(state,widget.dataRepository),
                );
              },
            ),
          );
        }return BlocProvider<NavDrawerBloc>(
          create: (context)=>NavDrawerBloc(),
          child: BlocBuilder<NavDrawerBloc, NavDrawerState>(
            builder: (context, state) {
              return Scaffold(
                drawer: NavDrawerWidget("Dealer Name", "Dealer Contact Number"),
                body: _bodyForState(state,widget.dataRepository),
              );
            },
          ),
        );
      },

    );
  }
}

Widget _bodyForState(NavDrawerState state,DataRepository dataRepository) {
  if (state.selectedItem == NavItem.page_one) {
    return DealerDashBoardProvider();
  } else if (state.selectedItem == NavItem.page_two) {
    return Center(child: Text('Previous Rates'));
  } else if (state.selectedItem == NavItem.page_three) {
    return DealerRegisterationProvider(dataRepository:dataRepository,);
  } else if (state.selectedItem == NavItem.page_four) {
    return BuyerDashBoard();
  } else if (state.selectedItem == NavItem.page_five) {
    return LogOut(dataRepository: dataRepository,);
  }

}

class NavDrawerWidget extends StatelessWidget {
  final String accountName;
  final String accountEmail;

  NavDrawerWidget(this.accountName, this.accountEmail);

  final List<_NavigationItem> _listItems = [
    _NavigationItem(true, null, null, null),
    _NavigationItem(false, NavItem.page_one, "DashBoard", Icons.dashboard),
    _NavigationItem(false, NavItem.page_two, "Previous Rates", Icons.flip_to_back),
    _NavigationItem(false, NavItem.page_three, "My Account", Icons.account_box_rounded),
    _NavigationItem(false, NavItem.page_four, "Buyers DashBoard", Icons.add_shopping_cart),
    _NavigationItem(false, NavItem.page_five, "log out", Icons.logout),

  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: ListView.builder(
            itemCount: _listItems.length,
            itemBuilder: (BuildContext context, int index) {
              return BlocBuilder<NavDrawerBloc, NavDrawerState>(
                builder: (context, state) {
                  return _buildItem(_listItems[index], state);
                },
              );
            }),
      ),
    );
  }

  Widget _buildItem(_NavigationItem data, NavDrawerState state) =>
      data.header ? _makeHeaderItem() : _makeListItem(data, state);

  Widget _makeHeaderItem() => UserAccountsDrawerHeader(
        accountName: Text(accountName, style: TextStyle(color: Colors.white)),
        accountEmail: Text(accountEmail, style: TextStyle(color: Colors.white)),
        decoration: BoxDecoration(color: Colors.blueGrey),
        currentAccountPicture: CircleAvatar(
          backgroundColor: Colors.white,
          foregroundColor: Colors.amber,
          child: Icon(
            Icons.person,
            size: 54,
          ),
        ),
      );

  Widget _makeListItem(_NavigationItem data, NavDrawerState state) => Card(
        color: data.item == state.selectedItem ? Style.yellowColor : Colors.white,
        shape: ContinuousRectangleBorder(borderRadius: BorderRadius.zero),
        borderOnForeground: true,
        elevation: 0,
        margin: EdgeInsets.zero,
        child: Builder(
          builder: (BuildContext context) => ListTile(
            title: Text(
              data.title,
              style: TextStyle(
                color: data.item == state.selectedItem
                    ? Colors.blueGrey
                    : Colors.blueGrey,
              ),
            ),
            leading: Icon(
              data.icon,
              // if it's selected change the color
              color: data.item == state.selectedItem
                  ? Colors.blueGrey
                  : Colors.blueGrey,
            ),
            onTap: () => _handleItemClick(context, data.item),
          ),
        ),
      );

  void _handleItemClick(BuildContext context, NavItem item) {
    BlocProvider.of<NavDrawerBloc>(context).add(NavigateTo(item));
    Navigator.pop(context);
  }
}

class _NavigationItem {
  final bool header;
  final NavItem item;
  final String title;
  final IconData icon;
  _NavigationItem(this.header, this.item, this.title, this.icon);
}
