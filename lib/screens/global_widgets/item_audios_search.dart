import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/screens/tabs/audio_books/widgets/audio_item.dart';
import 'package:flutter/material.dart';

class ItemAudiosSearch extends SearchDelegate<String> {
  final List<AudioBooksModel> items;

  ItemAudiosSearch({
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
    final List<AudioBooksModel> results = items
        .where(
            (item) => item.bookName.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.bookDetailsRoute,
              arguments: results[index],
            );
          },
          child: AudioItem(
            audioBooksModel: results[index],
            saveOnTap: () {},
            playOnTap: () {},
            isLiked: false,
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<AudioBooksModel> suggestionList = query.isEmpty
        ? []
        : items
            .where((item) =>
                item.bookName.toLowerCase().contains(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return AudioItem(
          audioBooksModel: suggestionList[index],
          saveOnTap: () {},
          playOnTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.playerScreen,
              arguments: suggestionList[index],
            );
          },
          isLiked: false,
        );
      },
    );
  }
}
