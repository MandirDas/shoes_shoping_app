import 'package:flutter/services.dart' as the_bundle;
import 'package:shoes/models/sneaker_model.dart';


class Helper{
  Future<List<Sneakers>> getMaleSneaker() async{
    final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

  Future<List<Sneakers>> getFemaleSneaker() async{
    final data = await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

  Future<List<Sneakers>> getKidsSneaker() async{
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

  Future<Sneakers> getMaleSneakerById(String id) async{
    final data = await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  Future<Sneakers> getFemaleSneakerById(String id) async{
    final data = await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);


    return sneaker;
  }

  Future<Sneakers> getKidsSneakerById(String id) async{
    final data = await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);


    return sneaker;
  }

}