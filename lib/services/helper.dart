import 'package:flutter/services.dart' as the_bundle;
import 'package:shoes/models/sneaker_model.dart';

class Helper {
  Future<List<Sneakers>> getMaleSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

  Future<List<Sneakers>> getFemaleSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

  Future<List<Sneakers>> getKidsSneaker() async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final maleList = sneakersFromJson(data);

    return maleList;
  }

  Future<Sneakers> getMaleSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  Future<Sneakers> getFemaleSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  Future<Sneakers> getKidsSneakerById(String id) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final maleList = sneakersFromJson(data);

    final sneaker = maleList.firstWhere((sneaker) => sneaker.id == id);

    return sneaker;
  }

  Future<List<Sneakers>> searchSneaker(String query) async {
    final data =
        await the_bundle.rootBundle.loadString("assets/json/men_shoes.json");

    final maleList = sneakersFromJson(data);

    final data2 =
        await the_bundle.rootBundle.loadString("assets/json/women_shoes.json");

    final femaleList = sneakersFromJson(data2);

    final data3 =
        await the_bundle.rootBundle.loadString("assets/json/kids_shoes.json");

    final kidsList = sneakersFromJson(data3);

    final allList = [...maleList, ...femaleList, ...kidsList];

    final sneaker = allList.where(
        (sneaker) => sneaker.name.toLowerCase().contains(query.toLowerCase()));

    return sneaker.toList();
  }
}
