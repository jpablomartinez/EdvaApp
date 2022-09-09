// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:edva/Models/region.dart';
import 'package:edva/Utils/chile.dart';

class GlobalFunctions {

  static int getNearestRegion(double latitude, double longitude){
    if(regionLocation.first.latitude <= latitude) return 0;
    else if(regionLocation.last.latitude >= latitude) return regionLocation.length - 1;
    else {
      for(int i = 0; i < regionLocation.length - 1; i++){
        if(regionLocation[i].latitude > latitude && latitude > regionLocation[i+1].latitude) return i;
      }
    }
    return 6;
  }

  static String parseText(String text){
     if(text.contains('(')) {
      int i = text.indexOf('(');
      return text.substring(0,i);
    }
    return text;
  }

  static int getWaitTimeIndex(String a){
    if(a == 'menos de 1 hora') return 0;
    else if(a == 'entre 1 y 2 hrs') return 1;
    else if(a == 'más de 2 horas') return 2;
    else return -1;
  }

  static int getDoseIndex(String a){
    if(a == 'Primera dosis') return 0;
    else if(a == 'Segunda dosis') return 1;
    else if(a == 'Refuerzo') return 2;
    else return -1;
  }

  static String parseScore(double score){
    String tmp = '$score'.split('.')[1];
    if(int.parse(tmp) == 0) return score.toStringAsFixed(0);
    return '$score';
  }


}