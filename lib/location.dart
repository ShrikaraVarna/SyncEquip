import 'package:geolocator/geolocator.dart';

class Geolocation{
  final Geolocator geo= Geolocator();

  Stream<Position> getCurrentLocation() {
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);
    return Geolocator.getPositionStream(desiredAccuracy: LocationAccuracy.bestForNavigation, distanceFilter: 1);
  }

  Future<Position> getInitialLocation() async{
    return Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
  }

}//End of location class