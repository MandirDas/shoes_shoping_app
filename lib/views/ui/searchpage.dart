import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/views/shared/appstyle.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  List<dynamic> _searchResults = [];

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: _searchController,
          decoration: const InputDecoration(
            hintText: 'Search products...',
            border: InputBorder.none,
          ),
          onChanged: (query) {
            setState(() {
              _searchResults = productNotifier.products
                  .where((product) => product['name']
                      .toLowerCase()
                      .contains(query.toLowerCase()))
                  .toList();
            });
          },
        ),
      ),
      body: _searchResults.isEmpty
          ? Center(
              child: Text('No results found',
                  style: appstyle(18, Colors.grey, FontWeight.w600)))
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final product = _searchResults[index];
                return ListTile(
                  leading: Image.network(product['imageUrl']),
                  title: Text(product['name'],
                      style: appstyle(16, Colors.black, FontWeight.bold)),
                  subtitle: Text(product['category'],
                      style: appstyle(14, Colors.grey, FontWeight.w600)),
                  trailing: Text(product['price'],
                      style: appstyle(16, Colors.black, FontWeight.w600)),
                );
              },
            ),
    );
  }
}
