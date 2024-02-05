import 'package:flutter/material.dart';
import 'package:my_playground/features/piano_tiles/domain/entities/note.dart';

class Tile extends StatelessWidget {
  final double height;
  final double width;
  final NoteState state;
  final VoidCallback onTap;

  const Tile(
      {required Key key,
      required this.height,
      required this.width,
      required this.state,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => onTap(),
      child: Container(
        width: width,
        height: height,
        color: state == NoteState.tapped ? Colors.transparent : Colors.black,
      ),
    );
  }
}
