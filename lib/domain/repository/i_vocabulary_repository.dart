import 'package:english_app/domain/entities/word_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:sembast/sembast.dart';

abstract class IVocabularyRepository {
  const IVocabularyRepository();

  Future<List<WordEntity>> getWords({Finder finder});
  Future<void> updateWord({@required WordEntity wordEntity});
  Future<int> getWordsCount();

}
