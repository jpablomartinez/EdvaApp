import 'package:edva/Components/detail_place_card.dart';
import 'package:edva/Components/loaders.dart';
import 'package:edva/Components/map.dart';
import 'package:edva/Controllers/data_controller.dart';
import 'package:edva/Controllers/sync_controller.dart';
import 'package:edva/Models/place.dart';
import 'package:edva/Models/score.dart';
import 'package:edva/Screens/layout.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PlaceInfo extends StatefulWidget {

  const PlaceInfo({Key? key}) : super(key: key);

  @override
  _Place createState()=> _Place();

}


class _Place extends State<PlaceInfo>  with SingleTickerProviderStateMixin{

  final DataController dataController = Get.find();
  AnimationController? animationController;
  late Animation<double> animation;
  Future? loadData;


  Future<bool> getData() async {
    if(dataController.needToUpdateSelectedPlace){
      SyncController syncController = SyncController();
      bool availableInternet = await syncController.checkConnection();
      if(availableInternet){
        Score score = await syncController.getScore(dataController.selectedPlace.placeId);
        Place place = dataController.selectedPlace;
        place.score = score.score;
        place.amount = score.opinions;
        dataController.selectedPlace = place;
        dataController.needToUpdateSelectedPlace = false;
      }
    }
    animationController!.forward();
    return Future.value(true);
  }


  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    animation = CurvedAnimation(parent: animationController!, curve: Curves.easeIn);
    loadData = getData();
    super.initState();
  }

  @override
  void dispose(){
    animationController!.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Layout(
      child: FutureBuilder(
        future: loadData,
        builder: (context, snapshot){
          if(snapshot.hasData){
            return FadeTransition(
                opacity: animation,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        SizedBox(width: size.width, height: size.height*0.5, child: PlaceMap(lat: dataController.selectedPlace.lat, long: dataController.selectedPlace.long)),
                        Positioned(
                            top: 5,
                            left: 5,
                            child: IconButton(icon: const Icon(Icons.arrow_back, color: EdvaColors.greenPea, size: 30), onPressed: ()=> Navigator.pop(context))
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text('#Cuidémonos', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.mineralGreen, fontSize: 18, fontWeight: FontWeight.bold))),
                    DetailPlaceCard(place: dataController.selectedPlace)
                  ],
                )
            );
          }
          else {
            return Center(
              child: SizedBox(
                height: 400,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Loader.spinningLines(),
                    const SizedBox(
                        height: 30,
                        child: Text('Obteniendo datos', style: TextStyle(color: EdvaColors.mineralGreen, fontSize: 15, fontWeight: FontWeight.w500))
                    ),
                  ],
                ),
              ),
            );
          }
        },
      )
    );
  }

}