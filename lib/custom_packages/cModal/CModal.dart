import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';


class CModal extends StatelessWidget {


  final Widget child;
  final CModalController controller;
  final Widget? Function (BuildContext, CModalState)? builder;


  CModal({required this.child, required this.controller, this.builder});


  final List<Widget> widgetChildren = [];
  final ValueNotifier<double> opacityValue = ValueNotifier(0);


  @override
  Widget build(BuildContext context) {

    return WillPopScope(

    onWillPop:  () async {



      // if(!(controller.state == CModalState.loading || controller.state == CModalState.none)){
      //   controller.state = CModalState.none;
      //   return false;
      // }


      if(controller._state == CModalState.none){
        return true;
      }

      controller.onBackPress?.call();

      //dismiss when back is pressed.
      if(controller.dismissOnBackPress == true){
        // controller._state = CModalState.none;
        controller.changeModalState = CModalStateChanger(state: CModalState.none);
        return false;
      }

      //dismiss on back press
      if(controller.popOnBackPress == true){
        return true;
      }

      return false;


      // return true;

    },

      child: ValueListenableBuilder(

        valueListenable: controller._notify,

        builder: (BuildContext context, CModalState cState, _){



          // List<Widget>
          widgetChildren.clear();

          final modal = GestureDetector(

            onTap: (){
              //user clicks outside the display modal!
              if(controller.dismissOnOutsideClick == true){
                controller._state = CModalState.none;
              }

              controller.onOutsideClick?.call();

            },

            child: Center(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: Container(
                    color: Colors.black.withOpacity(.7),
                  ),
                )
            ),


          );

          controller.mContext = context;

          widgetChildren.add(child);


          // Widget? topDisplay = builder?.call(context, cState) ?? _defaultBuilder(context, cState);
          Widget? topDisplay = builder?.call(context, cState) ?? _defaultBuilder(context, cState);

          if(cState != CModalState.none){

            // widgetChildren.add(modal);
            _addModalWidget(modal);

            if(topDisplay != null) {

              widgetChildren.add(topDisplay);
            }

          }
          else{
            controller.displayMessage = null;
            controller.dismissOnOutsideClick = false;
          }

          return Scaffold(
            body: Stack(
              children: widgetChildren,
            ),
          );
        },
      ),
    );
  }

  Widget _modalDisplay(CModalState modalState){

    String text = modalState == CModalState.error ? controller.displayMessage ?? "error!!" :
        modalState == CModalState.success ? controller.displayMessage ?? "successful" :
            controller.displayMessage ?? "Hey!";

    Color color = modalState == CModalState.error ? Colors.red :
    modalState == CModalState.success ? Colors.green :
        Colors.blue;


    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      // crossAxisAlignment: CrossAxisAlignment.center,
      children: [


        Container(

          margin: EdgeInsets.all(20),

          alignment: Alignment.center,
            width: double.infinity,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20)
            ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                text, style: TextStyle(fontSize: 15, color: Colors.white),
              ),
          ),
        ),



        ElevatedButton(
            onPressed: (){
          controller._state = CModalState.none;
        },
            child: Text("OK", style: TextStyle(fontSize: 19),)),
      ],
    );
  }

  Widget? _defaultBuilder(BuildContext context, CModalState cState) {

    if(cState == CModalState.loading){

      return Center(child :CircularProgressIndicator());

    }else if (cState == CModalState.error){

      return _modalDisplay(CModalState.error);

    }else if (cState == CModalState.success){

       return _modalDisplay(CModalState.success);

    }

    return _modalDisplay(CModalState.custom1);

  }

  void _addModalWidget(Widget topDisplay) {

    opacityValue.value = 0;

    Future.delayed(Duration.zero, (){
      opacityValue.value = 1;
    });

    widgetChildren.add(
        ValueListenableBuilder(
          valueListenable: opacityValue,
          builder:(_, value, __){

            return AnimatedOpacity(
              duration:
              controller.fadeDuration ??
              Duration(milliseconds: 600),
              opacity: opacityValue.value,
              child: topDisplay);
          },
        )

    );

  }
}

class CModalController{
  //constructor
  CModalController();

  BuildContext? mContext;

  //click outside modal display;
  void Function()? onOutsideClick;

  bool? dismissOnOutsideClick;
  
  //changes state.
  ValueNotifier<CModalState> _notify = ValueNotifier(CModalState.none);
  // CModalState get changeState => _notify.value;
  //message to display.
  String? displayMessage;

  //when back is pressed.
  void Function()? onBackPress;
  //pops the whole page when back is pressed.
  bool? popOnBackPress;

  //dismiss only the model when back is pressed.
  bool? dismissOnBackPress = true;

  Duration? fadeDuration;


  @deprecated
  set changeState(CModalState value){

      if(value == CModalState.loading){
        changeModalState = CModalStateChanger(state: value, dismissOnBackPress: false);
      }
      changeModalState = CModalStateChanger(state: value, dismissOnBackPress: true);
      // _notify.value = value;
  }

  set _state(CModalState value){
    _notify.value = value;
  }

  CModalState get _state => _notify.value;



  
  set changeModalState(CModalStateChanger cModalStateChanger){
    this.popOnBackPress = cModalStateChanger.popOnBackPress;
    this.onBackPress = cModalStateChanger.onBackPress;
    this.dismissOnBackPress = cModalStateChanger.dismissOnBackPress;
    this.dismissOnOutsideClick = cModalStateChanger.dismissOnOutsideClick;
    this.displayMessage = cModalStateChanger.displayMessage;
    this.onOutsideClick = cModalStateChanger.onOutsideClick;
    this.fadeDuration = cModalStateChanger.fadeDuration;
    this._state = cModalStateChanger.state;

  }


}


class CModalStateChanger{

  bool? dismissOnOutsideClick;

  CModalState state;

  String? displayMessage;

  void Function()? onOutsideClick;

  void Function()? onBackPress;

  bool? popOnBackPress;

  bool? dismissOnBackPress;

  Duration? fadeDuration;

  CModalStateChanger({required this.state, this.onBackPress,
    this.popOnBackPress, this.dismissOnBackPress: true,
    this.displayMessage, this.onOutsideClick, this.dismissOnOutsideClick, this.fadeDuration});
  
}




enum CModalState{
  none,
  error,
  success,
  loading,
  custom1,
  custom2,
  custom3,
  custom4,
}



