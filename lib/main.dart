import 'package:flutter/material.dart';
import 'package:edva/Utils/router.dart';
import 'package:get/get.dart';

void main() async{

  runApp(const EdvaApp());
}

class EdvaApp extends StatelessWidget{
  const EdvaApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'EDVA',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      initialRoute: '/',
      onGenerateRoute: RouterGenerator.generateRoute,
    );
  }
}

