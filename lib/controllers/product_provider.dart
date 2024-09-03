import 'package:flutter/material.dart';

import '../models/sneaker_model.dart';
import '../services/helper.dart';

class ProductNotifier extends ChangeNotifier {
  final List<dynamic> _products = [];

  List<dynamic> get products => _products;

  int _activepage = 0;
  List<dynamic> _shoessizes = [];
  List<String> _sizes = [];

  int get activepage => _activepage;
  set activePage(int newIndex) {
    _activepage = newIndex;
    notifyListeners();
  }

  List<dynamic> get shoeSizes => _shoessizes;

  set shoesSizes(List<dynamic> newSizes) {
    _shoessizes = newSizes;
    notifyListeners();
  }

  void toggleCheck(int index) {
    for (int i = 0; i < _shoessizes.length; i++) {
      if (i == index) {
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

  late Future<List<Sneakers>> male;
  late Future<List<Sneakers>> female;
  late Future<List<Sneakers>> kids;
  late Future<Sneakers> sneaker;

  void getMale() {
    male = Helper().getMaleSneaker();
  }

  void getFemale() {
    female = Helper().getFemaleSneaker();
  }

  void getKids() {
    kids = Helper().getKidsSneaker();
  }

  void getShoes(String category, String id) {
    if (category == "Men's Running") {
      sneaker = Helper().getMaleSneakerById(id);
    } else if (category == "Women's Running") {
      sneaker = Helper().getFemaleSneakerById(id);
    } else {
      sneaker = Helper().getKidsSneakerById(id);
    }
  }
}
