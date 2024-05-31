import 'package:amiriy/bloc/saved_audio/saved_audio_bloc.dart';
import 'package:amiriy/bloc/saved_audio/saved_audio_event.dart';
import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/screens/tabs/audio_books/widgets/audio_item.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemAudiosSearch extends SearchDelegate<String> {
  ItemAudiosSearch({
    required this.items,
    required this.voidCallback,
  });

  final List<AudioBooksModel> items;
  final VoidCallback voidCallback;

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
    List<String> rs = context.read<SavedAudioBloc>().state.savedAudioBooksName;

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
            saveOnTap: () async {
              UtilityFunctions.methodPrint(
                'SAVE ON TAPED',
              );
              if (rs.contains(results[index].bookName)) {
                context.read<SavedAudioBloc>().add(
                      DeleteAudioFromSavedEvent(
                        bookName: results[index].bookName,
                      ),
                    );
              } else {
                context.read<SavedAudioBloc>().add(
                      InsertAudioToDbEvent(
                        audioBook: results[index],
                      ),
                    );
              }
              await Future.delayed(
                const Duration(
                  milliseconds: 500,
                ),
              );
              if (!context.mounted) return;
              context.read<SavedAudioBloc>().add(
                    ListenSavedAudioBooksEvent(),
                  );
              voidCallback.call();
            },
            playOnTap: () {},
            isLiked: rs.contains(
              results[index].bookName,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> rs = context.read<SavedAudioBloc>().state.savedAudioBooksName;

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
          saveOnTap: () async {
            UtilityFunctions.methodPrint(
              'SAVE ON TAPED',
            );
            if (rs.contains(suggestionList[index].bookName)) {
              context.read<SavedAudioBloc>().add(
                    DeleteAudioFromSavedEvent(
                      bookName: suggestionList[index].bookName,
                    ),
                  );
            } else {
              context.read<SavedAudioBloc>().add(
                    InsertAudioToDbEvent(
                      audioBook: suggestionList[index],
                    ),
                  );
            }
            await Future.delayed(
              const Duration(
                milliseconds: 500,
              ),
            );
            if (!context.mounted) return;
            context.read<SavedAudioBloc>().add(
                  ListenSavedAudioBooksEvent(),
                );
            voidCallback.call();
          },
          playOnTap: () {
            Navigator.pushNamed(
              context,
              RouteNames.playerScreen,
              arguments: suggestionList[index],
            );
          },
          isLiked: rs.contains(
            suggestionList[index].bookName,
          ),
        );
      },
    );
  }
}
