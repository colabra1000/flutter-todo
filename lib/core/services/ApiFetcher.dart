import 'package:dio/dio.dart';
import 'package:todo/Variables.dart';

class ApiFetcher{
  
  late Dio _dio;
  
  ApiFetcher(){
    //should time out after 20 seconds.
    _dio = Dio(
        BaseOptions(
        connectTimeout: 20000,
      )
    );
  }
  
  Future<bool> fetchTodos({required Function(dynamic) onSuccess, required Function(dynamic) onError}) async {

    late Response<String> response;

    try{
      response = await _dio.get("${Variables.address}/todos",
        options: Options(
          headers: {
            "Accept" : "application/json"
          }
        )
      );


      await onSuccess(response);
      return true;

    }catch(e){
      await onError(e);
      return false;
    }

    
  }
  
  
  
}