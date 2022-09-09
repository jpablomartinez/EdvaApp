import 'package:edva/Screens/feedback.dart';
import 'package:edva/Screens/find_places.dart';
import 'package:edva/Screens/help.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget{

  const Home({Key? key}) : super(key: key);

  @override
  _Home createState()=> _Home();

}

class _Home extends State<Home>{

  int actualIndex = 1;

  List<Widget> content = [
    const UserFeedback(),
    const FindPlaces(),
    const Help()
  ];

  void onSelectItem(int index){
    if(index != actualIndex){
      setState(() {
        actualIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: SafeArea(
            child: Container(
                color: EdvaColors.whiteIce,
                child: content.elementAt(actualIndex)
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            elevation: 0,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            onTap: onSelectItem,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(actualIndex == 0 ? Icons.comment : Icons.comment_outlined, size: 28),
                  backgroundColor: EdvaColors.greenPea,
                  label: 'report'
              ),
              BottomNavigationBarItem(
                icon: Icon(actualIndex == 1 ? Icons.explore : Icons.explore_outlined, size: 28),
                backgroundColor: EdvaColors.greenPea,
                label: 'places',
              ),
              BottomNavigationBarItem(
                  icon: Icon(actualIndex == 2 ? Icons.help : Icons.help_outline, size: 28),
                  backgroundColor: EdvaColors.greenPea,
                  label: 'help'
              ),
            ],
            currentIndex: actualIndex,
            selectedItemColor: EdvaColors.whiteIce,
            unselectedItemColor: EdvaColors.whiteIce,
            backgroundColor: EdvaColors.greenPea,
          ),
        )
    );
  }

}
