import 'package:edva/Components/detail_place_card.dart';
import 'package:edva/Components/map.dart';
import 'package:edva/Controllers/data_controller.dart';
import 'package:edva/Screens/layout.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class Place extends StatefulWidget {

  const Place({Key? key}) : super(key: key);

  @override
  _Place createState()=> _Place();

}


class _Place extends State<Place>{

  final DataController dataController = Get.find();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Layout(
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(width: size.width, height: size.height*0.5, child: PlaceMap(lat: dataController.selectedPlace.lat, long: dataController.selectedPlace.long)),
              Positioned(
                  top: 5,
                  left: 5,
                  child: IconButton(icon: const Icon(Icons.arrow_back, color: EdvaColors.greenPea, size: 30), onPressed: ()=> Navigator.pop(context))
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text('#Cuidemonos', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontSize: 18, fontWeight: FontWeight.bold))),
          DetailPlaceCard(place: dataController.selectedPlace)
        ],
      ),
    );
  }

}