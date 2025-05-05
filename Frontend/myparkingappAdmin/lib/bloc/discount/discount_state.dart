import 'package:myparkingappadmin/data/dto/response/discount_response.dart';

abstract class  DiscountState{}

class  DiscountInitial extends DiscountState{

}

class  DiscountLoadingState extends DiscountState{

}

class  DiscountLoadedState extends DiscountState{
  List<DiscountResponse> discountList;
  DiscountLoadedState(this.discountList);

}

class  DiscountErrorState extends DiscountState{
  String mess;
  DiscountErrorState(this.mess);
}

class  DiscountSuccessState extends DiscountState{
  String mess;
  DiscountSuccessState(this.mess);


}