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

  void updateListPlacesByRegionCommune(String commune){
    List<Place> tmp = allPlacesByRegion.where((place) => place.city == commune).toList();
    List<Widget> _places = [];
    for(var place in tmp){
      Widget infoPlace = PlaceCard(place: place);
      _places.add(infoPlace);
    }
    placesWidgets = _places;
    update();
  }

}