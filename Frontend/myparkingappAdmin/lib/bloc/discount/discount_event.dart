import 'package:myparkingappadmin/data/dto/request/owner_request/create_discount_request.dart';
import 'package:myparkingappadmin/data/dto/request/owner_request/update_discount_request.dart';

abstract class DiscountEvent{}


class DiscountLoadingScreenEvent extends DiscountEvent{
  String parkingLotId;
  DiscountLoadingScreenEvent(this.parkingLotId);
}

class CreateDiscountEvent extends DiscountEvent{
  CreateDiscountResquest request;
  CreateDiscountEvent(this.request);
}

class UpdateDiscountEvent extends DiscountEvent{
  String id;
  UpdateDiscountResquest request;
  UpdateDiscountEvent(this.request,this.id);
}

class DeleteDiscountEvent extends DiscountEvent{
  String discountId;
  DeleteDiscountEvent(this.discountId);
}