// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:edva/Models/region.dart';
import 'package:edva/Utils/chile.dart';

class GlobalFunctions {

  static int getNearestRegion(double latitude, double longitude){
    if(regionLocation.first.latitude < latitude) return 0;
    else if(regionLocation.last.latitude > latitude) return regionLocation.length - 1;
    else {
      for(int i = 0; i < regionLocation.length - 1; i++){
        if(regionLocation[i].latitude > latitude && latitude > regionLocation[i+1].latitude) return i;
      }
    }
    return -1;
  }

  static String parseText(String text){
     if(text.contains('(')) {
      int i = text.indexOf('(');
      return text.substring(0,i);
    }
    return text;
  }

}