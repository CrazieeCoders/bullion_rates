import 'package:equatable/equatable.dart';

import 'dealer_nav_states.dart';

abstract class NavDrawerEvent {
  const NavDrawerEvent();
}

class NavigateTo extends NavDrawerEvent{
  final NavItem destination;

  const NavigateTo(this.destination);

}

