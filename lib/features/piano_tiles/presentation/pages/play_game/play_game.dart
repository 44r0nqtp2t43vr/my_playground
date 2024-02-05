import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:my_playground/features/piano_tiles/domain/entities/song.dart';
import 'package:my_playground/features/piano_tiles/presentation/widgets/line.dart';
import 'package:my_playground/features/piano_tiles/presentation/widgets/line_divider.dart';
import 'package:my_playground/features/piano_tiles/domain/entities/note.dart';

class PlayGame extends StatefulWidget {
  final Song song;

  const PlayGame({super.key, required this.song});

  @override
  State<PlayGame> createState() => _PlayGameState();
}

class _PlayGameState extends State<PlayGame>
    with SingleTickerProviderStateMixin {
  AudioPlayer player = AudioPlayer();
  late AnimationController animationController;
  late List<Note> notes;
  int currentNoteIndex = 0;
  bool hasStarted = true;
  bool isPlaying = true;

  @override
  void initState() {
    super.initState();
    notes = List.from(widget.song.songNotes);
    // notes = initNotes();
    animationController = AnimationController(
      vsync: this,
      // duration: Duration(microseconds: widget.song.microsPerBeat),
      // duration: Duration(microseconds: 45),
      // duration: Duration(microseconds: 9675),
      duration: const Duration(milliseconds: 300),
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isPlaying) {
        // if (notes[currentNoteIndex].state != NoteState.tapped) {
        //   //game over
        //   setState(() {
        //     isPlaying = false;
        //     notes[currentNoteIndex].state = NoteState.missed;
        //   });
        //   animationController.reverse().then((_) => _showFinishDialog());
        // } else if (currentNoteIndex == notes.length - 5) {
        //   //song finished
        //   _showFinishDialog();
        // } else {
        //   setState(() => ++currentNoteIndex);
        //   animationController.forward(from: 0);
        // }

        if (currentNoteIndex == notes.last.orderNumber - 5) {
          //song finished
          player.stop();
          _showFinishDialog();
        } else {
          setState(() {
            currentNoteIndex++;
            print(notes[currentNoteIndex].orderNumber);
          });
          animationController.forward(from: 0);
        }
      }
    });
    player
        .play(AssetSource('audio/littlestar.mp3'))
        .then((value) => animationController.forward());
  }

  @override
  void dispose() {
    animationController.dispose();
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Material(
      child: Stack(
        fit: StackFit.passthrough,
        children: <Widget>[
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
          ),
          Row(
            children: <Widget>[
              _drawLine(0, height, width),
              const LineDivider(),
              _drawLine(1, height, width),
              const LineDivider(),
              _drawLine(2, height, width),
              const LineDivider(),
              _drawLine(3, height, width),
              const LineDivider(),
              _drawLine(4, height, width),
            ],
          ),
        ],
      ),
    );
  }

  void _restart() {
    setState(() {
      notes = List.from(widget.song.songNotes);
      hasStarted = true;
      isPlaying = true;
      currentNoteIndex = 0;
    });
    animationController.reset();
    player
        .play(AssetSource('audio/littlestar.mp3'))
        .then((value) => animationController.forward());
  }

  void _showFinishDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Play again?"),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restart();
              },
              child: const Text("Restart"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text("Exit"),
            ),
          ],
        );
      },
    );
    // .then((_) => _restart());
  }

  void _onTap(Note note) {
    // bool areAllPreviousTapped = notes
    //     .sublist(0, note.orderNumber)
    //     .every((n) => n.state == NoteState.tapped);
    // print(areAllPreviousTapped);
    // if (areAllPreviousTapped) {
    //   if (!hasStarted) {
    //     setState(() => hasStarted = true);
    //     animationController.forward();
    //   }
    //   _playNote(note);
    //   setState(() {
    //     note.state = NoteState.tapped;
    //   });
    // }
    // if (!hasStarted) {
    //   setState(() => hasStarted = true);
    //   animationController.forward();
    // }
    _playNote(note);
    setState(() {
      note.state = NoteState.tapped;
    });
  }

  _drawLine(int lineNumber, double height, double width) {
    // int lastRenderIndex = notes.indexOf(
    //   notes.lastWhere(
    //     (note) => note.orderNumber == currentNoteIndex + 5,
    //     orElse: () => notes.last,
    //   ),
    // );

    return Expanded(
      child: Line(
        height: height,
        width: width,
        lineNumber: lineNumber,
        currentNotes: notes.sublist(currentNoteIndex, currentNoteIndex + 5),
        currentNoteIndex: currentNoteIndex,
        onTileTap: _onTap,
        animation: animationController,
        key: GlobalKey(),
      ),
    );
  }

  _playNote(Note note) {
    // switch (note.line) {
    //   case 0:
    //     player.play(AssetSource('audio/a.wav'));
    //     return;
    //   case 1:
    //     player.play(AssetSource('audio/c.wav'));
    //     return;
    //   case 2:
    //     player.play(AssetSource('audio/e.wav'));
    //     return;
    //   case 3:
    //     player.play(AssetSource('audio/f.wav'));
    //     return;
    //   case 4:
    //     player.play(AssetSource('audio/f.wav'));
    //     return;
    // }
  }
}
