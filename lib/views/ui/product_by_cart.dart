import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../shared/appstyle.dart';

class ProductByCat extends StatefulWidget {
  const ProductByCat({super.key});

  @override
  State<ProductByCat> createState() => _ProductByCatState();
}

class _ProductByCatState extends State<ProductByCat> with TickerProviderStateMixin{
  late final TabController _tabController = TabController(length: 3, vsync: this);
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
              padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.2,left: 16,right: 12),
              child: TabBarView(
                controller: _tabController,
                  children: [
                    Container(
                      height: 500,
                      width: 300,
                      color: Colors.green,
                    ),
                    Container(
                      height: 500,
                      width: 300,
                      color: Colors.green,
                    ),
                    Container(
                      height: 500,
                      width: 300,
                      color: Colors.green,
                    ),
                  ]
              ),
            )
          ],
        ),
      ),
    );
  }
}
