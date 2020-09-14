import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/presentation/widgets/quiz_tile_widget.dart';
import 'package:flutter/material.dart';

class QuizGridWidget extends StatelessWidget {
  const QuizGridWidget({
    Key key,
    @required List<WordEntity> words,
  })  : _words = words,
        super(key: key);

  final List<WordEntity> _words;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 1.2,
      shrinkWrap: true,
      padding: const EdgeInsets.all(0.0),
      children: List.generate(
        _words.length,
        (index) {
          final word = _words[index];
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: QuizTileWidget(word: word),
          );
        },
      ),
    );
  }
}
