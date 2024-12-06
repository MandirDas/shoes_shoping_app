import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoes/controllers/product_provider.dart';
import 'package:shoes/views/shared/search_widget.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var productNotifier = Provider.of<ProductNotifier>(context);

    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE2E2E2),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search products...',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0), // Rounded corners
              borderSide: BorderSide.none, // No border
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Colors.grey, // Color of the border when enabled
                width: 1.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide(
                color: Colors.black, // Color of the border when focused
                width: 2.0,
              ),
            ),
            filled: true, // Fill the background color
            fillColor: Colors.white, // Background color
            contentPadding: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 20.0), // Padding inside the TextField
          ),
          onChanged: (query) {
            productNotifier.searchSneaker(query);
          },
        ),
      ),
      body: Consumer<ProductNotifier>(
        builder: (context, notifier, child) {
          return SearchWidget(searchResults: notifier.search);
        },
      ),
    );
  }
}
