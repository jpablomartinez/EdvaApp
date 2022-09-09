// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:edva/Components/place_card.dart';
import 'package:edva/Models/place.dart';
import 'package:edva/Models/score.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:edva/Utils/chile.dart' as chile_data;

class DataController extends GetxController{

  List<Place> allPlacesByRegion = [];
  List<Place> localPlaces = [];
  List<Widget> placesWidgets = [];
  double latitude =  -33.33333;
  double longitude = -70.66667;
  bool foundedData = false;
  bool foundedSelectedPlace = false;
  bool locationServiceEnabled = false;
  bool needToUpdateList = true;
  bool needToUpdateSelectedPlace = true;
  Place selectedPlace = Place.base();
  late Score score;
  int currentIndex = 0;
  String lastUpdate = '12:15, 23/11/2021';
  String region = chile_data.regions[0];
  String commune = chile_data.communes[0][0];
  int selectedIndex = 0;
  bool searchingVaccinatePlaces = true;

  void selectPlace(Place p){
    if(selectedPlace.placeId != -1){
      if(p.placeId != selectedPlace.placeId){
        needToUpdateSelectedPlace = true;
        selectedPlace = p;
      }
      else needToUpdateSelectedPlace = false;
    }
    else selectedPlace = p;
    Get.toNamed('/place');
  }

  void addExperience(Place p){
    selectedPlace = p;
    Get.toNamed('/experience');
  }

  void updateListPlacesByRegionCommune(String commune){
    List<Place> tmp = allPlacesByRegion.where((place) => place.city == commune).toList();
    List<Widget> _places = [];
    for(var place in tmp){
      Widget infoPlace = PlaceCard(place: place, onTapFunction: ()=>selectPlace(place), experienceFunction: ()=> addExperience(place));
      _places.add(infoPlace);
    }
    placesWidgets = _places;
    update();
  }

  void clearPlacesByRegionCommune(){
    placesWidgets = [];
    update();
  }

}