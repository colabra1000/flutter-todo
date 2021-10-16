import 'package:flutter/cupertino.dart';

abstract class BaseModel extends ChangeNotifier {
  //
  // NavigationService _navigationService  = locator<NavigationService>();
  // NavigationService get navigationService => _navigationService.injectModel(this);


  //is true when page is current scope and false otherwise.
  bool _mounted = true;
  bool get mounted => _mounted;


  notifyListeners1(){
    if(mounted == true){
      notifyListeners();
    }
  }


  @override
  void dispose() {

    _mounted = false;
    super.dispose();
  }


  void disMount() {
    print("dismount");
    _mounted = false;
  }


  void reMount(){
    print("remount");
    _mounted = true;
  }


}