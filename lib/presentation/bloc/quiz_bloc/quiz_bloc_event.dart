import 'package:english_app/domain/entities/word_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/animation.dart';
import 'package:flutter/foundation.dart';

abstract class QuizBlocEvent extends Equatable {
  const QuizBlocEvent();

  @override
  List<Object> get props => [];
}

class InitQuiz extends QuizBlocEvent {}

class GiveAnswer extends QuizBlocEvent {
  const GiveAnswer({
    @required this.word,
    @required this.controller,
  });

  final WordEntity word;
  final AnimationController controller;

  @override
  List<Object> get props => [word, controller];
}
