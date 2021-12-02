import 'package:edva/Components/loaders.dart';
import 'package:edva/Dialogs/layout_alert_dialog.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';

class Dialogs{

  static Future<void> showSyncDialog(BuildContext context) async {
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
                      child: const Text('Por favor espere...', style: TextStyle(color: EdvaColors.greenPea, fontSize: 15))
                  ),
                ],
              ),
            ),
          );
        }
    );
  }

  static void successAlertDialog(BuildContext context){
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context){
          return LayoutAlertDialog(
              firstMessage: 'Gracias por compartir tu experiencia',
              icon: const Icon(Icons.check_circle, size: 100, color: Color(0xff27B996)),
              function: ()=> Navigator.pop(context)
          );
        }
    );
  }

  static void errorAlertDialog(BuildContext context){
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context){
          return LayoutAlertDialog(
              firstMessage: 'Ocurrió un error. Intenta nuevamente',
              icon: const Icon(Icons.highlight_off, size: 100, color: Color(0xffF44954)),
              function: ()=> Navigator.pop(context)
          );
        }
    );
  }

  static void questionAlertDialog( BuildContext context, Function f){
    showDialog(
        context: context,
        builder: (BuildContext context){
          return LayoutAlertDialog(
              firstMessage: '¿Deseas compartir esta información?',
              icon: const Icon(Icons.help, size: 100, color: EdvaColors.deYork),
              withCancel: true,
              function: ()=> f()
          );
        }
    );
  }

}