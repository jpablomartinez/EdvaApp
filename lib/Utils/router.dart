import 'package:edva/Screens/experience.dart';
import 'package:edva/Screens/find_places.dart';
import 'package:edva/Screens/feedback.dart';
import 'package:edva/Screens/help.dart';
import 'package:edva/Screens/place.dart';
import 'package:flutter/material.dart';
import 'package:edva/Utils/route_side_transition.dart';

class RouterGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/':
        return RouteSideTransition(widget: const FindPlaces(), settings: settings);
      case '/settings':
        return RouteSideTransition(widget: Container(), settings: settings);
      case '/navigator':
        return RouteSideTransition(widget: Container(), settings: settings);
      case '/feedback':
        return RouteSideTransition(widget: const UserFeedback(), settings: settings);
      case '/help':
        return RouteSideTransition(widget: const Help(), settings: settings);
      case '/place':
        return RouteSideTransition(widget: const Place(), settings: settings);
      case '/experience':
        return RouteSideTransition(widget: const Experience(), settings: settings);
      default:
        return RouteSideTransition(widget: Container(), settings: settings);
    }
  }
}