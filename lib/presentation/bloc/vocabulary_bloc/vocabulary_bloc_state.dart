import 'package:english_app/domain/entities/word_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

abstract class VocabularyBlocState extends Equatable {
  const VocabularyBlocState();

  @override
  List<Object> get props => [];
}

class WordsLoaded extends VocabularyBlocState {
  const WordsLoaded({
    @required this.words,
  });

  final List<WordEntity> words;

  @override
  List<Object> get props => [words];
}
