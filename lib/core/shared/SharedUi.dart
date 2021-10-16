import 'package:flutter/material.dart';
import 'package:todo/custom_packages/CText.dart';
import 'package:todo/custom_packages/cButton/CButton.dart';
import 'package:todo/custom_packages/cInputController/CInputController.dart';
import 'package:todo/custom_packages/cTextField/CTextField.dart';
import 'package:todo/enum/Enums.dart';

class SharedUi{


  static Widget heroFlightShuttle(BuildContext flightContext, Animation<double> animation,
      HeroFlightDirection direction,
      BuildContext fromContext, BuildContext toContext) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: direction.index == 1 ? Colors.blue.shade300: Colors.lightGreen.shade300,
      ),
    );
  }




  static Widget _button(List<dynamic> head, Color color, {void Function()? onTap, int? height, double? radius}){


    List headWidgets = head.map((e) {
      assert(e != null);
      if(e is String){
        return CText(e, size: 15, color: Colors.grey.shade50,);
      }else{
        return e as Widget;
      }

    }).toList();

    return CButton(
      onTapHandler: onTap,
      elevation: 2,
      borderRadius: radius ?? 19,
      color: color,
      padding: EdgeInsets.all(height?.toDouble() ?? 9),
      child: Row(

        children: [...headWidgets],
      ),
    );

  }



  static Widget successButton(List<dynamic> head,  {void Function()? onTap,}){

    return _button(head, Colors.green ,onTap: onTap);

  }

  static Widget cancelButton(List<dynamic> head,  {double? radius, void Function()? onTap,}){

    return _button(head, Colors.red ,onTap: onTap, radius:radius,);

  }

  static outlierButton(List<dynamic> head, {double? radius, void Function()? onTap,}) {
    return _button(head, getColor(mColor: mColors.outlier)! ,onTap: onTap, radius: radius);
  }

  static Widget successButtonSlim(List<dynamic> head,  {double? radius, void Function()? onTap,}){

    return _button(head, Colors.green, height: 15 ,onTap: onTap, radius: radius);

  }

  static Widget cancelButtonSlim(List<dynamic> head,  {double? radius, void Function()? onTap,}){

    return _button(head, Colors.red, height: 5,onTap: onTap, radius: radius);

  }




  //spaces
  static Widget vMediumSpace() {
    return SizedBox(
      height: 100,
    );
  }

  static Widget vSmallSpace() {
    return SizedBox(
      height: 30,
    );
  }

  static Widget vTinySpace() {
    return SizedBox(
      height: 10,
    );
  }

  static Widget vFooterSpace() {
    return SizedBox(
      height: 120,
    );
  }

  static Widget vHeaderSpace() {
    return SizedBox(
      height: 50,
    );
  }



  static Widget titleValueText(String title, String value, {mColors? mColor, int? valueMaxLines}){


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 5),
        CText(title, size: 22, color: SharedUi.getColor(mColor: mColor) ?? Colors.grey.shade900,),
        SizedBox(height: 5,),
        CText(value, size: 18, color: SharedUi.getColor(mColor: mColor) ?? Colors.grey.shade900,
          maxLine: valueMaxLines, textOverflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 5),
      ],
    );
  }




  // input fields
  static Widget mTextField(CInputController cInputController, String label, String hint, {bool? isDigit, bool? isEmail, bool? isPassword, GlobalKey<FormState>? mKey, bool doNotValidate:false, bool isEditable:true, int maxLine: 1, bool isRequired:true}){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CText(label, size: 15,),
        CTextField(cInputController,  doNotValidate: doNotValidate, mKey:mKey, hintText: hint,
          readOnly: !isEditable, maxLines: maxLine,
          isEmail: isEmail ?? false, isPassword: isPassword ?? false, digitsOnly: isDigit ?? false,),
        SizedBox(height:20),
      ],
    );
  }

  static Widget mSwitch({String? label, required bool switchValue, void onSwitchChange(bool? val)?, mColors? mColor}){
    return Row(
      children: [

        Switch(
            value: switchValue,
            onChanged: onSwitchChange
        ),

        Flexible(child: CText(label ?? "", size: 15, color: SharedUi.getColor(mColor: mColor),)),

      ],
    );
  }



  static Widget headerText(String text, {bold:true}){

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(height: 30),
        CText(text,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        ),
        Divider(),
        SizedBox(height: 5),
      ],
    );
  }



  //colors
  static Color? getColor({mColors? mColor}){

    switch(mColor){
      case mColors.light:
        return Colors.grey.shade50;
      case mColors.dark:
        return Colors.grey.shade900;
      case mColors.divergent:
        return Colors.yellow.shade500;
      case mColors.outlier:
        return Colors.purple.shade500;

      default:
        return null;
    }

  }



  static Widget testButton(Function() onTap){
    return CButton(child: CText("test"),  onTapHandler: onTap,);
  }




}