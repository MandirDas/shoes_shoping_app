import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/views/shared/appstyle.dart';
import 'package:shoes/views/ui/favorites.dart';

import '../../controllers/favorites_provider.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key, required this.price, required this.category, required this.id, required this.name, required this.image});

  final String price;
  final String category;
  final String id;
  final String name;
  final String image;

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {


  bool selected = true;
  @override
  Widget build(BuildContext context) {
    var favoritesNotifier = Provider.of<FavoritesNotifier>(context,listen: true);
    favoritesNotifier.getFavorites();
    return Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 20, 0),
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16),),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width * 0.6,
          decoration: const BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.white,
                spreadRadius: 1,
                blurRadius: 0.6,
                offset: Offset(1,1),
              )
            ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.23,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.image))
                    ),
                  ),
                  Positioned(
                    right: 10,
                      top: 10,
                      child: GestureDetector(
                        onTap: (){
                          if(favoritesNotifier.ids.contains(widget.id)){
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context)=> const Favorites()));
                          } else {
                            favoritesNotifier.createFav({
                              "id": widget.id,
                              "name": widget.name,
                              "category": widget.category,
                              "price": widget.price,
                              "imageUrl": widget.image,
                            });
                            }
                          setState(() {

                          });
                        },
                        child: favoritesNotifier.ids.contains(widget.id)? const Icon(
                          Ionicons.heart) : const Icon(Ionicons.heart_outline),
                      )
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.name,style: appstylewithHT(36, Colors.black, FontWeight.bold, 1.1),
                    ),
                    Text(
                      widget.category,style: appstylewithHT(18, Colors.grey, FontWeight.bold, 1.5),
                    ),
                  ],
                ),
              ),

              Padding(
                  padding:const EdgeInsets.only(left: 8,right: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.price,style: appstyle(30, Colors.black, FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text("Colors",style: appstyle(18, Colors.grey, FontWeight.w500),),

                        const SizedBox(
                          width: 5,
                        ),

                        ChoiceChip(
                            label: const Text(" "),
                            selected: selected,
                          visualDensity: VisualDensity.compact,
                          selectedColor: Colors.black,
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),

                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
