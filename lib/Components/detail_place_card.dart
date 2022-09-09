import 'package:edva/Models/place.dart';
import 'package:edva/Utils/colors.dart';
import 'package:edva/Utils/global_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPlaceCard extends StatelessWidget{

  final Place place;
  const DetailPlaceCard({Key? key, required this.place}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 13),
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
              child: const Icon(Icons.location_on, color: EdvaColors.greenPea, size: 45) //const FaIcon(FontAwesomeIcons.gps, color: EdvaColors.apple),
          ),
          Flexible(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                      GlobalFunctions.parseText(place.name),
                      style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontSize: 16, fontWeight: FontWeight.bold))
                  ),
                ),
                Text(place.address, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 14, fontWeight: FontWeight.w500))),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: Text('horarios: ${place.time}', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 12, fontWeight: FontWeight.w400)))
                ),
                ScoreWidget(score: place.score, amount: place.amount)
              ],
            ),
          ),
          const SizedBox(width: 20)
        ],
      ),
    );
  }

}

class ScoreWidget extends StatelessWidget {

  final double score;
  final int amount;

  const ScoreWidget({Key? key,
    required this.score,
    required this.amount
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
           const Icon(Icons.favorite, color: EdvaColors.greenPea, size: 15),
           Text(' ${GlobalFunctions.parseScore(score)} / 5 ($amount)', style: const TextStyle(color: EdvaColors.como, fontSize: 13, fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

}