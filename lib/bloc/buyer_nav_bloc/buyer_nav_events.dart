abstract class BuyerNavDrawerEvent{
  const BuyerNavDrawerEvent();
}

class BuyNavigateTo extends BuyerNavDrawerEvent{
  final destination;

  const BuyNavigateTo(this.destination);


}