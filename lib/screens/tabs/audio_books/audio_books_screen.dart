import 'package:amiriy/bloc/audio_books/audio_books_bloc.dart';
import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/bloc/saved_audio/saved_audio_bloc.dart';
import 'package:amiriy/bloc/saved_audio/saved_audio_event.dart';
import 'package:amiriy/screens/global_widgets/item_audios_search.dart';
import 'package:amiriy/screens/global_widgets/global_text.dart';
import 'package:amiriy/screens/routes.dart';
import 'package:amiriy/screens/tabs/audio_books/widgets/audio_item.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_utils/my_utils.dart';

class AudioBooksScreen extends StatefulWidget {
  const AudioBooksScreen({super.key});

  @override
  State<AudioBooksScreen> createState() => _AudioBooksScreenState();
}

class _AudioBooksScreenState extends State<AudioBooksScreen> {
  TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    // player.dispose();
    super.dispose();
  }

  // final AudioPlayer player = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: ItemAudiosSearch(
                  items: context.read<AudioBooksBloc>().state.audioBooks,
                ),
              );
            },
            icon: Icon(
              Icons.search,
              size: 24.w,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                RouteNames.favouriteAudioBooksScreen,
              );
            },
            icon: Icon(
              Icons.favorite,
              size: 24.w,
              color: Theme.of(context).iconTheme.color,
            ),
          ),
        ],
        centerTitle: true,
        title: GlobalText(
          data: "audio_books",
          fontSize: 20.sp,
          fontWeight: FontWeight.w900,
          isTranslate: true,
        ),
      ),
      body: BlocBuilder<AudioBooksBloc, AudioBooksState>(
          builder: (context, state) {
        if (state.formStatus == FormStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.formStatus == FormStatus.error) {
          return Center(
            child: Text(state.errorText),
          );
        }
        if (state.formStatus == FormStatus.success) {
          return ListView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: 20.h,
            ),
            itemCount: state.audioBooks.length,
            itemBuilder: (context, index) {
              UtilityFunctions.methodPrint(
                'CURRENT ID: ${state.audioBooks[index].id}',
              );
              UtilityFunctions.methodPrint(
                'Saved book name is length: ${context.read<SavedAudioBloc>().state.savedAudioBooksName.length}',
              );
              return Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 5.h,
                ),
                child: AudioItem(
                  saveOnTap: () async {
                    UtilityFunctions.methodPrint(
                      'SAVE ON TAPED',
                    );
                    if(context.read<SavedAudioBloc>().state.savedAudioBooksName.contains(state.audioBooks[index].bookName)){
                      context.read<SavedAudioBloc>().add(DeleteAudioFromSavedEvent(bookName: state.audioBooks[index].bookName,),);
                    }else{
                      context.read<SavedAudioBloc>().add(
                        InsertAudioToDbEvent(
                          audioBook: state.audioBooks[index],
                        ),
                      );
                    }
                    await Future.delayed(const Duration(milliseconds: 500));
                    if (!context.mounted) return;
                    context.read<SavedAudioBloc>().add(
                          ListenSavedAudioBooksEvent(),
                        );

                    setState(() {});
                  },
                  audioBooksModel: state.audioBooks[index],
                  playOnTap: () {
                    UtilityFunctions.methodPrint(
                      'PLAY ON TAPED',
                    );
                    Navigator.pushNamed(
                      context,
                      RouteNames.playerScreen,
                      arguments: state.audioBooks[index],
                    );
                  },
                  isLiked: context
                      .read<SavedAudioBloc>()
                      .state
                      .savedAudioBooksName
                      .contains(
                        state.audioBooks[index].bookName,
                      ),
                ),
              );
            },
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }
}
