import 'package:edva/Controllers/data_controller.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Layout extends StatefulWidget{

  final Widget child;
  final Widget? header;
  const Layout({Key? key, this.header, required this.child}) : super(key: key);

  @override
  _Layout createState()=> _Layout();

}

class _Layout extends State<Layout>{

  final DataController dataController = Get.find();

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
              widget.header ?? Container(),
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
              if(dataController.currentIndex != 0){
                dataController.currentIndex = 0;
                Navigator.popUntil(context, ModalRoute.withName('/'));
              }
              break;
            case 1:
              if(dataController.currentIndex != 1){
                dataController.currentIndex = 1;
                Navigator.pushNamedAndRemoveUntil(context, '/feedback', ModalRoute.withName('/'));
              }
              break;
            case 2:
              if(dataController.currentIndex != 2){
                dataController.currentIndex = 2;
                Navigator.pushNamedAndRemoveUntil(context, '/help', ModalRoute.withName('/'));
              }
              break;
          }
        },
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: dataController.currentIndex == 0 ? const Color(0xffA6B1E1) : Colors.white, size: 28),
              backgroundColor: EdvaColors.greenPea,
              label: 'places',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.comment, color: dataController.currentIndex == 1 ? const Color(0xffA6B1E1) : Colors.white, size: 28),
              backgroundColor: EdvaColors.greenPea,
              label: 'report'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.help, color: dataController.currentIndex == 2 ? const Color(0xffA6B1E1) : Colors.white, size: 28),
              backgroundColor: EdvaColors.greenPea,
              label: 'help'
          ),
        ],
        currentIndex: dataController.currentIndex,
        selectedItemColor: EdvaColors.whiteIce,
        backgroundColor: EdvaColors.greenPea,
      ),
    );
  }

}
