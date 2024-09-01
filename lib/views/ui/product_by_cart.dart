import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shoes/views/shared/category_btn.dart';
import 'package:shoes/views/shared/custom_spacer.dart';
import 'package:shoes/views/shared/stagger_tile.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

import '../../models/sneaker_model.dart';
import '../../services/helper.dart';
import '../shared/New_Shoes.dart';
import '../shared/appstyle.dart';
import '../shared/latest_shoes.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key, required this.tabIndex});
  final int tabIndex;

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat> with TickerProviderStateMixin{
  late final TabController _tabController = TabController(length: 3, vsync: this);


  late Future<List<Sneakers>> _male;
  late Future<List<Sneakers>> _female;
  late Future<List<Sneakers>> _kids;

  void getMale(){
    _male = Helper().getMaleSneaker();
  }

  void getFemale(){
    _female = Helper().getFemaleSneaker();
  }

  void getKids(){
    _kids = Helper().getKidsSneaker();
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController.animateTo(widget.tabIndex, curve: Curves.easeIn);
    getMale();
    getFemale();
    getKids();
  }



  List<String> brand = [
    "assets/images/adidas.png",
    "assets/images/gucci.png",
    "assets/images/jordan.png",
    "assets/images/nike.png",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            Container(padding: const EdgeInsets.fromLTRB(16, 45, 0, 0),
              height: MediaQuery.of(context).size.height*0.4,
              decoration: const BoxDecoration(
                image: DecorationImage(image:AssetImage("assets/images/top_image.png"),fit:BoxFit.fill),
              ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                    padding: EdgeInsets.fromLTRB(6, 12, 16, 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: Icon(Icons.close,color: Colors.white,),
                    ),
                    GestureDetector(
                      onTap: (){
                        // Navigator.pop(context);
                        filter();
                      },
                      child: Icon(Icons.view_list_rounded,color: Colors.white,),
                    )
                  ],
                ),
                ),

                TabBar(
                    padding: EdgeInsets.zero,
                    indicatorSize: TabBarIndicatorSize.label,
                    indicatorColor: Colors.transparent,
                    controller: _tabController,
                    isScrollable: true,
                    dividerColor: Colors.transparent,
                    labelColor: Colors.white,
                    labelStyle: appstyle(24, Colors.white, FontWeight.bold),
                    unselectedLabelColor: Colors.grey.withOpacity(0.3),


                    tabs: const [
                      Tab(text: "Men Shoes",),
                      Tab(text: "Women Shoes",),
                      Tab(text: "Kids Shoes",),
                    ]),
              ],
            ),
            ),


            Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.175,
                  left: 16,
                  right: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: TabBarView(
                  controller: _tabController,
                    children: [
                      latestShoes(male: _male),
                      latestShoes(male: _female),
                      latestShoes(male: _kids),

                    ]
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  Future<dynamic> filter() async {
    double _value = 0.0;
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.white54,
        builder: (context)=> Container(
          height: MediaQuery.of(context).size.height*0.84,
          width: double.maxFinite,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 10,

              ),
              Container(
                height: 5,
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.black38,
                ),
              ),

              SizedBox(
                height: MediaQuery.of(context).size.height*0.7,
                child: Column(
                  children: [
                    CustomSpacer(),
                    Text("Filter",style: appstyle(40, Colors.black, FontWeight.bold),),
                    CustomSpacer(),
                    Text("Gender",style: appstyle(20, Colors.black, FontWeight.bold),),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CatagoryBtn(buttonClr:Colors.black, label: "Men"),

                        CatagoryBtn(buttonClr:Colors.black, label: "Women"),

                        CatagoryBtn(buttonClr:Colors.black, label: "Kids"),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Category",
                      style: appstyle(20, Colors.black, FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        CatagoryBtn(
                          label: "Shoes",
                          buttonClr: Colors.black,
                        ),
                        CatagoryBtn(
                          label: "Apparrels",
                          buttonClr: Colors.grey,
                        ),
                        CatagoryBtn(
                          label: "Accessories",
                          buttonClr: Colors.grey,
                        ),
                      ],
                    ),
                    const CustomSpacer(),
                    Text(
                      "Price",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    const CustomSpacer(),
                    Slider(
                        value: _value,
                        activeColor: Colors.black,
                        inactiveColor: Colors.grey,
                        thumbColor: Colors.black,
                        max: 500.0,

                        divisions: 50,
                        label: _value.round().toString(),
                        onChanged: (double newvalue) {
                          setState(() {
                            _value=newvalue;
                          });
                        }),
                    CustomSpacer(),
                    Text(
                      "Brand",
                      style: appstyle(20, Colors.black, FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 80,
                      child: ListView.builder(
                          itemCount: brand.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(8),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade200,
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(12))),
                                child: Image.asset(
                                  brand[index],
                                  height: 60,
                                  width: 80,
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}


