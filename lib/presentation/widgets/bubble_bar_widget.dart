import 'package:english_app/presentation/widgets/bubble_bar_item_widget.dart';
import 'package:flutter/material.dart';

class BubbleBarWidget extends StatelessWidget {
  const BubbleBarWidget({Key key, QuizType currentQuizType})
      : _currentQuizType = currentQuizType,
        super(key: key);

  final QuizType _currentQuizType;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          BubbleBarItemWidget(
            iconData: Icons.music_note,
            hasFocus: _currentQuizType == QuizType.listening,
          ),
          BubbleBarItemWidget(
            iconData: Icons.book,
            hasFocus: _currentQuizType == QuizType.reading,
          ),
          BubbleBarItemWidget(
            iconData: Icons.create,
            hasFocus: _currentQuizType == QuizType.writing,
          ),
          BubbleBarItemWidget(
            iconData: Icons.mic,
            hasFocus: _currentQuizType == QuizType.speaking,
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
