abstract class MainScreenEvent{
}
class LoadHomeScreenInitialByFilter extends MainScreenEvent{
  final double maxMoney;
  final double minMoney;
  final String token;

  LoadHomeScreenInitialByFilter(this.maxMoney,this.minMoney,this.token);

}

class LoadParkingSLot extends MainScreenEvent{
  final String token;
  LoadParkingSLot(this.token);
}

