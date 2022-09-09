import 'package:edva/Components/header.dart';
import 'package:edva/Components/help_entry.dart';
import 'package:edva/Screens/layout.dart';
import 'package:flutter/material.dart';
import 'package:edva/Utils/help.dart' as help;

class Help extends StatelessWidget {

  const Help({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Layout(
      header: const Header(
        title: 'Ayuda',
        subtitle: 'versión: ${help.appVersion}',
      ),
      child: Column(
        children: [
          SizedBox(
            height: size.height*0.75,
            child: ListView(
              shrinkWrap: true,
              children: const [
                HelpEntry(
                    title: 'Sobre la app',
                    content: help.about
                ),
                HelpEntry(
                    title: 'Búsqueda',
                    content: help.searching
                ),
                HelpEntry(
                    title: 'Reportar problema',
                    content: help.problem
                ),
                HelpEntry(
                    title: 'Ayúdanos',
                    content: help.helpUs
                ),
              ],
            ),
          )
        ],
      )
    );
  }

}