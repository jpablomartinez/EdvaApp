// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:edva/Models/place.dart';
import 'package:edva/Utils/routes.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SyncController {

  ///Checks if mobile is connected to wifi or mobile data
  Future<bool> isConnected() async{
    var conn = await Connectivity().checkConnectivity();
    if(conn == ConnectivityResult.mobile || conn == ConnectivityResult.wifi) return checkConnection();
    else return false;
  }

  ///Checks if device can use internet
  Future<bool> checkConnection() async {
    bool hasConn = false;
    try{
      final res = await InternetAddress.lookup('www.google.com');
      if(res.isNotEmpty && res[0].rawAddress.isNotEmpty) hasConn = true;
    } on SocketException catch(_){
      hasConn = false;
    }
    return hasConn;
  }

  Future<List<Place>> getVaccinatePlacesFromRegion(String region) async {
    List<Place> vaccinatePlaces = [];
    try{
      Dio dio = Dio();
      Response response = await dio.get('${Routes.getPlacesFromRegion}/$region').timeout(const Duration(seconds: 30));
      if(response.statusCode == 200 && response.data['places'].isNotEmpty){
        List places = response.data['places'];
        for(var place in places){
          vaccinatePlaces.add(Place.fromJson(place));
        }
        return vaccinatePlaces;
      }
      else return vaccinatePlaces;
    }
    catch(e,s){
      print(e);
      print(s);
      return vaccinatePlaces;
    }

  }

}