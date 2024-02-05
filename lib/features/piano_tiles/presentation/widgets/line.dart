import 'package:flutter/material.dart';
import 'package:my_playground/features/piano_tiles/domain/entities/note.dart';
import 'package:my_playground/features/piano_tiles/presentation/widgets/tile.dart';

class Line extends AnimatedWidget {
  final double height;
  final double width;
  final int lineNumber;
  final int currentNoteIndex;
  final List<Note> currentNotes;
  final Function(Note) onTileTap;

  const Line(
      {required Key key,
      required this.height,
      required this.width,
      required this.currentNotes,
      required this.currentNoteIndex,
      required this.lineNumber,
      required this.onTileTap,
      required Animation<double> animation})
      : super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    Animation<double>? animation = super.listenable as Animation<double>?;
    //get sizes
    double tileHeight = height / 4;
    double tileWidth = width / 5;

    //get only notes for that line
    List<Note> thisLineNotes =
        currentNotes.where((note) => note.line == lineNumber).toList();

    //map notes to widgets
    List<Widget> tiles = thisLineNotes.map((note) {
      //specify note distance from top
      int index = note.orderNumber - currentNoteIndex;
      double offset = (3 - index + animation!.value) * tileHeight;

      return Transform.translate(
        offset: Offset(0, offset),
        child: Tile(
          height: tileHeight,
          width: tileWidth,
          state: note.state,
          onTap: () => onTileTap(note),
          key: GlobalKey(),
        ),
      );
    }).toList();

    return SizedBox.expand(
      child: Stack(
        children: tiles,
      ),
    );
  }
}
