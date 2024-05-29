import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class PlayerScreen extends StatefulWidget {
  const PlayerScreen({
    // required this.player,
    required this.music,
    super.key,
  });

  final AudioBooksModel music;

  // final AudioPlayer player;

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  Duration maxDuration = Duration.zero;
  Duration currentPosition = Duration.zero;
  bool isLoading = true;
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  Future<void> initializePlayer() async {
    player.onDurationChanged.listen((Duration duration) {
      setState(() {
        maxDuration = duration;
        player.play(
          UrlSource(
            widget.music.bookUrl,
          ),
        );
        isLoading = false;
      });
    });

    player.onPositionChanged.listen((Duration position) {
      setState(() {
        currentPosition = position;
      });
    });

    player.onPlayerComplete.listen((event) {
      setState(() {
        currentPosition = maxDuration;
      });
    });

    try {
      await player.setSourceUrl(widget.music.bookUrl);
      await player.resume();
    } catch (e) {
      // Handle error
      UtilityFunctions.methodPrint("Error initializing audio player: $e");
    }
  }

  void seekTo(Duration position) {
    player.seek(position);
  }

  void playPause() {
    if (player.state == PlayerState.playing) {
      player.pause();
    } else {
      player.resume();
    }
  }

  void skipForward() {
    final newPosition = currentPosition + const Duration(seconds: 15);
    seekTo(newPosition < maxDuration ? newPosition : maxDuration);
  }

  void skipBackward() {
    final newPosition = currentPosition - const Duration(seconds: 15);
    seekTo(newPosition > Duration.zero ? newPosition : Duration.zero);
  }

  bool isListen = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        title: const Text(
          "Audio Player",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(20),
        color: Colors.blue,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.7,
                height: MediaQuery.of(context).size.width * 0.7,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.music.imageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 60),
            Text(
              widget.music.bookName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
            Text(
              widget.music.bookName,
              style: TextStyle(
                color: Colors.white.withOpacity(0.5),
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ProgressBar(
              progressBarColor: Colors.black,
              baseBarColor: Colors.white,
              bufferedBarColor: Colors.grey,
              progress: currentPosition,
              total: maxDuration,
              onSeek: seekTo,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: isLoading
                      ? () {
                          UtilityFunctions.showSnackBar(
                            'please_wait_audio'.tr(),
                            context,
                          );
                          UtilityFunctions.methodPrint(
                            'BACKWARD IS LOADING',
                          );
                        }
                      : skipBackward,
                  icon: const Icon(
                    Icons.replay_5,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
                isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : IconButton(
                        onPressed: () {
                          playPause();
                          setState(() {});
                        },
                        icon: Icon(
                          player.state == PlayerState.playing
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 40,
                          color: Colors.white,
                        ),
                      ),
                IconButton(
                  onPressed: isLoading
                      ? () {
                          UtilityFunctions.showSnackBar(
                            'please_wait_audio'.tr(),
                            context,
                          );
                          UtilityFunctions.methodPrint(
                            'FORWARD IS LOADING',
                          );
                        }
                      : skipForward,
                  icon: const Icon(
                    Icons.forward_5,
                    size: 36,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
