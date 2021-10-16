import 'package:dio/dio.dart';

class ErrorService {

  ErrorService();

  String errorMessage(dynamic errorMessage){

    if(errorMessage is String){
      return errorMessage;
    }

    String? _timeOut = _checkTimeOut(errorMessage);

    if(_timeOut != null){
      return _timeOut;
    }

    String? _exceptionError = _checkExceptionError(errorMessage);

    if(_exceptionError != null){
      return _exceptionError;
    }

    return "Their was an Error!";
  }

  String? _networkError(errorObject){
    try{
      if(errorObject.type == DioErrorType.other){

      }


    }catch(e){
      return null;
    }
  }


  String? _checkTimeOut(errorObject){

  }


  String? _checkExceptionError(errorObject){

  }

}