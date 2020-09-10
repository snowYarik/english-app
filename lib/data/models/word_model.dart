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

  factory WordModel.fromJson({@required Map<String, dynamic> json}) {
    return WordModel(
        imagePath: json['image_path'],
        sentence: json['sentence'],
        status: json['status'],
        translation: json['translation'],
        word: json['word']);
  }

  final int id;
  final String word;
  final String translation;
  final String sentence;
  final String status;
  final String imagePath;

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
