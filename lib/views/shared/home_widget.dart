import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/views/shared/product_card.dart';
import 'package:shoes/views/ui/product_by_cart.dart';
import 'package:shoes/views/ui/product_page.dart';

import '../../models/sneaker_model.dart';
import 'New_Shoes.dart';
import 'appstyle.dart';


class HomeWidget extends StatelessWidget {
  const HomeWidget({
    super.key,
    required Future<List<Sneakers>> male, required this.tabIndex,
  }) : _male = male;

  final Future<List<Sneakers>> _male;
  final int tabIndex;


  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Column(
      children: [
        SizedBox(
            height: MediaQuery.of(context).size.height*0.405,
            child: FutureBuilder<List<Sneakers>>(
              future: _male,
              builder: (context,snapshot){
                if(snapshot.connectionState == ConnectionState.waiting){
                  return CircularProgressIndicator();
                }else if (snapshot.hasError){
                  return Text("Error ${snapshot.error}");
                }else{
                  final male = snapshot.data;
                  return ListView.builder(
                      itemCount: male!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        final shoe = snapshot.data![index];
                        return GestureDetector(
                          onTap: (){
                            productNotifier.shoesSizes = shoe.sizes;
                            // print(productNotifier.shoeSizes);
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context)=> ProductPage(
                                    id: shoe.id, category: shoe.category)));
                          },
                          child: ProductCard(
                              price: "\$${shoe.price}",
                              catagory: shoe.category,
                              id: shoe.id,
                              name: shoe.name,
                              image: shoe.imageUrl[0]),
                        );
                      });
                }
              },
            )
        ),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 20, 12, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Latest Shoes",
                    style: appstyle(24, Colors.black, FontWeight.bold),),

                  GestureDetector(
                    onTap: (){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>ProductByCat(tabIndex:tabIndex ,)));
                    },
                    child: Row(
                      children: [
                        Text("Show All",
                          style: appstyle(22, Colors.black, FontWeight.bold),),
                        Icon(Icons.arrow_right_sharp,size: 30,)
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.13,
          child: FutureBuilder<List<Sneakers>>(
            future: _male,
            builder: (context,snapshot){
              if(snapshot.connectionState == ConnectionState.waiting){
                return CircularProgressIndicator();
              }else if (snapshot.hasError){
                return Text("Error ${snapshot.error}");
              }else{
                final male = snapshot.data;
                return ListView.builder(
                    itemCount: male!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                      final shoe = snapshot.data![index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: NewShoes(
                            imageUrl: shoe.imageUrl[0]),
                      );
                    });
              }
            },
          ),
        ),
      ],
    );
  }
}