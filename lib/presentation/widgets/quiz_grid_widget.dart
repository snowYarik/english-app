import 'package:english_app/presentation/widgets/quiz_tile_widget.dart';
import 'package:flutter/material.dart';

class QuizGridWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      children: List.generate(
        0,
        (index) => QuizTileWidget(imagePath: null, word: null),
      ),
    );
  }
}
