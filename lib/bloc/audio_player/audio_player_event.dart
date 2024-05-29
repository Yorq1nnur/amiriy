import 'package:equatable/equatable.dart';
import 'package:amiriy/data/models/audio_books_model.dart';

// Events
abstract class AudioPlayerEvent extends Equatable {
  const AudioPlayerEvent();

  @override
  List<Object> get props => [];
}

class InitializePlayer extends AudioPlayerEvent {
  final AudioBooksModel music;

  const InitializePlayer(this.music);

  @override
  List<Object> get props => [music];
}

class PlayPause extends AudioPlayerEvent {}

class Seek extends AudioPlayerEvent {
  final Duration position;

  const Seek(
    this.position,
  );

  @override
  List<Object> get props => [
        position,
      ];
}

class SkipForward extends AudioPlayerEvent {}

class SkipBackward extends AudioPlayerEvent {}

// States
abstract class AudioPlayerState extends Equatable {
  const AudioPlayerState();

  @override
  List<Object> get props => [];
}

class AudioPlayerInitial extends AudioPlayerState {}

class AudioPlayerLoading extends AudioPlayerState {}

class AudioPlayerLoaded extends AudioPlayerState {
  final Duration maxDuration;
  final Duration currentPosition;
  final bool isPlaying;

  const AudioPlayerLoaded({
    required this.maxDuration,
    required this.currentPosition,
    required this.isPlaying,
  });

  @override
  List<Object> get props => [
        maxDuration,
        currentPosition,
        isPlaying,
      ];
}

class AudioPlayerError extends AudioPlayerState {
  final String message;

  const AudioPlayerError(
    this.message,
  );

  @override
  List<Object> get props => [
        message,
      ];
}
