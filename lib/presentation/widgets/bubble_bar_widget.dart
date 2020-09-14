import 'package:english_app/presentation/widgets/bubble_bar_item_widget.dart';
import 'package:flutter/material.dart';

class BubbleBarWidget extends StatelessWidget {
  const BubbleBarWidget({
    Key key,
    QuizType currentQuizType = QuizType.listening,
  })  : _currentQuizType = currentQuizType,
        super(key: key);

  final QuizType _currentQuizType;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
      child: Row(
        children: [
          Flexible(
            child: BubbleBarItemWidget(
              iconData: Icons.music_note,
              hasFocus: _currentQuizType == QuizType.listening,
            ),
          ),
          Flexible(
            child: BubbleBarItemWidget(
              iconData: Icons.book,
              hasFocus: _currentQuizType == QuizType.reading,
            ),
          ),
          Flexible(
            child: BubbleBarItemWidget(
              iconData: Icons.create,
              hasFocus: _currentQuizType == QuizType.writing,
            ),
          ),
          Flexible(
            child: BubbleBarItemWidget(
              iconData: Icons.mic,
              hasFocus: _currentQuizType == QuizType.speaking,
            ),
          ),
        ],
      ),
    );
  }
}

enum QuizType {
  listening,
  reading,
  writing,
  speaking,
}
