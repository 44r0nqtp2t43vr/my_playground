import 'dart:math';

import 'package:my_playground/features/piano_tiles/domain/entities/note.dart';

class Song {
  final String audioSource;
  final List<int> beatFrames;

  Song({required this.audioSource, required this.beatFrames});

  List<Note> get songNotes {
    List<Note> notes = [];
    int lastBeatFrame = beatFrames.last;
    int beatFrameIndex = 0;

    if (beatFrames.isEmpty) {
      return notes;
    }

    for (int index = 0; index < lastBeatFrame + 5; index++) {
      int lineNumber = -1;
      if (index < lastBeatFrame && index == beatFrames[beatFrameIndex]) {
        lineNumber = Random().nextInt(5);
        beatFrameIndex++;
      }
      notes.add(Note(index, lineNumber));
    }

    return notes;
  }
}
