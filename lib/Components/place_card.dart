import 'package:edva/Models/place.dart';
import 'package:edva/Utils/colors.dart';
import 'package:edva/Utils/global_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceCard extends StatelessWidget{

  final Place place;
  const PlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 110,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: EdvaColors.grayNurse)
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        children: [
          Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              width: 40,
              height: 40,
              child: const Icon(Icons.location_on, color: EdvaColors.deYork, size: 40) //const FaIcon(FontAwesomeIcons.gps, color: EdvaColors.apple),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  GlobalFunctions.parseText(place.name),
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontSize: 16, fontWeight: FontWeight.bold))
                ),
                Text(place.address, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 13, fontWeight: FontWeight.w500))),
                //Text('horarios: 08:00 - 13:00 / 16:00 - 19:00', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 13, fontWeight: FontWeight.w400)))
              ],
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }

}