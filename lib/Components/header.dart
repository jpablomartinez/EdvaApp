import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget{

  final String title;
  final String? subtitle;

  const Header({Key? key, required this.title, this.subtitle}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontSize: 27, fontWeight: FontWeight.bold))),
              subtitle != null ?
              Text(subtitle!, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontSize: 12, fontWeight: FontWeight.w400)))
              :
              Container()
            ],
          ),
          Text('#Cuidemonos', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontSize: 18, fontWeight: FontWeight.w500)))
        ],
      ),
    );
  }

}