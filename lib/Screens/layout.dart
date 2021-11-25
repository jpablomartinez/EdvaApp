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

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        onTap: (int index){
          switch(index){
            case 0:
              if(currentIndex != 0){
                setState(() {
                  currentIndex = 0;
                });
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }
              break;
            case 1:
              if(currentIndex != 1){
                setState(() {
                  currentIndex = 1;
                });
                Navigator.pushNamedAndRemoveUntil(context, '/settings', ModalRoute.withName('/'));
                //Navigator.pushNamed(context, '/settings');
              }
              break;
            case 2:
              if(currentIndex != 2){
                setState(() {
                  currentIndex = 2;
                });
                Navigator.pushNamedAndRemoveUntil(context, '/navigator', ModalRoute.withName('/'));
              }
              break;
            case 3:
              if(currentIndex != 3){
                setState(() {
                  currentIndex = 3;
                });
                Navigator.pushNamedAndRemoveUntil(context, '/feedback', ModalRoute.withName('/'));
              }
              break;
            case 4:
              if(currentIndex != 4){
                setState(() {
                  currentIndex = 4;
                });
                Navigator.pushNamedAndRemoveUntil(context, '/help', ModalRoute.withName('/'));
              }
              break;
          }
        },
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
        currentIndex: currentIndex,
        selectedItemColor: EdvaColors.chestnutRose,
      ),
    );
  }

}
