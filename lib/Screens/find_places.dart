import 'package:edva/Components/bottom_navigation.dart';
import 'package:edva/Components/place_card.dart';
import 'package:edva/Models/place.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:edva/Utils/chile.dart' as chile_data;
import 'dart:math' as math;

class FindPlaces extends StatefulWidget{

  const FindPlaces({Key? key}) : super(key: key);

  @override
  _FindPlaces createState()=> _FindPlaces();

}

class _FindPlaces extends State<FindPlaces>{

  String _region = chile_data.regions[0];
  int index = 0;
  String _commune = chile_data.communes[0][0];
  List<Place> places = [
    Place(name: 'Liceo Gabriela Mistral', address: 'Independencia 1225', region: 'Metropolitana de Santiago', city: 'Independencia'),
    Place(name: 'Polideportivo Enrique Soro', address: 'Enrique Soro 1090', region: 'Metropolitana de Santiago', city: 'Independencia'),
    Place(name: 'Segundo Patio de Urgencia del Hospital San José', address: 'Calle San José N°1196', region: 'Metropolitana de Santiago', city: 'Independencia'),
    Place(name: 'Segundo Patio de Urgencia del Hospital San José', address: 'Calle San José N°1196', region: 'Metropolitana de Santiago', city: 'Independencia'),
    Place(name: 'Segundo Patio de Urgencia del Hospital San José', address: 'Calle San José N°1196', region: 'Metropolitana de Santiago', city: 'Independencia'),
    Place(name: 'Segundo Patio de Urgencia del Hospital San José', address: 'Calle San José N°1196', region: 'Metropolitana de Santiago', city: 'Independencia'),

  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: EdvaColors.whiteIce,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 230,
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: EdvaColors.funGreen,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(50),
                      bottomRight: Radius.circular(50)
                  )
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const[
                          Text('Vacúnate hoy', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 27)),
                          Text('ult actualización: 08:45', style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.w400))
                        ],
                      ),
                    ),
                    Positioned(
                      top: 70,
                      left: 0,
                      right: 0,
                      child: Column(
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
                                      child: Text(v, style: const TextStyle(color: EdvaColors.como, fontSize: 16))
                                  );
                                }).toList(),
                                hint: const Text('regiones', style: TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14)),
                                onChanged: (dynamic val){
                                  setState(() {
                                    _region = val;
                                    index = chile_data.regions.indexOf(val);
                                    _commune = chile_data.communes[index][0];
                                  });
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
                                    child: Text(value, style: const TextStyle(color: EdvaColors.como, fontSize: 16))
                                );
                              }).toList(),
                              hint: const Text('comunas', style: TextStyle(color: EdvaColors.como, fontStyle: FontStyle.italic, fontSize: 14)),
                              onChanged: (dynamic value){
                                setState(() {
                                  _commune = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: const Text('#Cuidemonos', style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic)),
                      )
                    ),
                  ],
                )
            ),
            Container(
              height: size.height*0.554,
              decoration: const BoxDecoration(
                color: EdvaColors.whiteIce,
              ),
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  itemCount: places.length,
                  itemBuilder: (context, i){
                    return PlaceCard(place: places[i]);
                  }
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.search, color: EdvaColors.downy),
              backgroundColor: EdvaColors.funGreen,
              label: 'places'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, color: Colors.white, size: 26),
              backgroundColor: EdvaColors.funGreen,
              label: 'settings'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.navigation, color: Colors.white),
              backgroundColor: EdvaColors.funGreen,
              label: 'navigation'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.report_problem, color: Colors.white),
              backgroundColor: EdvaColors.funGreen,
              label: 'report'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.help, color: Colors.white),
              backgroundColor: EdvaColors.funGreen,
              label: 'help'
          ),
        ],
        currentIndex: 0,
        selectedItemColor: EdvaColors.downy,

      ),
    );
  }

}