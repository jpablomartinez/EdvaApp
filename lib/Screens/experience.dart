// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:edva/Components/header.dart';
import 'package:edva/Screens/layout.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:edva/Utils/chile.dart' as chile_data;

class Experience extends StatefulWidget {

  const Experience({Key? key}) : super(key: key);

  @override
  _Experience createState()=> _Experience();

}

class _Experience extends State<Experience>{

  String _region = chile_data.regions[0];
  int index = 0;
  String _commune = chile_data.communes[0][0];
  String place = 'A';
  String waitingTime = 'menos de 1 hora';
  String dose = 'Refuerzo';
  List<bool> hearts = [false, false, false, false];

  void updateHearts(int amount){
    List<bool> tmp = [];
    for(int i = 1; i < 5; i++) tmp.add(i <= amount);
    setState(() {
      hearts = tmp;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Layout(
      header: const Header(
        title: 'Experiencia',
      ),
      child: SizedBox(
        height: size.height*0.76,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 90,
              padding: const EdgeInsets.all(15),
              child: Text(
                'Ayúdanos compartiendo tu experiencia para que así más gente pueda tomar una mejor decisión a la hora de escoger el lugar para recibir su dosis',
                style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w400, fontSize: 15)),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
                height: 43,
                width: size.width*0.85,
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50)
                ),
                child: DropdownButton<String>(
                  isExpanded: true,
                  underline: Container(),
                  icon: Transform.rotate(
                    angle: math.pi/2,
                    child: const Icon(Icons.arrow_forward_ios_outlined, color: EdvaColors.mineralGreen, size: 18),
                  ),
                  value: _region,
                  items: chile_data.regions.map<DropdownMenuItem<String>>((String v){
                    return DropdownMenuItem<String>(
                        value: v,
                        child: Text(v, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 16)))
                    );
                  }).toList(),
                  hint: Text('regiones', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
                  onChanged: (dynamic val){
                    setState(() {
                      _region = val;
                      index = chile_data.regions.indexOf(val);
                      _commune = chile_data.communes[index][0];
                    });
                  },
                )
            ),
            Container(
              height: 43,
              width: size.width*0.85,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                icon: Transform.rotate(
                  angle: math.pi/2,
                  child: const Icon(Icons.arrow_forward_ios_outlined, color: EdvaColors.mineralGreen, size: 18),
                ),
                value: _commune,
                items: chile_data.communes[index].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 16)))
                  );
                }).toList(),
                hint: Text('comunas', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
                onChanged: (dynamic value){
                  setState(() {
                    _commune = value;
                  });
                },
              ),
            ),
            Container(
              height: 43,
              width: size.width*0.85,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                icon: Transform.rotate(
                  angle: math.pi/2,
                  child: const Icon(Icons.arrow_forward_ios_outlined, color: EdvaColors.mineralGreen, size: 18),
                ),
                value: _commune,
                items: chile_data.communes[index].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 16)))
                  );
                }).toList(),
                hint: Text('comunas', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
                onChanged: (dynamic value){
                  setState(() {
                    _commune = value;
                  });
                },
              ),
            ),
            Container(
              height: 43,
              width: size.width*0.85,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                icon: Transform.rotate(
                  angle: math.pi/2,
                  child: const Icon(Icons.arrow_forward_ios_outlined, color: EdvaColors.mineralGreen, size: 18),
                ),
                value: waitingTime,
                items: ['menos de 1 hora', 'entre 1 y 2 hrs', 'más de 2 horas'].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 16)))
                  );
                }).toList(),
                hint: Text('tiempo de espera', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
                onChanged: (dynamic value){
                  setState(() {
                    waitingTime = value;
                  });
                },
              ),
            ),
            Container(
              height: 43,
              width: size.width*0.85,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(50)
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                icon: Transform.rotate(
                  angle: math.pi/2,
                  child: const Icon(Icons.arrow_forward_ios_outlined, color: EdvaColors.mineralGreen, size: 18),
                ),
                value: dose,
                items: ['Primera dosis', 'Segunda dosis', 'Refuerzo'].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 16)))
                  );
                }).toList(),
                hint: Text('dosis', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
                onChanged: (dynamic value){
                  setState(() {
                    dose = value;
                  });
                },
              ),
            ),
            Text('¿Cómo calificarias tu experiencia?', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w500, fontSize: 21)),),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      setState(() {
                        hearts = [false, false, false, false];
                      });
                    },
                    child: const Icon(Icons.favorite, color: EdvaColors.killarney, size: 50)
                ),
                GestureDetector(
                    onTap: ()=> updateHearts(1),
                    child: !hearts[0] ? const Icon(Icons.favorite_border_outlined, color: EdvaColors.killarney, size: 50) : const Icon(Icons.favorite, color: EdvaColors.killarney, size: 50)
                ),
                GestureDetector(
                    onTap: ()=> updateHearts(2),
                    child: !hearts[1] ? const Icon(Icons.favorite_border_outlined, color: EdvaColors.killarney, size: 50) : const Icon(Icons.favorite, color: EdvaColors.killarney, size: 50)
                ),
                GestureDetector(
                    onTap: ()=> updateHearts(3),
                    child: !hearts[2] ? const Icon(Icons.favorite_border_outlined, color: EdvaColors.killarney, size: 50) : const Icon(Icons.favorite, color: EdvaColors.killarney, size: 50)
                ),
                GestureDetector(
                    onTap: ()=> updateHearts(4),
                    child: !hearts[3] ? const Icon(Icons.favorite_border_outlined, color: EdvaColors.killarney, size: 50) : const Icon(Icons.favorite, color: EdvaColors.killarney, size: 50)
                ),
              ],
            ),
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
      )
    );
  }

}