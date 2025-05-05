  import 'package:myparkingappadmin/data/dto/response/discount_response.dart';
import 'package:myparkingappadmin/data/dto/response/images.dart';
import 'package:myparkingappadmin/data/dto/response/invoice_response.dart';
import 'package:myparkingappadmin/data/dto/response/monthlyTicket_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingLot_response.dart';
import 'package:myparkingappadmin/data/dto/response/parkingSlot_response.dart';
import 'package:myparkingappadmin/data/dto/response/transaction_response.dart';
import 'package:myparkingappadmin/data/dto/response/user_response.dart';
import 'package:myparkingappadmin/data/dto/response/wallet_response.dart';

  // 1. Tạo danh sách người dùng (Users)
  List<UserResponse> users = [
    UserResponse(
      userId: 'user123',
      username: 'john_doe',
      phone: '0123456789',
      homeAddress: '123 Đường A',
      companyAddress: '456 Đường B',
      lastName: 'Doe',
      firstName: 'John',
      avatar: Images("", null, null),
      email: 'john@example.com',
      status: UserStatus.ACTIVE,
      roles: ['USER'],
    ),
    UserResponse(
      userId: 'user124',
      username: 'jane_doe',
      phone: '0987654321',
      homeAddress: '789 Đường X',
      companyAddress: '101 Đường Y',
      lastName: 'Doe',
      firstName: 'Jane',
      avatar: Images("", null, null),
      email: 'jane@example.com',
      status: UserStatus.INACTIVE,
      roles: ['USER'],
    ),

  ];
    List<UserResponse> owners = [

          UserResponse(
      userId: 'user124',
      username: 'jane_doe',

      phone: '0987654321',
      homeAddress: '789 Đường X',
      companyAddress: '101 Đường Y',
      lastName: 'Doe',
      firstName: 'Jane',
      avatar: Images("", null, null),
      email: 'jane@example.com',
      status: UserStatus.INACTIVE,
      roles: ['OWNER'],
    ),
    UserResponse(
      userId: 'user124',
      username: 'jane_doe',
      phone: '0987654321',
      homeAddress: '789 Đường X',
      companyAddress: '101 Đường Y',
      lastName: 'Doe',
      firstName: 'Jane',
      avatar: Images("", null, null),
      email: 'jane@example.com',
      status: UserStatus.INACTIVE,
      roles: ['USER'],
    ),
  ];

  // 2. Tạo danh sách ví (Wallets)
  List<WalletResponse> wallets = [
    WalletResponse(
      walletId: 'wallet123',
      userId: 'user123',
      name: 'Ví chính',
      balance: 500000.0,
      status: true,
      currency: 'VND',
    ),
    WalletResponse(
      walletId: 'wallet124',
      userId: 'user124',
      name: 'Ví phụ',
      balance: 300000.0,
      status: true,
      currency: 'VND',
    ),
  ];

  // 3. Tạo danh sách bãi đỗ xe (Parking Lots)
  List<ParkingLotResponse> parkingLots = [
    ParkingLotResponse(
      parkingLotId: 'lot001',
      parkingLotName: 'Bãi đỗ xe Trung tâm',
      address: '789 Đường C',
      latitude: 21.0285,
      longitude: 105.8542,
      totalSlot: 50,
      status: LotStatus.FULL_SLOT,
      rate: 4.5,
      description: 'Bãi đỗ xe có mái che',
      userId: 'user123',
      images: []
    ),
    ParkingLotResponse(
      parkingLotId: 'lot002',
      parkingLotName: 'Bãi đỗ xe Quận 1',
      address: '123 Đường Z',
      latitude: 21.0240,
      longitude: 105.8531,
      totalSlot: 30,
      status: LotStatus.FULL_SLOT,
      rate: 3.5,
      description: 'Bãi đỗ xe ngoài trời',
      userId: 'user124',
      images: [],
    ),
  ];

  // 4. Tạo danh sách vị trí đỗ xe (Parking Slots)
  List<ParkingSlotResponse> parkingSlots = [
    ParkingSlotResponse(
      slotId: 'slotA1',
      slotName: '1-A1',
      vehicleType: 'car',
      slotStatus: SlotStatus.AVAILABLE,
      pricePerHour: 15000,
      pricePerMonth: 1000000,
      parkingLotId: 'lot001',
    ),
    ParkingSlotResponse(
      slotId: 'slotA2',
      slotName: '1-A2''assets/images/abc.png',
      vehicleType: 'motorbike',
      slotStatus: SlotStatus.OCCUPIED,
      pricePerHour: 10000,
      pricePerMonth: 500000,
      parkingLotId: 'lot002',
    ),
    ParkingSlotResponse(
      slotId: 'slotA3',
      slotName: '1-A3',
      vehicleType: 'motorbike',
      slotStatus: SlotStatus.OCCUPIED,
      pricePerHour: 10000,
      pricePerMonth: 500000,
      parkingLotId: 'lot002',
    ),
    ParkingSlotResponse(
      slotId: 'slotA4',
      slotName: '1-A4',
      vehicleType: 'motorbike',
      slotStatus: SlotStatus.OCCUPIED,
      pricePerHour: 10000,
      pricePerMonth: 500000,
      parkingLotId: 'lot002',
    ),
    


    ParkingSlotResponse(
      slotId: 'slotA1',
      slotName: '2-A1',
      vehicleType: 'car',
      slotStatus: SlotStatus.AVAILABLE,
      pricePerHour: 15000,
      pricePerMonth: 1000000,
      parkingLotId: 'lot001',
    ),
    ParkingSlotResponse(
      slotId: 'slotA2',
      slotName: '2-A2',
      vehicleType: 'motorbike',
      slotStatus: SlotStatus.OCCUPIED,
      pricePerHour: 10000,
      pricePerMonth: 500000,
      parkingLotId: 'lot002',
    ),
    ParkingSlotResponse(
      slotId: 'slotA3',
      slotName: '2-A3',
      vehicleType: 'motorbike',
      slotStatus: SlotStatus.OCCUPIED,
      pricePerHour: 10000,
      pricePerMonth: 500000,
      parkingLotId: 'lot002',
    ),
    ParkingSlotResponse(
      slotId: 'slotA4',
      slotName: '2-A4',
      vehicleType: 'motorbike',
      slotStatus: SlotStatus.OCCUPIED,
      pricePerHour: 10000,
      pricePerMonth: 500000,
      parkingLotId: 'lot002',
    ),
  ];

  // 5. Tạo danh sách vé tháng (Monthly Tickets)
  List<MonthlyTicketResponse> monthlyTickets = [
    MonthlyTicketResponse(
      monthlyTicketId: 'ticket001',
      userId: 'user123',
      invoiceId: 'inv001',
      parkingSlotId: 'slotA1',
      createAt: DateTime.now().subtract(Duration(days: 15)),
      expireAt: DateTime.now().add(Duration(days: 15)),
    ),
  ];

  // 6. Tạo danh sách hóa đơn (Invoices)
  List<InvoiceResponse> invoices = [
    InvoiceResponse(
      invoiceId: 'inv001',
      totalAmount: 1000000,
      status: InvoiceStatus.PAID,
      description: 'Thanh toán vé tháng',
      parkingSlotId: 'slotA1',
      vehicle: '29A-12345',
      monthlyTicketId: 'ticket001',
      updateAt: DateTime.now(),
    ),
    InvoiceResponse(
      invoiceId: 'inv001',
      totalAmount: 1000000,
      status: InvoiceStatus.PAID,
      description: 'Thanh toán vé tháng',
      parkingSlotId: 'slotA1',
      vehicle: '29A-12345',
      monthlyTicketId: 'ticket001',
      updateAt: DateTime.now(),
    ),
    InvoiceResponse(
      invoiceId: 'inv001',
      totalAmount: 1000000,
      status: InvoiceStatus.PAID,
      description: 'Thanh toán vé tháng',
      parkingSlotId: 'slotA1',
      vehicle: '29A-12345',
      monthlyTicketId: 'ticket001',
      updateAt: DateTime.now(),
    ),
    InvoiceResponse(
      invoiceId: 'inv001',
      totalAmount: 1000000,
      status: InvoiceStatus.PAID,
      description: 'Thanh toán vé tháng',
      parkingSlotId: 'slotA1',
      vehicle: '29A-12345',
      monthlyTicketId: 'ticket001',
      updateAt: DateTime.now(),
    ),
    InvoiceResponse(
      invoiceId: 'inv001',
      totalAmount: 1000000,
      status: InvoiceStatus.PAID,
      description: 'Thanh toán vé tháng',
      parkingSlotId: 'slotA1',
      vehicle: '29A-12345',
      monthlyTicketId: 'ticket001',
      updateAt: DateTime.now(),
    ),
    InvoiceResponse(
      invoiceId: 'inv001',
      totalAmount: 1000000,
      status: InvoiceStatus.PAID,
      description: 'Thanh toán vé tháng',
      parkingSlotId: 'slotA1',
      vehicle: '29A-12345',
      monthlyTicketId: 'ticket001',
      updateAt: DateTime.now(),
    ),
  ];

  // 7. Tạo danh sách giảm giá (Discounts)
  List<DiscountResponse> discounts = [
    DiscountResponse(
      discountId: 'disc001',
      discountCode: 'NEWUSER10',
      discountType: DiscountType.PERCENTAGE,
      discountValue: 10.0,
      description: 'Giảm giá cho người dùng mới',
      parkingLotId: 'lot001',
    ),
  ];

  // 8. Tạo danh sách giao dịch (Transactions)
  List<TransactionResponse> transactions = [
    TransactionResponse(
      type: TransactionType.PAYMENT,
      walletId: 'wallet123',
      description: 'Thanh toán hóa đơn',
 currentBalance: 10000, createAt: DateTime.now(), transactionId: '',
    ),
    TransactionResponse(
      type: TransactionType.PAYMENT,
      walletId: 'wallet123',
      description: 'Thanh toán hóa đơn',
 currentBalance: 10000, createAt: DateTime.now(), transactionId: '',
    ),
    TransactionResponse(
      type: TransactionType.PAYMENT,
      walletId: 'wallet123',
      description: 'Thanh toán hóa đơn',
currentBalance: 10000, createAt: DateTime.now(), transactionId: '',
    ),
    TransactionResponse(
      type: TransactionType.PAYMENT,
      walletId: 'wallet123',
      description: 'Thanh toán hóa đơn',
 currentBalance: 10000, createAt: DateTime.now(), transactionId: '',
    ),
  ];

