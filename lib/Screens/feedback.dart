import 'package:edva/Components/header.dart';
import 'package:edva/Screens/layout.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;

class UserFeedback extends StatefulWidget {

  const UserFeedback({Key? key}) : super(key: key);

  @override
  _Feedback createState()=> _Feedback();

}

class _Feedback extends State<UserFeedback>{

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController comments = TextEditingController();
  String feedbackType = 'Problema con sede';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Layout(
      header: const Header(
        title: 'Feedback',
      ),
      child: Column(
        children: [
          Container(
            height: 100,
            padding: const EdgeInsets.all(15),
            child: Text(
              'Si ves algún error, o si las  sedes mostradas ya no son sedes de vacunación o simplemente quieres dejar tufeedback déjame tu comentario y lo revisaré a la brevedad',
              style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w400, fontSize: 15)),
              softWrap: true,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            height: 40,
            width: size.width*0.85,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.80),
              borderRadius: BorderRadius.circular(50)
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextField(
              controller: nameController,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Nombre',
                hintStyle: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 14, fontStyle: FontStyle.italic))
              ),
            ),
          ),
          Container(
            height: 40,
            width: size.width*0.85,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.80),
                borderRadius: BorderRadius.circular(50)
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Correo electrónico',
                  hintStyle: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 14, fontStyle: FontStyle.italic))
              ),
            ),
          ),
          Container(
            height: 40,
            width: size.width*0.85,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.80),
                borderRadius: BorderRadius.circular(50)
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: DropdownButton<String>(
              isExpanded: true,
              underline: Container(),
              icon: Transform.rotate(
                angle: math.pi/2,
                child: const Icon(Icons.arrow_forward_ios_outlined, color: EdvaColors.mineralGreen, size: 18),
              ),
              value: feedbackType,
              items: ['Problema con sede', 'Error', 'Otro'].map<DropdownMenuItem<String>>((String value){
                return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 14)))
                );
              }).toList(),
              hint: Text('Feedback', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
              onChanged: (dynamic value){
                setState(() {
                  feedbackType = value;
                });
              },
            )
          ),
          Container(
            width: size.width*0.85,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.80),
                borderRadius: BorderRadius.circular(15)
            ),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: TextField(
              controller: emailController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Escribe tus comentarios',
                  hintStyle: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 14, fontStyle: FontStyle.italic))
              ),
              maxLines: 8,
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: GestureDetector(
              onTap: (){},
              child: Container(
                height: 48,
                width: 210,
                decoration: BoxDecoration(
                  color: EdvaColors.killarney,
                  borderRadius: BorderRadius.circular(50)
                ),
                child: Center(
                  child: Text('ENVIAR', style: GoogleFonts.lato(textStyle: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w500)),),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}