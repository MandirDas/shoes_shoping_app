import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/favorites_provider.dart';
import 'package:shoes/views/ui/mainscreen.dart';

import '../shared/appstyle.dart';

class Favorites extends StatefulWidget {
  const Favorites({super.key});

  @override
  State<Favorites> createState() => _FavoritesState();
}

class _FavoritesState extends State<Favorites> {




  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context);
    favoritesNotifier.getAllData();
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height * 0.4,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/top_image.png"),
                    fit: BoxFit.cover),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'My Favorites',
                  style: appstyle(36, Colors.white, FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: ListView.builder(
                  itemCount: favoritesNotifier.fav.length,
                  padding: const EdgeInsets.only(top: 100),
                  itemBuilder: (BuildContext context, int index) {
                    final shoe = favoritesNotifier.fav[index];
                    return Padding(
                      padding: const EdgeInsets.all(8),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: MediaQuery.of(context).size.height * 0.11,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.shade500,
                                  spreadRadius: 5,
                                  blurRadius: 0.3,
                                  offset: const Offset(0, 1),
                                ),
                              ]),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: CachedNetworkImage(
                                      imageUrl: shoe['imageUrl'],
                                      width: 70,
                                      height: 70,
                                      fit: BoxFit.fill,

                                    ),
                                  ),

                                  Padding(padding: const EdgeInsets.only(top: 12,left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(shoe['name'],style: appstyle(16, Colors.black, FontWeight.bold),),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(shoe['category'],style: appstyle(14, Colors.grey, FontWeight.w600),),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text('${shoe['price']}',style: appstyle(18, Colors.black, FontWeight.bold),),
                                        ],
                                      ),
                                    ],
                                  ),)
                                ],
                              ),
                              Padding(padding: const EdgeInsets.all(8),
                                child: GestureDetector(
                                  onTap: (){
                                    favoritesNotifier.deleteFav(shoe['key']);
                                    favoritesNotifier.ids.removeWhere((element) => element == shoe['id']);
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (context) => MainScreen()));
                                  },
                                  child: const Icon(Ionicons.heart_dislike),
                                ),),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
