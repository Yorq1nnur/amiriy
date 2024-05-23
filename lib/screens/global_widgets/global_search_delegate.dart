import 'package:amiriy/data/models/book_model.dart';
import 'package:amiriy/screens/global_widgets/search_items.dart';
import 'package:flutter/material.dart';

class ItemSearch extends SearchDelegate<String> {
  final List<BookModel> items;

  ItemSearch({
    required this.items,
  });

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final List<BookModel> results = items
        .where(
            (item) => item.bookName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailScreen(
            //         productModel: results[index]),
            //   ),
            // );
          },
          child: SearchItems(bookModel: results[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<BookModel> suggestionList = query.isEmpty
        ? []
        : items
            .where((item) =>
                item.bookName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(
            //     builder: (context) => DetailScreen(
            //         productModel: suggestionList[index]),
            //   ),
            // );
          },
          child: SearchItems(
            bookModel: suggestionList[index],
          ),
        );
      },
    );
  }
}
