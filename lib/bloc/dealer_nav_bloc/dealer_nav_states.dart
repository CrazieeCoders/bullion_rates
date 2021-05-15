enum NavItem{
 page_one,
 page_two,
 page_three,
  page_four,
  page_five,
}



class NavDrawerState{

  final NavItem selectedItem;

  const NavDrawerState(this.selectedItem);

}