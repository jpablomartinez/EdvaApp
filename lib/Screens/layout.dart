import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';

class Layout extends StatefulWidget{

  final Widget child;
  final Widget? header;
  const Layout({Key? key, this.header, required this.child}) : super(key: key);

  @override
  _Layout createState()=> _Layout();

}

class _Layout extends State<Layout>{

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: SafeArea(
              child: Container(
                  color: EdvaColors.whiteIce,
                  child: Column(
                    children: [
                      widget.header ?? Container(),
                      widget.child
                    ],
                  )
              ),
            )
        )
    );
  }

}
