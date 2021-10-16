import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:todo/custom_packages/cModal/CModal.dart';

class AdderPanel extends StatefulWidget {

  final Widget child;
  final CModalController cModalController;
  final ValueNotifier<bool> displayAdderPanel;
  final Completer? onDismissCompleter;

  AdderPanel({Key? key, required this.child, required this.displayAdderPanel, required this.cModalController, this.onDismissCompleter}):super(key: key);


  @override
  _AdderPanelState createState() => _AdderPanelState();
}

class _AdderPanelState extends State<AdderPanel> {


  late ValueNotifier<bool> _displayAdderPanel;



  @override
  void initState() {



    _displayAdderPanel = widget.displayAdderPanel;
    _displayAdderPanel.value = false;

    SchedulerBinding.instance!.addPostFrameCallback((timeStamp){
      _displayAdderPanel.value = true;
    });


    super.initState();

  }

  @override
  Widget build(BuildContext context) {

    return GestureDetector(

      onTap: (){
        FocusScope.of(context).unfocus();

      },

      child: Container(
        child: Align(
          alignment: Alignment.bottomCenter,
          child: ValueListenableBuilder(

            valueListenable: _displayAdderPanel,

            builder:(_, bool value, child){

              return AnimatedContainer(
              curve: value == true ? Curves.easeOutCubic :
              Curves.easeIn,
              duration: Duration(
                milliseconds: value == true ?  800 : 400,),
              onEnd: (){
                if(value == false){
                  widget.cModalController.changeModalState = CModalStateChanger(state: CModalState.none);
                  widget.onDismissCompleter?.complete();
                }

                // if(value == true){
                //   widget.onDismissCompleter
                // }
              },
              decoration: BoxDecoration(

                  gradient : LinearGradient(
                      colors: [
                        Colors.grey.shade100,
                        Colors.grey.shade50,
                      ]

                  ),
                  borderRadius: BorderRadius.vertical(top: Radius.circular(40))
              ),

              height: value ? MediaQuery.of(context).size.height * .82 : 0,
              width: double.infinity,


              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Column(
                  children: [
                    Flexible(child: Divider(color: Colors.lightGreen.shade900, thickness: 1,)),

                    Expanded(
                      flex: 500,
                      child: child!,
                    ),
                  ],
                ),
              ),
            );
            },

            child: widget.child,
          ),
        ),
      ),
    );
  }
}
