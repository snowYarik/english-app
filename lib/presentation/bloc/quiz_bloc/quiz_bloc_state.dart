import 'package:english_app/domain/entities/word_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class QuizBlocState extends Equatable {
  const QuizBlocState({
    @required this.currentWord,
    @required this.quizWords,
  });

  final WordEntity currentWord;
  final List<WordEntity> quizWords;

  @override
  List<Object> get props => [currentWord, quizWords];
}

class Inited extends QuizBlocState {
  const Inited({
    @required WordEntity currentWord,
    @required List<WordEntity> quizWords,
  }) : super(currentWord: currentWord, quizWords: quizWords);

  @override
  List<Object> get props => [currentWord, quizWords];
}

class Success extends QuizBlocState {
  const Success({
    @required WordEntity currentWord,
    @required List<WordEntity> quizWords,
  }) : super(currentWord: currentWord, quizWords: quizWords);

  @override
  List<Object> get props => [currentWord, quizWords];
}

class Mistake extends QuizBlocState {
  const Mistake({
    @required WordEntity currentWord,
    @required List<WordEntity> quizWords,
  }) : super(currentWord: currentWord, quizWords: quizWords);

  @override
  List<Object> get props => [currentWord, quizWords];
}

class QuizEnded extends QuizBlocState {
  const QuizEnded({
    @required this.scoreInPercent,
    @required this.congratulation,
  });

  final int scoreInPercent;
  final String congratulation;

  @override
  List<Object> get props => [scoreInPercent, congratulation];
}
