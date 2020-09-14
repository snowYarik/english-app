import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/domain/entities/word_status.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class WordModel extends Equatable {
  const WordModel({
    this.id,
    @required this.word,
    @required this.translation,
    @required this.sentence,
    @required this.status,
    @required this.imagePath,
  });

  factory WordModel.fromJson(
      {@required Map<String, dynamic> json, @required int id}) {
    return WordModel(
        id: id,
        imagePath: json['image_path'],
        sentence: json['sentence'],
        status: json['status'],
        translation: json['translation'],
        word: json['word']);
  }

  factory WordModel.fromWordEntity({@required WordEntity wordEntity}) {
    return WordModel(
        id: wordEntity.id,
        imagePath: wordEntity.imagePath,
        sentence: wordEntity.sentence,
        status: wordEntity.status.statusString,
        translation: wordEntity.translation,
        word: wordEntity.word);
  }

  final int id;
  final String word;
  final String translation;
  final String sentence;
  final String status;
  final String imagePath;

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'translation': translation,
      'sentence': sentence,
      'status': status,
      'image_path': imagePath,
    };
  }

  @override
  List<Object> get props => [
        id,
        word,
        translation,
        sentence,
        status,
        imagePath,
      ];
}
