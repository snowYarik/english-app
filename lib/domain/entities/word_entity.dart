import 'package:english_app/presentation/widgets/vocabulary_tile_widget.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class ModelEntity extends Equatable {
  ModelEntity({
    @required this.id,
    @required this.word,
    @required this.translate,
    @required this.sentence,
    @required this.status,
    @required this.imagePath,
  });

  final int id;
  final String word;
  final String translate;
  final String sentence;
  final WordStatus status;
  final String imagePath;

  @override
  List<Object> get props => [id, word, translate, sentence, status, imagePath];
}

enum WordStatus {
  unused,
  success,
  error,
}
