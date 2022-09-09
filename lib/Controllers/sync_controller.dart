// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:edva/Models/place.dart';
import 'package:edva/Models/score.dart';
import 'package:edva/Utils/routes.dart';

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

  ///get vaccinate places on chilean's region
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
      return vaccinatePlaces;
    }
  }

  ///post user feedback
  Future<bool> postFeedback(String type, String comments) async {
    try{
      Dio dio = Dio();
      Map m = {
        'type': type,
        'comments': comments
      };
      Response response = await dio.post(Routes.postFeedback, data: m).timeout(const Duration(seconds: 30));
      return response.statusCode == 200 && response.data['op'] == 1;
    }
    catch(e,s){
      return false;
    }
  }

  ///post experience
  Future<bool> postExperience(int placeId, int waitTime, int dose, int score, String vaccine) async {
    try{
      Dio dio = Dio();
      Map data = {
        'place_id': placeId,
        'waitTime': waitTime,
        'dose': dose,
        'score': score,
        'vaccine': vaccine
      };
      Response response = await dio.post(Routes.postExperience, data: data).timeout(const Duration(seconds: 30));
      return response.statusCode == 200 && response.data['op'] == 1;
    }
    catch(e,s){
      return false;
    }
  }

  ///get score from selected place
  ///show average from all experiences collected from users and show how many are they
  Future<Score> getScore(int placeId) async {
    try{
      Response response = await Dio().get('${Routes.getScore}/$placeId');
      if(response.statusCode == 200 && response.data['op'] == 1){
        return Score.fromJson(response.data['data']);
      }
      else return Score(score: 0, opinions: 0);
    }
    catch(e,s){
      return Score(score: 0, opinions: 0);
    }
  }



}