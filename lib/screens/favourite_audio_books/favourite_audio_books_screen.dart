import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/saved_audio/saved_audio_bloc.dart';
import 'package:amiriy/bloc/saved_audio/saved_audio_state.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/screens/tabs/audio_books/widgets/audio_item.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

class FavouriteAudioBooksScreen extends StatefulWidget {
  const FavouriteAudioBooksScreen({super.key});

  @override
  State<FavouriteAudioBooksScreen> createState() =>
      _FavouriteAudioBooksScreenState();
}

class _FavouriteAudioBooksScreenState extends State<FavouriteAudioBooksScreen> {
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: UtilityFunctions.systemUiOverlayStyle(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: GlobalText(
            data: 'saved_audio',
            fontSize: 20.w,
            fontWeight: FontWeight.w900,
            isTranslate: true,
          ),
        ),
        body: BlocBuilder<SavedAudioBloc, SavedAudioState>(
            builder: (context, state) {
          if (state.formStatus == FormStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state.formStatus == FormStatus.error) {
            return Center(
              child: Text(
                state.errorText,
              ),
            );
          }
          if (state.formStatus == FormStatus.success) {
            return ListView.builder(
                itemCount: state.savedAudioBooks.length,
                itemBuilder: (context, index) {
                  return AudioItem(
                    audioBooksModel: state.savedAudioBooks[index],
                    saveOnTap: () {},
                    playOnTap: () {
                      Navigator.pushNamed(
                        context,
                        RouteNames.playerScreen,
                        arguments: state.savedAudioBooks[index],
                      );
                    },
                    isLiked: true,
                  );
                });
          }

          return const SizedBox.shrink();
        }),
      ),
    );
  }
}
