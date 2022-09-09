import 'package:geolocator/geolocator.dart';

class LocationController {

  final GeolocatorPlatform geolocatorPlatform = GeolocatorPlatform.instance;

  Future<bool> handlePermission() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    serviceEnabled = await geolocatorPlatform.isLocationServiceEnabled();
    if(!serviceEnabled) return false;
    permission = await geolocatorPlatform.checkPermission();
    if(permission == LocationPermission.deniedForever || permission == LocationPermission.denied){
      permission = await geolocatorPlatform.requestPermission();
      return permission == LocationPermission.always || permission == LocationPermission.whileInUse;
    }
    return true;
  }

  Future<Position> getCurrentPosition() async {
    return await geolocatorPlatform.getCurrentPosition();
  }



}