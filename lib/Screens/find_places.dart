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
  bool availableInternet = false;

  Future<bool> init() async {
    if(dataController.needToUpdateList){
      String nearestRegion = '';
      dataController.locationServiceEnabled = await locationController.handlePermission();
      availableInternet = await syncController.checkConnection();
      if(availableInternet){
        if(dataController.locationServiceEnabled){
          final position = await locationController.getCurrentPosition();
          dataController.latitude = position.latitude;
          dataController.longitude = position.longitude;
        }
        else{
          dataController.latitude = -18.57336;
          dataController.longitude = -69.46106;
        }
        dataController.selectedIndex = GlobalFunctions.getNearestRegion(dataController.latitude, dataController.longitude);
        nearestRegion = chile_data.regions[dataController.selectedIndex];
        dataController.region = chile_data.regions[dataController.selectedIndex];
        dataController.commune = chile_data.communes[dataController.selectedIndex][0];
        dataController.allPlacesByRegion = await syncController.getVaccinatePlacesFromRegion(nearestRegion);
        if(dataController.allPlacesByRegion.isNotEmpty){
          dataController.foundedData = true;
          dataController.updateListPlacesByRegionCommune(dataController.commune);
          dataController.searchingVaccinatePlaces = false;
          dataController.needToUpdateList = false;
        }
      }
    }
    animationController!.forward();
    return Future.value(true);
  }

  Future<void> getVaccinatePlacesByRegion() async{
    availableInternet = await syncController.isConnected();
    if(availableInternet){
      dataController.allPlacesByRegion = await syncController.getVaccinatePlacesFromRegion(dataController.region);
      if(dataController.allPlacesByRegion.isNotEmpty){
        dataController.foundedData = true;
        dataController.needToUpdateList = false;
        dataController.updateListPlacesByRegionCommune(dataController.commune);
      }
      else{
        dataController.clearPlacesByRegionCommune();
      }
      setState(() {
        dataController.searchingVaccinatePlaces = false;
      });
    }
    else{
      dataController.needToUpdateList = true;
      setState(() {
        dataController.foundedData = false;
      });
    }
  }

  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
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
        header: Header(
          title: 'Sedes',
          subtitle: 'ult act: ${dataController.lastUpdate}',
        ),
        child: FutureBuilder(
          future: loadData,
          builder: (context, snapshot){
            if(snapshot.hasData){
              return FadeTransition(
                  opacity: animation,
                  child: dataController.foundedData ?
                    Column(
                      children: [
                        !dataController.locationServiceEnabled ?
                        const Text('servicio de localización no permitido', style: TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w500))
                        :
                        Container(),
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
                                  value: dataController.region,
                                  items: chile_data.regions.map<DropdownMenuItem<String>>((String v){
                                    return DropdownMenuItem<String>(
                                        value: v,
                                        child: Text(v, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 16)))
                                    );
                                  }).toList(),
                                  hint: Text('regiones', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
                                  onChanged: (dynamic val) async{
                                    setState(() {
                                      dataController.region = val;
                                      dataController.selectedIndex = chile_data.regions.indexOf(val);
                                      dataController.commune = chile_data.communes[dataController.selectedIndex][0];
                                      dataController.searchingVaccinatePlaces = true;
                                    });
                                    dataController.needToUpdateList = true;
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
                                value: dataController.commune,
                                items: chile_data.communes[dataController.selectedIndex].map<DropdownMenuItem<String>>((String value){
                                  return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value, style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontSize: 16)))
                                  );
                                }).toList(),
                                hint: Text('comunas', style: GoogleFonts.lato(textStyle: const TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14))),
                                onChanged: (dynamic value){
                                  setState(() {
                                    dataController.commune = value;
                                    dataController.updateListPlacesByRegionCommune(value);
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        Container(
                            height: size.height*0.58,
                            decoration: const BoxDecoration(
                              color: EdvaColors.whiteIce,
                            ),
                            child: !dataController.searchingVaccinatePlaces ?
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
                    :
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      child: Column(
                        children: [
                          const Icon(Icons.sentiment_dissatisfied, color: EdvaColors.mineralGreen, size: 120),
                          const SizedBox(height: 30),
                          !availableInternet ?
                          const Text('Error al cargar las sedes de vacunación.\n No hay internet disponible', style: TextStyle(color: EdvaColors.como, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                          :
                          availableInternet && !dataController.foundedData ?
                          const Text('Error al cargar las sedes de vacunación.\n No hay datos disponibles', style: TextStyle(color: EdvaColors.como, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                          :
                          const Text('Error al cargar las sedes de vacunación.\n ', style: TextStyle(color: EdvaColors.como, fontSize: 16, fontWeight: FontWeight.bold), textAlign: TextAlign.center)
                        ],
                      ),
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