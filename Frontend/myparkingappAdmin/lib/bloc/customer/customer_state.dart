import 'package:myparkingappadmin/data/dto/response/user_response.dart';

abstract class  UserState{}

class  UserInitial extends UserState{

}

class  CustomerLoadingState extends UserState{

}

class  CustomerLoadedState extends UserState{
  List<UserResponse> customerList;
  CustomerLoadedState(this.customerList);

}

class  CustomerErrorState extends UserState{
  String mess;
  CustomerErrorState(this.mess);
}

class  CustomerSuccessState extends UserState{
  String mess;
  CustomerSuccessState(this.mess);
}






class  OwnerSuccessState extends UserState{
  String mess;
  OwnerSuccessState(this.mess);
}

class  OwnerLoadingState extends UserState{

}

class  OwnerLoadedState extends UserState{
  List<UserResponse> ownerList;
  OwnerLoadedState(this.ownerList);

}

class  OwnerErrorState extends UserState{
  String mess;
  OwnerErrorState(this.mess);
}

class InfoState extends UserState{
  String mess;
  InfoState(this.mess);
}