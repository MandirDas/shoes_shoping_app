import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:hive/hive.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/views/shared/appstyle.dart';

import '../../models/sneaker_model.dart';
import '../../services/helper.dart';
import '../shared/checkout_btn.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key, required this.id, required this.category});
  final String id;
  final String category;

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {

  final PageController pageController = PageController();

  late Future<Sneakers> _sneaker;
  final _cartBox = Hive.box('cart_box');


  void getShoes() {
    if (widget.category == "Men's Running") {
      _sneaker = Helper().getMaleSneakerById(widget.id);
    } else if (widget.category == "Women's Running") {
      _sneaker = Helper().getFemaleSneakerById(widget.id);
    } else {
      _sneaker = Helper().getKidsSneakerById(widget.id);
    }
  }


  Future<void> _createCart(Map<dynamic, dynamic> newCart) async {
    await _cartBox.add(newCart);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getShoes();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  FutureBuilder<Sneakers>(
        future: _sneaker,
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text("Error ${snapshot.error}");
          } else {
            final sneaker = snapshot.data;
            return Consumer<ProductNotifier>(
              builder: (context, productNotifier, child) {
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      leadingWidth: 0,
                      title: Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                                productNotifier.shoeSizes.clear();
                              },
                              child: Icon(Icons.close_outlined),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Icon(Ionicons.ellipsis_horizontal,color: Colors.black,),
                            ),
                          ],
                        ),
                      ),
                      pinned: true,
                      snap: false,
                      floating: true,
                      backgroundColor: Colors.transparent,
                      expandedHeight: MediaQuery
                          .of(context)
                          .size
                          .height,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Stack(
                          children: [
                            SizedBox(
                              height: MediaQuery
                                  .of(context)
                                  .size
                                  .height * 0.5,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              child: PageView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: sneaker!.imageUrl.length,
                                  controller: pageController,
                                  onPageChanged: (page) {
                                    productNotifier.activePage = page;
                                  },
                                  itemBuilder: (context, int index) {
                                    return Stack(
                                      children: [
                                        Container(
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.4,
                                          width: MediaQuery
                                              .of(context)
                                              .size
                                              .width,
                                          color: Colors.grey.shade300,
                                          child: CachedNetworkImage(
                                            imageUrl: sneaker.imageUrl[index],
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        Positioned(
                                            top: MediaQuery
                                                .of(context)
                                                .size
                                                .height * 0.12,
                                            right: 15,
                                            child: Icon(
                                              Ionicons.heart_outline,
                                              color: Colors.grey,
                                            )),
                                        Positioned(
                                          bottom: 0,
                                          right: 0,
                                          left: 0,
                                          height: MediaQuery
                                              .of(context)
                                              .size
                                              .height * 0.3,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center,
                                            children: List<Widget>.generate(
                                                sneaker.imageUrl.length, (index) =>
                                                Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 4),
                                                  child: CircleAvatar(
                                                    radius: 5,
                                                    backgroundColor: productNotifier
                                                        .activepage != index ?
                                                    Colors.grey : Colors.black,
                                                  ),
                                                )),
                                          ),
                                        ),
                                      ],
                                    );
                                  }
                              ),
                            ),
                            Positioned(
                              bottom: 30,
                              child:ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(30),
                                  topRight: Radius.circular(30),
                                ),
                                child: Container(
                                  height: MediaQuery.of(context).size.height * 0.645,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.white,
                                  child: Padding(
                                    padding: EdgeInsets.all(12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(sneaker.name,style: appstyle(40, Colors.black, FontWeight.bold),),
                                        Row(
                                          children: [
                                            Text(sneaker.category,
                                            style: appstyle(20, Colors.grey, FontWeight.w500),),
                                            SizedBox(
                                              width: 20,

                                            ),
                                            RatingBar.builder(
                                                initialRating: 4,
                                                minRating: 1,
                                                direction: Axis.horizontal,
                                                allowHalfRating: true,
                                                itemCount: 5,
                                                itemSize: 22,
                                              itemPadding:
                                              const EdgeInsets
                                                  .symmetric(
                                                  horizontal: 1),
                                                itemBuilder:(context,_)=> Icon(Icons.star,size: 18,color: Colors.black,),
                                              onRatingUpdate: (rating){

                                              },
                                                ),

                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "\$${sneaker.price}",
                                              style: appstyle(
                                                  26,
                                                  Colors.black,
                                                  FontWeight.w600),
                                            ),
                                            Row(
                                              children: [
                                                Text("Colors",
                                                style: appstyle(
                                                    18,
                                                    Colors.black,
                                                    FontWeight.w500),
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  radius: 7,
                                                    backgroundColor: Colors.black,
                                                ),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                CircleAvatar(
                                                  radius: 7,
                                                  backgroundColor: Colors.red,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "Select sizes",
                                                  style: appstyle(
                                                      20,
                                                      Colors.black,
                                                      FontWeight.w600),
                                                ),
                                                const SizedBox(
                                                  width: 20,
                                                ),
                                                Text(
                                                  "View size guide",
                                                  style: appstyle(
                                                      20,
                                                      Colors.grey,
                                                      FontWeight.w600),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              height: 40,
                                              child: ListView.builder(
                                                  itemCount:
                                                  productNotifier
                                                      .shoeSizes
                                                      .length,
                                                  scrollDirection:
                                                  Axis.horizontal,
                                                  padding:
                                                  EdgeInsets.zero,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final sizes = productNotifier.shoeSizes[index];

                                                    return Padding(
                                                      padding:
                                                      const EdgeInsets.symmetric(horizontal: 8.0,),
                                                      child: ChoiceChip(
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                60),
                                                            side: const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 1,
                                                                style: BorderStyle
                                                                    .solid)),
                                                        disabledColor:
                                                        Colors.white,
                                                        label: Text(
                                                          sizes['size'],
                                                          style: appstyle(
                                                              18,
                                                              sizes['isSelected']
                                                                  ? Colors
                                                                  .white
                                                                  : Colors
                                                                  .black,
                                                              FontWeight
                                                                  .w500),
                                                        ),
                                                        selectedColor:
                                                        Colors.black,
                                                        padding:
                                                        const EdgeInsets
                                                            .symmetric(
                                                            vertical:
                                                            8),
                                                        selected: sizes[
                                                        'isSelected'],
                                                        onSelected:
                                                            (newState) {
                                                          if (productNotifier.sizes.contains(sizes[
                                                          'size'])) {
                                                            productNotifier
                                                                .sizes
                                                                .remove(sizes[
                                                            'size']);
                                                          } else {
                                                            productNotifier
                                                                .sizes
                                                                .add(sizes[
                                                            'size']);
                                                          }
                                                          print(
                                                              productNotifier
                                                                  .sizes);
                                                          productNotifier
                                                              .toggleCheck(
                                                              index);
                                                        },
                                                      ),
                                                    );
                                                  }),
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        const Divider(
                                          indent: 10,
                                          endIndent: 10,
                                          color: Colors.black,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.8,
                                          child: Text(
                                            sneaker.title,
                                            maxLines: 2,
                                            style: appstyle(
                                                26,
                                                Colors.black,
                                                FontWeight.w700),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          sneaker.description,
                                          textAlign: TextAlign.justify,
                                          maxLines: 4,
                                          style: appstyle(
                                              14,
                                              Colors.black,
                                              FontWeight.normal),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Align(
                                          alignment:
                                          Alignment.bottomCenter,
                                          child: Padding(
                                            padding:
                                            const EdgeInsets.only(
                                                top: 12),
                                            child: CheckoutButton(
                                              onTap: () async {
                                                _createCart({
                                                  "id": sneaker.id,
                                                  "name": sneaker.name,
                                                  "category":
                                                  sneaker.category,
                                                  "sizes": productNotifier
                                                      .sizes[0],
                                                  "imageUrl":
                                                  sneaker.imageUrl[0],
                                                  "price": sneaker.price,
                                                  "qty": 1
                                                });
                                                print(sneaker.name);
                                                productNotifier.sizes
                                                    .clear();
                                                Navigator.pop(context);
                                              },
                                              label: "Add to Cart",
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        }
      ),
    );
  }
}
