import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HelpEntry extends StatelessWidget{

  final String title;
  final String content;

  const HelpEntry({
    Key? key,
    required this.title,
    required this.content
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              title,
              style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.bold, fontSize: 20))
          ),
          const SizedBox(height: 7),
          Text(
              content,
              style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w400, fontSize: 16)),
              softWrap: true,
          )
        ],
      ),
    );
  }


}