import 'package:flutter/material.dart';

class ProductNotifier extends ChangeNotifier{

  int _activepage = 0;
  List<dynamic> _shoessizes = [];
  List<String> _sizes = [];



  int  get activepage => _activepage;
  set activePage(int newIndex){
    _activepage=newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoessizes;

  set shoesSizes(List<dynamic> newSizes) {
    _shoessizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index){
    for(int i = 0; i < _shoessizes.length; i++){
      if(i == index){
        _shoessizes[i]['isSelected'] = !_shoessizes[i]['isSelected'];
      }
    }
    notifyListeners();
  }


  List<String> get sizes => _sizes;

  set sizes(List<String> newSizes) {
    _sizes = newSizes;
    notifyListeners();
  }

}