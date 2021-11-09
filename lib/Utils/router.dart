import 'package:edva/Screens/find_places.dart';
import 'package:edva/Screens/feedback.dart';
import 'package:flutter/material.dart';
import 'package:edva/Utils/route_side_transition.dart';

class RouterGenerator {

  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;
    switch(settings.name){
      case '/':
        return RouteSideTransition(widget: UserFeedback(), settings: settings);
      default:
        return RouteSideTransition(widget: Container(), settings: settings);
    }
  }
}