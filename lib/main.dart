import 'package:flutter/material.dart';
import 'package:edva/Utils/router.dart';

void main() {
  runApp(const EdvaApp());
}

class EdvaApp extends StatelessWidget{
  const EdvaApp ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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

