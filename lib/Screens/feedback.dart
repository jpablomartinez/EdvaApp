// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:edva/Components/header.dart';
import 'package:edva/Components/loaders.dart';
import 'package:edva/Controllers/sync_controller.dart';
import 'package:edva/Dialogs/toast.dart';
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

  final GlobalKey<FormState> formKey = GlobalKey();
  final TextEditingController commentsController = TextEditingController();
  SyncController syncController = SyncController();
  String feedbackType = 'Problema con sede';

  Future<void> showSyncDialog() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context){
          return ConstrainedBox(
            constraints: const BoxConstraints(maxHeight: 300),
            child: AlertDialog(
              title: const Text(''),
              contentPadding: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5)),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Loader.spinningLines(),
                  const SizedBox(height: 20),
                  Container(
                      margin: const EdgeInsets.only(top:5, bottom:20),
                      child: const Text('Por favor espere...', style: TextStyle(color: EdvaColors.killarney, fontSize: 15))
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  bool fieldsAreValid(){
    return formKey.currentState!.validate();
  }

  Future<void> postFeedback() async {
    if(fieldsAreValid()){
      showSyncDialog();
      bool isConnected = await syncController.isConnected();
      if(isConnected){
        bool a = await syncController.postFeedback(feedbackType, commentsController.text);
        if(a) basicToast('Muchas gracias por compartir información');
        else basicToast('Ocurrió un error al compartir tu información. Intenta más tarde');
      }
      else basicToast('Hay un problema con tu conexión a internet.');
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Layout(
      header: const Header(
        title: 'Feedback',
      ),
      child: Form(
        key: formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Container(
              height: 100,
              padding: const EdgeInsets.all(15),
              child: Text(
                'Si ves algún error, o si las  sedes mostradas ya no son sedes de vacunación o simplemente quieres dejar tufeedback déjame tu comentario y lo revisaremos a la brevedad',
                style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w400, fontSize: 15)),
                softWrap: true,
              ),
            ),
            const SizedBox(height: 20),
            Container(
                height: 40,
                width: size.width*0.85,
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.80),
                  borderRadius: BorderRadius.circular(15)
              ),
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              child: TextFormField(
                validator: (value){
                  if(value == '') return 'El campo no puede estar vacío';
                  else return null;
                },
                controller: commentsController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Escribe tus comentarios',
                    hintStyle: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 14, fontStyle: FontStyle.italic)),
                    hintMaxLines: 8
                ),
                maxLines: 8,
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: GestureDetector(
                onTap: () async => await postFeedback(),
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
      ),
    );
  }

}