// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:edva/Components/header.dart';
import 'package:edva/Controllers/data_controller.dart';
import 'package:edva/Controllers/sync_controller.dart';
import 'package:edva/Dialogs/layout_alert_dialog.dart';
import 'package:edva/Dialogs/dialogs.dart';
import 'package:edva/Screens/layout.dart';
import 'package:edva/Utils/colors.dart';
import 'package:edva/Utils/global_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:math' as math;
import 'package:edva/Dialogs/toast.dart' as toast;

class Experience extends StatefulWidget {

  const Experience({Key? key}) : super(key: key);

  @override
  _Experience createState()=> _Experience();

}

class _Experience extends State<Experience>{

  String waitingTime = 'menos de 1 hora';
  String dose = 'Refuerzo';
  String vaccine = 'Coronavac';
  List<bool> hearts = [false, false, false, false];
  final DataController dataController = Get.find();
  SyncController syncController = SyncController();

  Future<void> postExperience() async {
    Navigator.pop(context);
    Dialogs.showSyncDialog(context);
    bool availableInternet = await syncController.checkConnection();
    if(availableInternet){
      int w  = GlobalFunctions.getWaitTimeIndex(waitingTime);
      int d = GlobalFunctions.getDoseIndex(dose);
      bool a = await  syncController.postExperience(dataController.selectedPlace.placeId, w, d, hearts.lastIndexWhere((element) => element) + 2, vaccine);
      if(a) Dialogs.successAlertDialog(context);
      else Dialogs.errorAlertDialog(context);
    }
    else toast.basicToast('No hay internet disponible');
  }

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
        child: ListView(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(15),
              child: Text(
                'Ayúdanos compartiendo tu experiencia para que así más gente pueda tomar una mejor decisión a la hora de escoger el lugar para recibir su dosis',
                style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w400, fontSize: 15)),
                softWrap: true,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: RichText(
                  text: TextSpan(
                      text: 'Sede: ',
                      style: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.bold, fontSize: 16),
                      children: <TextSpan>[
                        TextSpan(text: dataController.selectedPlace.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400))
                      ]
                  )
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
                value: vaccine,
                items: ['Coronavac', 'BioNTech, Pfizer', 'CanSino', 'Johnson & Johnson', 'Oxford, AstraZeneca', 'Sputnik V'].map<DropdownMenuItem<String>>((String value){
                  return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 16)))
                  );
                }).toList(),
                hint: Text('vacuna', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
                onChanged: (dynamic value){
                  setState(() {
                    vaccine = value;
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
            const SizedBox(height: 20),
            Center(child: Text('¿Cómo calificarias tu experiencia?', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w400, fontSize: 18)))),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: (){
                      setState(() {
                        hearts = [false, false, false, false];
                      });
                    },
                    child: const Icon(Icons.favorite, color: EdvaColors.greenPea, size: 40)
                ),
                GestureDetector(
                    onTap: ()=> updateHearts(1),
                    child: !hearts[0] ? const Icon(Icons.favorite_border_outlined, color: EdvaColors.greenPea, size: 40) : const Icon(Icons.favorite, color: EdvaColors.greenPea, size: 40)
                ),
                GestureDetector(
                    onTap: ()=> updateHearts(2),
                    child: !hearts[1] ? const Icon(Icons.favorite_border_outlined, color: EdvaColors.greenPea, size: 40) : const Icon(Icons.favorite, color: EdvaColors.greenPea, size: 40)
                ),
                GestureDetector(
                    onTap: ()=> updateHearts(3),
                    child: !hearts[2] ? const Icon(Icons.favorite_border_outlined, color: EdvaColors.greenPea, size: 40) : const Icon(Icons.favorite, color: EdvaColors.greenPea, size: 40)
                ),
                GestureDetector(
                    onTap: ()=> updateHearts(4),
                    child: !hearts[3] ? const Icon(Icons.favorite_border_outlined, color: EdvaColors.greenPea, size: 40) : const Icon(Icons.favorite, color: EdvaColors.greenPea, size: 40)
                ),
              ],
            ),
            const SizedBox(height: 15),
            Center(
              child: GestureDetector(
                onTap: ()=> Dialogs.questionAlertDialog(context, postExperience),
                child: Container(
                  height: 48,
                  width: 210,
                  decoration: BoxDecoration(
                      color: EdvaColors.greenPea,
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