// ignore_for_file: camel_case_types, file_names

import 'package:myparkingappadmin/data/dto/request/update_user_request.dart';

abstract class MainAppEvent{}

class initializationEvent extends MainAppEvent{
  initializationEvent();
}

class UpdatesUserInforEvent extends MainAppEvent{
  String userId;
  UpdateInfoRequest request;
  UpdatesUserInforEvent(this.userId,this.request);
}

class ScannerEvent extends MainAppEvent{
  bool isEntry;
  String qrString;
  ScannerEvent(this.qrString, this.isEntry);
}


class UpdatesPassEvent extends MainAppEvent{
  String userId;
  String olderPass;
  String newPass;
  UpdatesPassEvent(this.userId,this.olderPass,this.newPass);
}
class LogoutEvent extends MainAppEvent{
}




