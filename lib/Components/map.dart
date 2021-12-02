import 'package:edva/Models/place.dart';
import 'package:edva/Utils/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class PlaceMap extends StatelessWidget{
  final double lat;
  final double long;
  const PlaceMap({required this.lat, required this.long, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        center: LatLng(lat, long),
        zoom: 15,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
          subdomains: ['a', 'b', 'c'],
          attributionBuilder: (_) {
            return const Text("© OpenStreetMap", style: TextStyle(color: EdvaColors.mineralGreen, fontWeight: FontWeight.w500));
          },
        ),
        MarkerLayerOptions(
          markers: [
            Marker(
              width: 200,
              height: 200,
              point: LatLng(lat, long),
              builder: (ctx) => const Icon(Icons.location_on, size: 40, color: EdvaColors.greenPea),
            ),
          ],
        ),
      ],
    );
  }

}