import 'package:copyable/copyable.dart';
import 'package:english_app/data/models/word_model.dart';
import 'package:english_app/domain/entities/word_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class WordEntity extends Equatable implements Copyable<WordEntity> {
  const WordEntity({
    @required this.id,
    @required this.word,
    @required this.translation,
    @required this.sentence,
    @required this.status,
    @required this.imagePath,
  });

  factory WordEntity.fromWordModel({@required WordModel wordModel}) {
    return WordEntity(
        id: wordModel.id,
        word: wordModel.word,
        translation: wordModel.translation,
        sentence: wordModel.sentence,
        status: wordStatusfromString(wordStatusToString: wordModel.status),
        imagePath: wordModel.imagePath);
  }

  final int id;
  final String word;
  final String translation;
  final String sentence;
  final WordStatus status;
  final String imagePath;

  @override
  List<Object> get props =>
      [id, word, translation, sentence, status, imagePath];

  @override
  WordEntity copy() {
    return null;
  }

  @override
  WordEntity copyWith({@required WordStatus wordStatus}) {
    return WordEntity(
        id: id,
        word: word,
        translation: translation,
        sentence: sentence,
        status: wordStatus,
        imagePath: imagePath);
  }

  @override
  WordEntity copyWithMaster(WordEntity master) {
    return null;
  }
}
