import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/models/sneaker_model.dart';
import 'package:shoes/views/shared/stagger_tile.dart';
import 'package:shoes/views/ui/product_page.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key, required this.searchResults});

  final Future<List<Sneakers>> searchResults;

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    // productNotifier.clearShoeSizes();
    return FutureBuilder<List<Sneakers>>(
      future: widget.searchResults,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No results found'));
        } else {
          return StaggeredGridView.countBuilder(
              padding: EdgeInsets.zero,
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
              itemCount: snapshot.data!.length,
              scrollDirection: Axis.vertical,
              staggeredTileBuilder: (index) => StaggeredTile.extent(
                  (index % 2 == 0) ? 1 : 1,
                  (index % 4 == 1 || index % 4 == 3)
                      ? MediaQuery.of(context).size.height * 0.35
                      : MediaQuery.of(context).size.height * 0.3),
              itemBuilder: (context, index) {
                final shoe = snapshot.data![index];
                return GestureDetector(
                    onTap: () {
                      productNotifier.shoesSizes = shoe.sizes;
                      print(shoe.sizes);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ProductPage(
                                    id: shoe.id,
                                    category: shoe.category,
                                  )));
                      // productNotifier.shoeSizes.clear();
                    },
                    child: StaggerTile(
                        imageUrl: shoe.imageUrl[0],
                        name: shoe.name,
                        price: "\$${shoe.price}"));
              });
        }
      },
    );
  }
}
