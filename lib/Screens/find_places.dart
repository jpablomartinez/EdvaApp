import 'dart:async';
import 'package:edva/Components/header.dart';
import 'package:edva/Components/loaders.dart';
import 'package:edva/Controllers/data_controller.dart';
import 'package:edva/Controllers/location_controller.dart';
import 'package:edva/Controllers/sync_controller.dart';
import 'package:edva/Screens/layout.dart';
import 'package:edva/Utils/colors.dart';
import 'package:edva/Utils/global_functions.dart';
import 'package:flutter/material.dart';
import 'package:edva/Utils/chile.dart' as chile_data;
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:google_fonts/google_fonts.dart';

class FindPlaces extends StatefulWidget{

  const FindPlaces({Key? key}) : super(key: key);

  @override
  _FindPlaces createState()=> _FindPlaces();

}

class _FindPlaces extends State<FindPlaces> with SingleTickerProviderStateMixin{

  final dataController = Get.put(DataController());
  final locationController = LocationController();
  AnimationController? animationController;
  late Animation<double> animation;
  Future? loadData;
  Future? vaccinatePlaces;
  SyncController syncController = SyncController();
  String _region = chile_data.regions[0];
  int index = 0;
  String _commune = chile_data.communes[0][0];
  bool searching = true;

  Future<bool> init() async {
    String nearestRegion = '';
    dataController.locationServiceEnabled = await locationController.handlePermission();
    if(dataController.locationServiceEnabled){
      final position = await locationController.getCurrentPosition();
      dataController.latitude = position.latitude;
      dataController.longitude = position.longitude;
      index = GlobalFunctions.getNearestRegion(dataController.latitude, dataController.longitude);
      nearestRegion = chile_data.regions[index];
      _region = chile_data.regions[index];
      _commune = chile_data.communes[index][0];
      dataController.allPlacesByRegion = await syncController.getVaccinatePlacesFromRegion(nearestRegion);
      if(dataController.allPlacesByRegion.isNotEmpty){
        dataController.foundedData = true;
        dataController.updateListPlacesByRegionCommune(_commune);
        searching = false;
      }
    }
    animationController!.forward();
    return Future.value(true);
  }

  Future<void> getVaccinatePlacesByRegion() async{
    bool isConnected = await syncController.isConnected();
    if(isConnected){
      dataController.allPlacesByRegion = await syncController.getVaccinatePlacesFromRegion(_region);
      if(dataController.allPlacesByRegion.isNotEmpty){
        dataController.foundedData = true;
        dataController.updateListPlacesByRegionCommune(_commune);
      }
      setState(() {
        searching = false;
      });
    }
  }

  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500));
    animation = CurvedAnimation(parent: animationController!, curve: Curves.easeIn);
    loadData = init();
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
        header: const Header(
          title: 'Sedes',
        ),
        child: FutureBuilder(
          future: loadData,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return FadeTransition(
                  opacity: animation,
                  child: Column(
                    children: [
                      Column(
                        children: [
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
                                onChanged: (dynamic val) async{
                                  setState(() {
                                    _region = val;
                                    index = chile_data.regions.indexOf(val);
                                    _commune = chile_data.communes[index][0];
                                    searching = true;
                                  });
                                  await getVaccinatePlacesByRegion();
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
                                  dataController.updateListPlacesByRegionCommune(value);
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                          height: size.height*0.62,
                          decoration: const BoxDecoration(
                            color: EdvaColors.whiteIce,
                          ),
                          child: !searching ?
                            GetBuilder<DataController>(
                              builder: (_) =>
                              dataController.placesWidgets.isNotEmpty ?
                              ListView(
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.symmetric(horizontal: 25),
                                  children: dataController.placesWidgets
                              ) :
                               Container(
                                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                child: const SizedBox(
                                  height: 350,
                                  child: Text(
                                      'La comuna seleccionada no tiene lugares de vacunación inscritos',
                                      style: TextStyle(color: EdvaColors.mineralGreen, fontSize: 16, fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            )
                            :
                            Center(
                              child: SizedBox(
                                height: 350,
                                child: Column(
                                  children:  [
                                    Loader.spinningLines(),
                                    const SizedBox(
                                        height: 30,
                                        child: Text('Obteniendo sedes de vacunación', style: TextStyle(color: EdvaColors.mineralGreen, fontSize: 15, fontWeight: FontWeight.w500))
                                    ),
                                  ],
                                ),
                              ),
                            )
                      )
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