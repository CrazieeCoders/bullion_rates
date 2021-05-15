enum NavItem{
  page_one,
  page_two,
  page_three,
  page_four,
}

class BuyNavDrawerState{

  final NavItem selectedItem;

  const BuyNavDrawerState(this.selectedItem);
}