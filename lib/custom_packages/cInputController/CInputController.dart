import 'package:flutter/material.dart';

/// CForm Field Controller
class CInputController {

  /// Algorithm to validate input.
  ///
  /// returns Null when validation passes.
  /// returns String to be displayed on ui when validation fails.
  // String? Function(dynamic)? validationRule;

  /// The initial value of text input.
  final dynamic initialValue;

  /// should validate when input widget looses focus.
  final bool autoValidate;

  String? Function(dynamic)? inputValidation;

  CInputController({this.autoValidate:true, this.initialValue,
    String Function(dynamic)? validationRule}) {
       // textController.text = initialValue ?? "";

      setSelectedValue(initialValue);
      _setUpAutoValidation();

      // validationRule = validationRule ?? _defaultValidation;
      inputValidation = validationRule ?? _defaultValidation;

      // validationRule = validationRule ?? _defaultValidation;
  }

  bool doNotValidate = false;

  //handles auto validation
  _setUpAutoValidation(){
    if(autoValidate == true){
      _focusNode = FocusNode();

      focusNode?.addListener(() {

        if(textController.text.trim() == ""){
          return;
        }

        if(focusNode?.hasFocus == false){
          formKey.currentState?.validate();

          if(onLooseFocus != null){
            onLooseFocus!(selectedValue);
          }

        }
      });
    }
  }



  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  /// Determines if textField should be updated with current value.
  bool shouldNotUpdateText = false;

  /// Holds current input value.
  dynamic _selectedValue;

  get selectedValue => _selectedValue;


  setSelectedValue(dynamic value, {bool setTextControllerValue:true}) {


    if(_selectedValue is String)
      _selectedValue = value?.trim();
    else
      _selectedValue = value;

    if(!shouldNotUpdateText && value is String && setTextControllerValue == true){
      _textController.text = value;

    }

  }

  /// Called when current input value is changed or assigned.
  void Function(dynamic s) onChange = (dynamic s){};

  /// Called when focus to input widget is lost
  void Function(dynamic)? onLooseFocus;

  /// Checks if widget is still in widget tree.
  bool? get mounted => formKey.currentState?.mounted;

  /// Checks if input is validated.
  bool? get validated =>  formKey.currentState?.validate();

  FocusNode? _focusNode;
  FocusNode? get focusNode => _focusNode;

  final _textController = TextEditingController();
  TextEditingController get textController => _textController;

  setTextField(value){
    _textController.text = value;
  }


  /// Resets input to None.
  void reset(){
    textController.text = "";
    setSelectedValue(null);
  }

  /// Executes validation for input.
  bool? validate() {

    if(doNotValidate == true){
      return true;
    }


    if(mounted == null || mounted == false){
      return true;
    }

    // if(validated != null && validated == true){
    //   return true;
    // }

    if(validated == true){
      return true;
    }



    return false;
  }

  String? _defaultValidation(dynamic value){

    if (value == null || (value is String && value.trim() == "")){
      return "This field cannot be empty!!";
    }

    return null;
  }

  //called when the parent widget is disposed
  void dispose(){
    reset();
  }



  // void reset() {
  //   selectedValue = null;
  //   controller.text = "";
  //   formKey.currentState?.reset();
  // }

  // void refreshGlobalKey(){
  //   formKey = GlobalKey<FormState>();
  // }


  // bool operator ==(dynamic other) =>
  //     other != null && other is FieldAndLabelPassers && this.selectedValue == other.selectedValue;
  //
  // @override
  // int get hashCode => super.hashCode;


}