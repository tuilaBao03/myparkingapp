abstract class InvoiceEvent{}


class GetInvoiceByLotEvent extends InvoiceEvent{
  String parkingLotId;
  GetInvoiceByLotEvent(this.parkingLotId);
}

class GetInvoiceBySlotEvent extends InvoiceEvent{
  String parkingSlotId;
  GetInvoiceBySlotEvent(this.parkingSlotId);
}