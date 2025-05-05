import 'package:latlong2/latlong.dart';

abstract class LocationEvent {}


class GetLocationEvent extends LocationEvent{
  
}
class GetCurrentDistance extends LocationEvent{
  LatLng endpoint;
  GetCurrentDistance(this.endpoint);
}

class GetRouterEvent extends LocationEvent{
  LatLng endpoint;
  GetRouterEvent(this.endpoint);
}