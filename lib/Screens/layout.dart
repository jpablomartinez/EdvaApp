import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget{

  final Widget child;
  final Widget header;
  const Layout({Key? key, required this.header, required this.child}) : super(key: key);

  @override
  _Layout createState()=> _Layout();

}

class _Layout extends State<Layout>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          //margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          //padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          color: EdvaColors.whiteIce,
          child: Column(
            children: [
              widget.header,
              widget.child
            ],
          )
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: EdvaColors.chestnutRose, size: 28),
              backgroundColor: EdvaColors.killarney,
              label: 'places',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.white, size: 28),
              backgroundColor: EdvaColors.killarney,
              label: 'settings'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.navigation, color: Colors.white, size: 28),
              backgroundColor: EdvaColors.killarney,
              label: 'navigation'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.report_problem, color: Colors.white, size: 28),
              backgroundColor: EdvaColors.killarney,
              label: 'report'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.help, color: Colors.white, size: 28),
              backgroundColor: EdvaColors.killarney,
              label: 'help'
          ),
        ],
        currentIndex: 0,
        selectedItemColor: EdvaColors.chestnutRose,
      ),
    );
  }

}