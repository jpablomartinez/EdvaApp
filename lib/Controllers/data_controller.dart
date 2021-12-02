import 'package:edva/Components/place_card.dart';
import 'package:edva/Models/place.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DataController extends GetxController{
  
  List<Place> allPlacesByRegion = [];
  List<Place> localPlaces = [];
  List<Widget> placesWidgets = [];
  double latitude = 0;
  double longitude = 0;
  bool foundedData = false;
  bool locationServiceEnabled = false;
  DateTime startApp = DateTime.now();
  late Place selectedPlace;
  int currentIndex = 0;
  String lastUpdate = '08:00, 24/12/2021';

  void selectPlace(Place p){
    selectedPlace = p;
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

}