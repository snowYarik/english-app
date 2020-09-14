import 'package:english_app/data/data_sources/word_local_data_source/i_word_local_data_source.dart';
import 'package:english_app/data/models/word_model.dart';
import 'package:english_app/domain/entities/word_entity.dart';
import 'package:english_app/domain/repository/i_vocabulary_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:sembast/sembast.dart';

@Injectable(as: IVocabularyRepository)
class VocabulatyRepository extends IVocabularyRepository {
  const VocabulatyRepository({
    @required IWordLocalDataSource wordLocalDataSource,
  }) : _wordLocalDataSource = wordLocalDataSource;

  final IWordLocalDataSource _wordLocalDataSource;

  @override
  Future<List<WordEntity>> getWords({Finder finder}) async {
    final words = await _wordLocalDataSource.getWords(finder: finder);
    return words.map((e) => WordEntity.fromWordModel(wordModel: e)).toList();
  }

  @override
  Future<void> updateWord({@required WordEntity wordEntity}) {
    return _wordLocalDataSource.updateWord(
        wordModel: WordModel.fromWordEntity(wordEntity: wordEntity));
  }

  @override
  Future<int> getWordsCount() {
    return _wordLocalDataSource.getWordsCount();
  }
}
