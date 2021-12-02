// ignore_for_file: curly_braces_in_flow_control_structures
import 'package:edva/Utils/colors.dart';
import 'package:flutter/material.dart';

class LayoutAlertDialog extends StatefulWidget {

  @override
  _LayoutAlertDialog createState()=> _LayoutAlertDialog();

  final String firstMessage;
  final Icon icon;
  final Function function;
  final bool withCancel;

  const LayoutAlertDialog({
    Key? key,
    required this.firstMessage,
    required this.icon,
    required this.function,
    this.withCancel = false
  }) : super(key: key);
}

class _LayoutAlertDialog extends State<LayoutAlertDialog> with SingleTickerProviderStateMixin{

  AnimationController? animationController;
  late Animation<double> animation;

  Size getSizeOrientation(Size s){
    if(MediaQuery.of(context).orientation == Orientation.portrait) return Size(s.width*0.85, 285);
    else return Size(285, s.height*0.85);
  }

  Size getSizeImageOrientation(Size s){
    if(MediaQuery.of(context).orientation == Orientation.portrait) return Size(s.width*0.85*0.7, 200);
    else return Size(s.height*0.60,140);
  }

  @override
  void initState(){
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 750));
    animation = CurvedAnimation(parent: animationController!, curve: Curves.easeOutQuint);
    animationController!.addListener(() {setState(() {});});
    animationController!.forward();
    super.initState();
  }

  @override
  void dispose(){
    animationController!.dispose();
    super.dispose();
  }

  Widget getColumnMessages(){
    List<Widget> columnData = [];
    Widget text1 = Text(widget.firstMessage, style: const TextStyle(color: EdvaColors.como, fontSize: 18, fontWeight: FontWeight.w400), textAlign: TextAlign.center);
    Widget space = const SizedBox(height: 10);
    columnData.addAll([text1, space]);
    return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: columnData
    );
  }

  Widget getActionButtons(){
    List<Widget> actionButtons = [];
    Widget acceptButton = InkWell(
      onTap: () => widget.function(),
      child: const SizedBox(
        height: 45,
        width: 100,
        child: Center(
            child: Text(
                'ACEPTAR',
                style: TextStyle(color: EdvaColors.greenPea, fontSize: 14, fontWeight: FontWeight.bold)
            )
        ),
      ),
    );
    actionButtons.add(acceptButton);
    if(widget.withCancel){
      Widget cancelButton = InkWell(
        onTap: () => Navigator.pop(context),
        child: const SizedBox(
          height: 45,
          width: 100,
          child: Center(child: Text('CANCELAR', style: TextStyle(color: EdvaColors.greenPea, fontSize: 14, fontWeight: FontWeight.bold))),
        ),
      );
      Widget tmp = acceptButton;
      actionButtons[0] = cancelButton;
      actionButtons.add(tmp);
    }
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actionButtons
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Size orientationSize = getSizeOrientation(size);
    return Center(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: animation,
            child: Container(
              height: orientationSize.height,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: orientationSize.width,
              decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
              ),
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Center(
                      child: widget.icon
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: getColumnMessages(),
                    ),
                    getActionButtons()
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}